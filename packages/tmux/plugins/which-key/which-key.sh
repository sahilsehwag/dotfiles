#!/usr/bin/env bash
# which-key.sh — which-key.nvim style keybindings for tmux
# Usage: which-key.sh [namespace]
# Runs inside a tmux display-popup. Reads config, shows available keys,
# dispatches on keypress.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG="${SCRIPT_DIR}/which-key.conf"
PANE_PATH="${PANE_PATH:-$HOME}"
NAMESPACE="${1:-}"
USER_SHELL="${SHELL:-/bin/sh}"

# Plugin defaults (overridable via tmux options)
WK_WIDTH="${WK_WIDTH:-99%}"
WK_HEIGHT="${WK_HEIGHT:-25%}"
WK_BORDER_STYLE="${WK_BORDER_STYLE:-fg=brightblack}"
WK_TITLE="${WK_TITLE:- Which Key }"

# If not already inside the popup, launch it
if [[ -z "${WK_INSIDE_POPUP:-}" ]]; then
    WK_CMD_FILE=$(mktemp /tmp/which-key-cmd.XXXXXX)
    tmux display-popup -E \
        -w "$WK_WIDTH" -h "$WK_HEIGHT" -y S \
        -S "$WK_BORDER_STYLE" \
        -T "$WK_TITLE" \
        "WK_INSIDE_POPUP=1 WK_CMD_FILE=$WK_CMD_FILE PANE_PATH=$PANE_PATH $SCRIPT_DIR/which-key.sh $NAMESPACE"
    # After popup closes, execute the deferred command if any
    if [[ -s "$WK_CMD_FILE" ]]; then
        source "$WK_CMD_FILE"
    fi
    rm -f "$WK_CMD_FILE"
    exit 0
fi

# Determine read-one-char command for the user's shell
case "$(basename "$USER_SHELL")" in
    zsh)  READ_KEY="read -k1" ;;
    *)    READ_KEY="read -n1" ;;
esac

# Colors
KEY_COLOR="\033[1;36m"   # bold cyan
NS_COLOR="\033[1;33m"    # bold yellow
LABEL_COLOR="\033[0m"    # default
DIM_COLOR="\033[2m"      # dim
RESET="\033[0m"

get_entries() {
    local ns="$1"
    while IFS='|' read -r keys label cmd; do
        # Skip comments and blank lines
        [[ "$keys" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${keys// /}" ]] && continue

        keys="$(echo "$keys" | xargs)"
        label="$(echo "$label" | xargs)"
        cmd="$(echo "${cmd:-}" | xargs)"

        if [[ -z "$ns" ]]; then
            # Root level: entries with a single key (no spaces)
            [[ "$keys" == *" "* ]] && continue
            echo "${keys}|${label}|${cmd}"
        else
            # Namespace level: entries starting with ns prefix + space
            if [[ "$keys" == "$ns "* ]]; then
                local subkey="${keys#$ns }"
                # Only direct children (no further spaces)
                [[ "$subkey" == *" "* ]] && continue
                echo "${subkey}|${label}|${cmd}"
            fi
        fi
    done < "$CONFIG"
}

is_namespace() {
    local key="$1"
    local full_key
    if [[ -z "$NAMESPACE" ]]; then
        full_key="$key"
    else
        full_key="$NAMESPACE $key"
    fi
    # A key is a namespace if it has no command AND has children
    local has_children=false
    while IFS='|' read -r keys label cmd; do
        [[ "$keys" =~ ^[[:space:]]*# ]] && continue
        keys="$(echo "$keys" | xargs)"
        if [[ "$keys" == "$full_key "* ]]; then
            has_children=true
            break
        fi
    done < "$CONFIG"
    $has_children
}

get_namespace_label() {
    local ns="$1"
    [[ -z "$ns" ]] && return
    while IFS='|' read -r keys label cmd; do
        [[ "$keys" =~ ^[[:space:]]*# ]] && continue
        keys="$(echo "$keys" | xargs)"
        label="$(echo "$label" | xargs)"
        cmd="$(echo "${cmd:-}" | xargs)"
        if [[ "$keys" == "$ns" ]] && [[ -z "$cmd" ]]; then
            echo "$label"
            return
        fi
    done < "$CONFIG"
}

get_breadcrumb() {
    local ns="$1"
    [[ -z "$ns" ]] && return
    local parts=()
    local accumulated=""
    for key in $ns; do
        if [[ -z "$accumulated" ]]; then
            accumulated="$key"
        else
            accumulated="$accumulated $key"
        fi
        local label
        label="$(get_namespace_label "$accumulated")"
        parts+=("${label:-$key}")
    done
    local result=""
    for part in "${parts[@]}"; do
        if [[ -z "$result" ]]; then
            result="$part"
        else
            result="$result > $part"
        fi
    done
    echo "$result"
}

render() {
    clear
    if [[ -n "$NAMESPACE" ]]; then
        local breadcrumb
        breadcrumb="$(get_breadcrumb "$NAMESPACE")"
        printf "\n  ${NS_COLOR}${breadcrumb}${RESET}\n"
    fi
    printf "\n"

    local entries=()
    while IFS= read -r line; do
        [[ -n "$line" ]] && entries+=("$line")
    done < <(get_entries "$NAMESPACE")

    if [[ ${#entries[@]} -eq 0 ]]; then
        printf "  ${DIM_COLOR}No keys defined${RESET}\n"
        return
    fi

    # Calculate column width
    local max_width=0
    for entry in "${entries[@]}"; do
        IFS='|' read -r key label cmd <<< "$entry"
        local width=$(( ${#key} + ${#label} + 6 ))
        (( width > max_width )) && max_width=$width
    done

    local term_width
    term_width=$(tput cols 2>/dev/null || echo 80)
    local cols=$(( term_width / (max_width + 2) ))
    (( cols < 1 )) && cols=1

    local i=0
    for entry in "${entries[@]}"; do
        IFS='|' read -r key label cmd <<< "$entry"

        if [[ -z "$cmd" ]]; then
            printf "  ${NS_COLOR}%-2s${RESET} ${NS_COLOR}+%-*s${RESET} " "$key" "$((max_width - 5))" "$label"
        else
            printf "  ${KEY_COLOR}%-2s${RESET} %-*s   " "$key" "$((max_width - 5))" "$label"
        fi

        i=$((i + 1))
        if (( i % cols == 0 )); then
            printf "\n"
        fi
    done
    (( i % cols != 0 )) && printf "\n"
    printf "\n"
}

execute_cmd() {
    local cmd="$1"
    local prefix="${cmd:0:1}"
    local rest="${cmd:1}"

    case "$prefix" in
        "!")
            # Run in bottom popup
            rest="$(echo "$rest" | xargs)"
            echo "tmux display-popup -E -d \"$PANE_PATH\" -w 100% -h 40% -y S -S \"$WK_BORDER_STYLE\" \
                \"$USER_SHELL -ilc '${rest}; echo; echo \\\"Press any key...\\\"; ${READ_KEY}'\"" > "$WK_CMD_FILE"
            ;;
        ">")
            # Run in new window
            rest="$(echo "$rest" | xargs)"
            echo "tmux new-window -c \"$PANE_PATH\" \"$USER_SHELL -ilc '${rest}; ${READ_KEY}'\"" > "$WK_CMD_FILE"
            ;;
        "%")
            # Run in split pane
            rest="$(echo "$rest" | xargs)"
            echo "tmux split-window -v -c \"$PANE_PATH\" \"$USER_SHELL -ilc '${rest}; ${READ_KEY}'\"" > "$WK_CMD_FILE"
            ;;
        *)
            # Raw tmux command
            echo "tmux $cmd" > "$WK_CMD_FILE"
            ;;
    esac
}

main() {
    # Build lookup tables
    declare -A key_cmd
    declare -A key_ns

    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        IFS='|' read -r key label cmd <<< "$line"
        if [[ -n "$cmd" ]]; then
            key_cmd["$key"]="$cmd"
        elif is_namespace "$key"; then
            key_ns["$key"]=1
        fi
    done < <(get_entries "$NAMESPACE")

    render

    # Read single keypress
    local char
    IFS= read -rsn1 char

    # Handle escape — close entirely
    if [[ "$char" == $'\x1b' ]] || [[ "$char" == "q" ]]; then
        return 0
    fi

    # Handle backspace — go up one level
    if [[ "$char" == $'\x7f' ]] || [[ "$char" == $'\b' ]]; then
        if [[ -n "$NAMESPACE" ]]; then
            local parent="${NAMESPACE% *}"
            [[ "$parent" == "$NAMESPACE" ]] && parent=""
            NAMESPACE="$parent" main
        fi
        return 0
    fi

    if [[ -v key_cmd["$char"] ]]; then
        execute_cmd "${key_cmd[$char]}"
    elif [[ -v key_ns["$char"] ]]; then
        local new_ns
        if [[ -z "$NAMESPACE" ]]; then
            new_ns="$char"
        else
            new_ns="$NAMESPACE $char"
        fi
        NAMESPACE="$new_ns" main
    fi
}

main
