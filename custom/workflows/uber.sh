# ==========================================
# SETUP
# ==========================================

alias usetup="jz install && jz update-flipr"
alias ureset="git checkout -- ./flipr && git checkout main && git pull origin main && usetup"

# ==========================================
# CHECKS
# ==========================================

alias ucvr="jz cover"

ucheck() {
  if [ -z "$TMUX" ]; then
    jz typecheck && jz lint --fix && jz test
    return
  fi
  local cwd
  cwd=$(pwd)
  tmux new-window -c "$cwd" -n "checks"
  tmux send-keys "jz typecheck" Enter
  tmux split-window -v -c "$cwd"
  tmux send-keys "jz lint --fix" Enter
  tmux split-window -v -c "$cwd"
  tmux send-keys "jz test" Enter
  tmux select-layout even-vertical
}

# ==========================================
# WORKFLOWS
# ==========================================

alias ureview="arh-review"
alias urebase="arh rebase --sync"
alias umerge="arh merge"
alias utidy="arh tidy"
alias usync="arh pull -r"

# ==========================================
# ARH
# ==========================================

ufeat() {
  local name="${1:-}"
  if [ -z "$name" ]; then
    read -r "name?Feature branch name: "
  fi
  [ -z "$name" ] && return 1
  arh feature "$name" "${@:2}"
}

uswitch() {
  local pr="${1:-}"
  if [ -z "$pr" ]; then
    read -r "pr?PR number or URL: "
  fi
  [ -z "$pr" ] && return 1
  arh checkout "$pr" "${@:2}"
}

alias urebase="arh rebase"
alias urebasesync="arh rebase --sync"
alias upublish="arh publish"
alias umerge="arh merge"
alias udrop="arh discard"

# ==========================================
# JZ
# ==========================================

alias jzi="jz install"
alias jzI="jz purge --async && jz install"
alias jza="jz typecheck && jz lint --fix && jz test"
alias jzc="jz typecheck"
alias jzl="jz lint --fix"
alias jzt="jz test"
alias jzT="jz test --changed"

# ==========================================
# DEV
# ==========================================

urun() {
  if [ -z "$TMUX" ]; then
    cerberus &
    jz dev
    return
  fi
  local cwd
  cwd=$(pwd)
  tmux new-window -c "$cwd" -n "run"
  tmux send-keys "cerberus" Enter
  tmux split-window -v -c "$cwd"
  tmux send-keys "jz dev" Enter
  tmux select-layout even-vertical
}

# ==========================================
# FRACTAL
# ==========================================

ufrun() {
  local fractal_dir
  fractal_dir=$(zoxide query fractal 2>/dev/null) || {
    echo "❌ Could not resolve fractal directory"
    return 1
  }
  if [ -z "$TMUX" ]; then
    (cd "$fractal_dir" && cerberus) &
    cd "$fractal_dir" && jz dev
    return
  fi
  tmux new-window -c "$fractal_dir" -n "fractal"
  tmux send-keys "cerberus" Enter
  tmux split-window -v -c "$fractal_dir"
  tmux send-keys "jz dev" Enter
  tmux select-layout even-vertical
}


# ==========================================
# PROJECTS
# ==========================================
alias cdopw="cd src/platform/gss/kwm-portals/operator-portal-web"
alias cdnpw="cd src/platform/gss/kwm-portals/nexus-portal-web"
alias cdsh="cd src/platform/gss/kwm-portals/supplier-hub"
