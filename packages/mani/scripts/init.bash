# bash completion for mani                                 -*- shell-script -*-

__mani_debug()
{
    if [[ -n ${BASH_COMP_DEBUG_FILE:-} ]]; then
        echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
    fi
}

# Homebrew on Macs have version 1.3 of bash-completion which doesn't include
# _init_completion. This is a very minimal version of that function.
__mani_init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref "$@" cur prev words cword
}

__mani_index_of_word()
{
    local w word=$1
    shift
    index=0
    for w in "$@"; do
        [[ $w = "$word" ]] && return
        index=$((index+1))
    done
    index=-1
}

__mani_contains_word()
{
    local w word=$1; shift
    for w in "$@"; do
        [[ $w = "$word" ]] && return
    done
    return 1
}

__mani_handle_go_custom_completion()
{
    __mani_debug "${FUNCNAME[0]}: cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}"

    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local out requestComp lastParam lastChar comp directive args

    # Prepare the command to request completions for the program.
    # Calling ${words[0]} instead of directly mani allows to handle aliases
    args=("${words[@]:1}")
    # Disable ActiveHelp which is not supported for bash completion v1
    requestComp="MANI_ACTIVE_HELP=0 ${words[0]} __completeNoDesc ${args[*]}"

    lastParam=${words[$((${#words[@]}-1))]}
    lastChar=${lastParam:$((${#lastParam}-1)):1}
    __mani_debug "${FUNCNAME[0]}: lastParam ${lastParam}, lastChar ${lastChar}"

    if [ -z "${cur}" ] && [ "${lastChar}" != "=" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __mani_debug "${FUNCNAME[0]}: Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __mani_debug "${FUNCNAME[0]}: calling ${requestComp}"
    # Use eval to handle any environment variables and such
    out=$(eval "${requestComp}" 2>/dev/null)

    # Extract the directive integer at the very end of the output following a colon (:)
    directive=${out##*:}
    # Remove the directive
    out=${out%:*}
    if [ "${directive}" = "${out}" ]; then
        # There is not directive specified
        directive=0
    fi
    __mani_debug "${FUNCNAME[0]}: the completion directive is: ${directive}"
    __mani_debug "${FUNCNAME[0]}: the completions are: ${out}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        # Error code.  No completion.
        __mani_debug "${FUNCNAME[0]}: received error from custom completion go code"
        return
    else
        if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __mani_debug "${FUNCNAME[0]}: activating no space"
                compopt -o nospace
            fi
        fi
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __mani_debug "${FUNCNAME[0]}: activating no file completion"
                compopt +o default
            fi
        fi
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local fullFilter filter filteringCmd
        # Do not use quotes around the $out variable or else newline
        # characters will be kept.
        for filter in ${out}; do
            fullFilter+="$filter|"
        done

        filteringCmd="_filedir $fullFilter"
        __mani_debug "File filtering command: $filteringCmd"
        $filteringCmd
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        # Use printf to strip any trailing newline
        subdir=$(printf "%s" "${out}")
        if [ -n "$subdir" ]; then
            __mani_debug "Listing directories in $subdir"
            __mani_handle_subdirs_in_dir_flag "$subdir"
        else
            __mani_debug "Listing directories in ."
            _filedir -d
        fi
    else
        while IFS='' read -r comp; do
            COMPREPLY+=("$comp")
        done < <(compgen -W "${out}" -- "$cur")
    fi
}

__mani_handle_reply()
{
    __mani_debug "${FUNCNAME[0]}"
    local comp
    case $cur in
        -*)
            if [[ $(type -t compopt) = "builtin" ]]; then
                compopt -o nospace
            fi
            local allflags
            if [ ${#must_have_one_flag[@]} -ne 0 ]; then
                allflags=("${must_have_one_flag[@]}")
            else
                allflags=("${flags[*]} ${two_word_flags[*]}")
            fi
            while IFS='' read -r comp; do
                COMPREPLY+=("$comp")
            done < <(compgen -W "${allflags[*]}" -- "$cur")
            if [[ $(type -t compopt) = "builtin" ]]; then
                [[ "${COMPREPLY[0]}" == *= ]] || compopt +o nospace
            fi

            # complete after --flag=abc
            if [[ $cur == *=* ]]; then
                if [[ $(type -t compopt) = "builtin" ]]; then
                    compopt +o nospace
                fi

                local index flag
                flag="${cur%=*}"
                __mani_index_of_word "${flag}" "${flags_with_completion[@]}"
                COMPREPLY=()
                if [[ ${index} -ge 0 ]]; then
                    PREFIX=""
                    cur="${cur#*=}"
                    ${flags_completion[${index}]}
                    if [ -n "${ZSH_VERSION:-}" ]; then
                        # zsh completion needs --flag= prefix
                        eval "COMPREPLY=( \"\${COMPREPLY[@]/#/${flag}=}\" )"
                    fi
                fi
            fi

            if [[ -z "${flag_parsing_disabled}" ]]; then
                # If flag parsing is enabled, we have completed the flags and can return.
                # If flag parsing is disabled, we may not know all (or any) of the flags, so we fallthrough
                # to possibly call handle_go_custom_completion.
                return 0;
            fi
            ;;
    esac

    # check if we are handling a flag with special work handling
    local index
    __mani_index_of_word "${prev}" "${flags_with_completion[@]}"
    if [[ ${index} -ge 0 ]]; then
        ${flags_completion[${index}]}
        return
    fi

    # we are parsing a flag and don't have a special handler, no completion
    if [[ ${cur} != "${words[cword]}" ]]; then
        return
    fi

    local completions
    completions=("${commands[@]}")
    if [[ ${#must_have_one_noun[@]} -ne 0 ]]; then
        completions+=("${must_have_one_noun[@]}")
    elif [[ -n "${has_completion_function}" ]]; then
        # if a go completion function is provided, defer to that function
        __mani_handle_go_custom_completion
    fi
    if [[ ${#must_have_one_flag[@]} -ne 0 ]]; then
        completions+=("${must_have_one_flag[@]}")
    fi
    while IFS='' read -r comp; do
        COMPREPLY+=("$comp")
    done < <(compgen -W "${completions[*]}" -- "$cur")

    if [[ ${#COMPREPLY[@]} -eq 0 && ${#noun_aliases[@]} -gt 0 && ${#must_have_one_noun[@]} -ne 0 ]]; then
        while IFS='' read -r comp; do
            COMPREPLY+=("$comp")
        done < <(compgen -W "${noun_aliases[*]}" -- "$cur")
    fi

    if [[ ${#COMPREPLY[@]} -eq 0 ]]; then
        if declare -F __mani_custom_func >/dev/null; then
            # try command name qualified custom func
            __mani_custom_func
        else
            # otherwise fall back to unqualified for compatibility
            declare -F __custom_func >/dev/null && __custom_func
        fi
    fi

    # available in bash-completion >= 2, not always present on macOS
    if declare -F __ltrim_colon_completions >/dev/null; then
        __ltrim_colon_completions "$cur"
    fi

    # If there is only 1 completion and it is a flag with an = it will be completed
    # but we don't want a space after the =
    if [[ "${#COMPREPLY[@]}" -eq "1" ]] && [[ $(type -t compopt) = "builtin" ]] && [[ "${COMPREPLY[0]}" == --*= ]]; then
       compopt -o nospace
    fi
}

# The arguments should be in the form "ext1|ext2|extn"
__mani_handle_filename_extension_flag()
{
    local ext="$1"
    _filedir "@(${ext})"
}

__mani_handle_subdirs_in_dir_flag()
{
    local dir="$1"
    pushd "${dir}" >/dev/null 2>&1 && _filedir -d && popd >/dev/null 2>&1 || return
}

__mani_handle_flag()
{
    __mani_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    # if a command required a flag, and we found it, unset must_have_one_flag()
    local flagname=${words[c]}
    local flagvalue=""
    # if the word contained an =
    if [[ ${words[c]} == *"="* ]]; then
        flagvalue=${flagname#*=} # take in as flagvalue after the =
        flagname=${flagname%=*} # strip everything after the =
        flagname="${flagname}=" # but put the = back
    fi
    __mani_debug "${FUNCNAME[0]}: looking for ${flagname}"
    if __mani_contains_word "${flagname}" "${must_have_one_flag[@]}"; then
        must_have_one_flag=()
    fi

    # if you set a flag which only applies to this command, don't show subcommands
    if __mani_contains_word "${flagname}" "${local_nonpersistent_flags[@]}"; then
      commands=()
    fi

    # keep flag value with flagname as flaghash
    # flaghash variable is an associative array which is only supported in bash > 3.
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        if [ -n "${flagvalue}" ] ; then
            flaghash[${flagname}]=${flagvalue}
        elif [ -n "${words[ $((c+1)) ]}" ] ; then
            flaghash[${flagname}]=${words[ $((c+1)) ]}
        else
            flaghash[${flagname}]="true" # pad "true" for bool flag
        fi
    fi

    # skip the argument to a two word flag
    if [[ ${words[c]} != *"="* ]] && __mani_contains_word "${words[c]}" "${two_word_flags[@]}"; then
        __mani_debug "${FUNCNAME[0]}: found a flag ${words[c]}, skip the next argument"
        c=$((c+1))
        # if we are looking for a flags value, don't show commands
        if [[ $c -eq $cword ]]; then
            commands=()
        fi
    fi

    c=$((c+1))

}

__mani_handle_noun()
{
    __mani_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    if __mani_contains_word "${words[c]}" "${must_have_one_noun[@]}"; then
        must_have_one_noun=()
    elif __mani_contains_word "${words[c]}" "${noun_aliases[@]}"; then
        must_have_one_noun=()
    fi

    nouns+=("${words[c]}")
    c=$((c+1))
}

__mani_handle_command()
{
    __mani_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    local next_command
    if [[ -n ${last_command} ]]; then
        next_command="_${last_command}_${words[c]//:/__}"
    else
        if [[ $c -eq 0 ]]; then
            next_command="_mani_root_command"
        else
            next_command="_${words[c]//:/__}"
        fi
    fi
    c=$((c+1))
    __mani_debug "${FUNCNAME[0]}: looking for ${next_command}"
    declare -F "$next_command" >/dev/null && $next_command
}

__mani_handle_word()
{
    if [[ $c -ge $cword ]]; then
        __mani_handle_reply
        return
    fi
    __mani_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"
    if [[ "${words[c]}" == -* ]]; then
        __mani_handle_flag
    elif __mani_contains_word "${words[c]}" "${commands[@]}"; then
        __mani_handle_command
    elif [[ $c -eq 0 ]]; then
        __mani_handle_command
    elif __mani_contains_word "${words[c]}" "${command_aliases[@]}"; then
        # aliashash variable is an associative array which is only supported in bash > 3.
        if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
            words[c]=${aliashash[${words[c]}]}
            __mani_handle_command
        else
            __mani_handle_noun
        fi
    else
        __mani_handle_noun
    fi
    __mani_handle_word
}

_mani_check()
{
    last_command="mani_check"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_completion()
{
    last_command="mani_completion"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    must_have_one_noun+=("bash")
    must_have_one_noun+=("fish")
    must_have_one_noun+=("powershell")
    must_have_one_noun+=("zsh")
    noun_aliases=()
}

_mani_describe_projects()
{
    last_command="mani_describe_projects"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--edit")
    flags+=("-e")
    local_nonpersistent_flags+=("--edit")
    local_nonpersistent_flags+=("-e")
    flags+=("--paths=")
    two_word_flags+=("--paths")
    flags_with_completion+=("--paths")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-d")
    flags_with_completion+=("-d")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--paths")
    local_nonpersistent_flags+=("--paths=")
    local_nonpersistent_flags+=("-d")
    flags+=("--tags=")
    two_word_flags+=("--tags")
    flags_with_completion+=("--tags")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-t")
    flags_with_completion+=("-t")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--tags")
    local_nonpersistent_flags+=("--tags=")
    local_nonpersistent_flags+=("-t")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_describe_tasks()
{
    last_command="mani_describe_tasks"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--edit")
    flags+=("-e")
    local_nonpersistent_flags+=("--edit")
    local_nonpersistent_flags+=("-e")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_describe()
{
    last_command="mani_describe"

    command_aliases=()

    commands=()
    commands+=("projects")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("prj")
        aliashash["prj"]="projects"
        command_aliases+=("project")
        aliashash["project"]="projects"
    fi
    commands+=("tasks")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("task")
        aliashash["task"]="tasks"
        command_aliases+=("tsk")
        aliashash["tsk"]="tasks"
    fi

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_edit_project()
{
    last_command="mani_edit_project"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_edit_task()
{
    last_command="mani_edit_task"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_edit()
{
    last_command="mani_edit"

    command_aliases=()

    commands=()
    commands+=("project")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("pr")
        aliashash["pr"]="project"
        command_aliases+=("proj")
        aliashash["proj"]="project"
        command_aliases+=("projects")
        aliashash["projects"]="project"
    fi
    commands+=("task")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("tasks")
        aliashash["tasks"]="task"
        command_aliases+=("tsk")
        aliashash["tsk"]="task"
        command_aliases+=("tsks")
        aliashash["tsks"]="task"
    fi

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_exec()
{
    last_command="mani_exec"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--all")
    flags+=("-a")
    local_nonpersistent_flags+=("--all")
    local_nonpersistent_flags+=("-a")
    flags+=("--cwd")
    flags+=("-k")
    local_nonpersistent_flags+=("--cwd")
    local_nonpersistent_flags+=("-k")
    flags+=("--dry-run")
    local_nonpersistent_flags+=("--dry-run")
    flags+=("--ignore-errors")
    local_nonpersistent_flags+=("--ignore-errors")
    flags+=("--ignore-non-existing")
    local_nonpersistent_flags+=("--ignore-non-existing")
    flags+=("--omit-empty")
    local_nonpersistent_flags+=("--omit-empty")
    flags+=("--output=")
    two_word_flags+=("--output")
    flags_with_completion+=("--output")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-o")
    flags_with_completion+=("-o")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--output")
    local_nonpersistent_flags+=("--output=")
    local_nonpersistent_flags+=("-o")
    flags+=("--parallel")
    local_nonpersistent_flags+=("--parallel")
    flags+=("--paths=")
    two_word_flags+=("--paths")
    flags_with_completion+=("--paths")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-d")
    flags_with_completion+=("-d")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--paths")
    local_nonpersistent_flags+=("--paths=")
    local_nonpersistent_flags+=("-d")
    flags+=("--projects=")
    two_word_flags+=("--projects")
    flags_with_completion+=("--projects")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-p")
    flags_with_completion+=("-p")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--projects")
    local_nonpersistent_flags+=("--projects=")
    local_nonpersistent_flags+=("-p")
    flags+=("--silent")
    flags+=("-s")
    local_nonpersistent_flags+=("--silent")
    local_nonpersistent_flags+=("-s")
    flags+=("--tags=")
    two_word_flags+=("--tags")
    flags_with_completion+=("--tags")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-t")
    flags_with_completion+=("-t")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--tags")
    local_nonpersistent_flags+=("--tags=")
    local_nonpersistent_flags+=("-t")
    flags+=("--theme=")
    two_word_flags+=("--theme")
    flags_with_completion+=("--theme")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_gen()
{
    last_command="mani_gen"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--dir=")
    two_word_flags+=("--dir")
    flags_with_completion+=("--dir")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-d")
    flags_with_completion+=("-d")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--dir")
    local_nonpersistent_flags+=("--dir=")
    local_nonpersistent_flags+=("-d")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_help()
{
    last_command="mani_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_init()
{
    last_command="mani_init"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--auto-discovery")
    local_nonpersistent_flags+=("--auto-discovery")
    flags+=("--vcs=")
    two_word_flags+=("--vcs")
    flags_with_completion+=("--vcs")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--vcs")
    local_nonpersistent_flags+=("--vcs=")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_list_projects()
{
    last_command="mani_list_projects"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--headers=")
    two_word_flags+=("--headers")
    flags_with_completion+=("--headers")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--headers")
    local_nonpersistent_flags+=("--headers=")
    flags+=("--paths=")
    two_word_flags+=("--paths")
    flags_with_completion+=("--paths")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-d")
    flags_with_completion+=("-d")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--paths")
    local_nonpersistent_flags+=("--paths=")
    local_nonpersistent_flags+=("-d")
    flags+=("--tags=")
    two_word_flags+=("--tags")
    flags_with_completion+=("--tags")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-t")
    flags_with_completion+=("-t")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--tags")
    local_nonpersistent_flags+=("--tags=")
    local_nonpersistent_flags+=("-t")
    flags+=("--tree")
    local_nonpersistent_flags+=("--tree")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--output=")
    two_word_flags+=("--output")
    flags_with_completion+=("--output")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-o")
    flags_with_completion+=("-o")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--theme=")
    two_word_flags+=("--theme")
    flags_with_completion+=("--theme")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_list_tags()
{
    last_command="mani_list_tags"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--headers=")
    two_word_flags+=("--headers")
    flags_with_completion+=("--headers")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--headers")
    local_nonpersistent_flags+=("--headers=")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--output=")
    two_word_flags+=("--output")
    flags_with_completion+=("--output")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-o")
    flags_with_completion+=("-o")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--theme=")
    two_word_flags+=("--theme")
    flags_with_completion+=("--theme")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_list_tasks()
{
    last_command="mani_list_tasks"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--headers=")
    two_word_flags+=("--headers")
    flags_with_completion+=("--headers")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--headers")
    local_nonpersistent_flags+=("--headers=")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--output=")
    two_word_flags+=("--output")
    flags_with_completion+=("--output")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-o")
    flags_with_completion+=("-o")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--theme=")
    two_word_flags+=("--theme")
    flags_with_completion+=("--theme")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_list()
{
    last_command="mani_list"

    command_aliases=()

    commands=()
    commands+=("projects")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("pr")
        aliashash["pr"]="projects"
        command_aliases+=("proj")
        aliashash["proj"]="projects"
        command_aliases+=("project")
        aliashash["project"]="projects"
    fi
    commands+=("tags")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("tag")
        aliashash["tag"]="tags"
    fi
    commands+=("tasks")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("task")
        aliashash["task"]="tasks"
        command_aliases+=("tsk")
        aliashash["tsk"]="tasks"
        command_aliases+=("tsks")
        aliashash["tsks"]="tasks"
    fi

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--output=")
    two_word_flags+=("--output")
    flags_with_completion+=("--output")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-o")
    flags_with_completion+=("-o")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--theme=")
    two_word_flags+=("--theme")
    flags_with_completion+=("--theme")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_mani_run()
{
    last_command="mani_run"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--all")
    flags+=("-a")
    local_nonpersistent_flags+=("--all")
    local_nonpersistent_flags+=("-a")
    flags+=("--cwd")
    flags+=("-k")
    local_nonpersistent_flags+=("--cwd")
    local_nonpersistent_flags+=("-k")
    flags+=("--describe")
    local_nonpersistent_flags+=("--describe")
    flags+=("--dry-run")
    local_nonpersistent_flags+=("--dry-run")
    flags+=("--edit")
    flags+=("-e")
    local_nonpersistent_flags+=("--edit")
    local_nonpersistent_flags+=("-e")
    flags+=("--ignore-errors")
    local_nonpersistent_flags+=("--ignore-errors")
    flags+=("--ignore-non-existing")
    local_nonpersistent_flags+=("--ignore-non-existing")
    flags+=("--omit-empty")
    local_nonpersistent_flags+=("--omit-empty")
    flags+=("--output=")
    two_word_flags+=("--output")
    flags_with_completion+=("--output")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-o")
    flags_with_completion+=("-o")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--output")
    local_nonpersistent_flags+=("--output=")
    local_nonpersistent_flags+=("-o")
    flags+=("--parallel")
    local_nonpersistent_flags+=("--parallel")
    flags+=("--paths=")
    two_word_flags+=("--paths")
    flags_with_completion+=("--paths")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-d")
    flags_with_completion+=("-d")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--paths")
    local_nonpersistent_flags+=("--paths=")
    local_nonpersistent_flags+=("-d")
    flags+=("--projects=")
    two_word_flags+=("--projects")
    flags_with_completion+=("--projects")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-p")
    flags_with_completion+=("-p")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--projects")
    local_nonpersistent_flags+=("--projects=")
    local_nonpersistent_flags+=("-p")
    flags+=("--silent")
    flags+=("-s")
    local_nonpersistent_flags+=("--silent")
    local_nonpersistent_flags+=("-s")
    flags+=("--tags=")
    two_word_flags+=("--tags")
    flags_with_completion+=("--tags")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-t")
    flags_with_completion+=("-t")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--tags")
    local_nonpersistent_flags+=("--tags=")
    local_nonpersistent_flags+=("-t")
    flags+=("--theme=")
    two_word_flags+=("--theme")
    flags_with_completion+=("--theme")
    flags_completion+=("__mani_handle_go_custom_completion")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_sync()
{
    last_command="mani_sync"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--parallel")
    flags+=("-p")
    local_nonpersistent_flags+=("--parallel")
    local_nonpersistent_flags+=("-p")
    flags+=("--paths=")
    two_word_flags+=("--paths")
    flags_with_completion+=("--paths")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-d")
    flags_with_completion+=("-d")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--paths")
    local_nonpersistent_flags+=("--paths=")
    local_nonpersistent_flags+=("-d")
    flags+=("--status")
    flags+=("-s")
    local_nonpersistent_flags+=("--status")
    local_nonpersistent_flags+=("-s")
    flags+=("--sync-remotes")
    flags+=("-r")
    local_nonpersistent_flags+=("--sync-remotes")
    local_nonpersistent_flags+=("-r")
    flags+=("--tags=")
    two_word_flags+=("--tags")
    flags_with_completion+=("--tags")
    flags_completion+=("__mani_handle_go_custom_completion")
    two_word_flags+=("-t")
    flags_with_completion+=("-t")
    flags_completion+=("__mani_handle_go_custom_completion")
    local_nonpersistent_flags+=("--tags")
    local_nonpersistent_flags+=("--tags=")
    local_nonpersistent_flags+=("-t")
    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_mani_root_command()
{
    last_command="mani"

    command_aliases=()

    commands=()
    commands+=("check")
    commands+=("completion")
    commands+=("describe")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("desc")
        aliashash["desc"]="describe"
    fi
    commands+=("edit")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("e")
        aliashash["e"]="edit"
        command_aliases+=("ed")
        aliashash["ed"]="edit"
    fi
    commands+=("exec")
    commands+=("gen")
    commands+=("help")
    commands+=("init")
    commands+=("list")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("l")
        aliashash["l"]="list"
        command_aliases+=("ls")
        aliashash["ls"]="list"
    fi
    commands+=("run")
    commands+=("sync")
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        command_aliases+=("clone")
        aliashash["clone"]="sync"
    fi

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--config=")
    two_word_flags+=("--config")
    two_word_flags+=("-c")
    flags+=("--no-color")
    flags+=("--user-config=")
    two_word_flags+=("--user-config")
    two_word_flags+=("-u")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

__start_mani()
{
    local cur prev words cword split
    declare -A flaghash 2>/dev/null || :
    declare -A aliashash 2>/dev/null || :
    if declare -F _init_completion >/dev/null 2>&1; then
        _init_completion -s || return
    else
        __mani_init_completion -n "=" || return
    fi

    local c=0
    local flag_parsing_disabled=
    local flags=()
    local two_word_flags=()
    local local_nonpersistent_flags=()
    local flags_with_completion=()
    local flags_completion=()
    local commands=("mani")
    local command_aliases=()
    local must_have_one_flag=()
    local must_have_one_noun=()
    local has_completion_function=""
    local last_command=""
    local nouns=()
    local noun_aliases=()

    __mani_handle_word
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_mani mani
else
    complete -o default -o nospace -F __start_mani mani
fi

# ex: ts=4 sw=4 et filetype=sh
