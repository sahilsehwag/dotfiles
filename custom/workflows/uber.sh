# STEPS
alias uinstall="jz install"
alias ube="cerberus"
alias ufe="jz dev"

# arc flow
# arc tidy
# arc cascade
# arc sync

alias utype="jz typecheck"
alias ulint="jz lint --fix"
alias utest="jz test"
alias ucvr="jz cover"

alias upr="git checkout -- ./flipr && arc diff HEAD^"
alias uprn="git checkout -- ./flipr && arc diff HEAD^ --create"
alias upru="git checkout -- ./flipr && arc diff HEAD^ --update"

# WORKFLOWS
alias usetup="uinstall && jz update-flipr"
alias ureset="git checkout -- ./flipr && git checkout main && git pull origin main && usetup"
alias ucheck="utype ulint utest"
alias ureview="arc-review"
alias urebase="arc-rebase"
alias umerge="arc-land"

# ===========
alias jzi="jz install"
alias jzI="jz purge --async && jz install"
alias jza="jz typecheck && jz lint --fix && jz test"
alias jzc="jz typecheck"
alias jzl="jz lint --fix"
alias jzt="jz test"
alias jzT="jz test --changed"

alias ad="arc diff"
alias adh="arc diff HEAD^"
alias al="arc land"

alias f7c="z fractal && cerberus"
alias f7d="z fractal && jz dev"
alias f7s="z fractal-studio && jz dev"

#alias f7o="f7c; tsv f7d; tsv f7s; tmux select-layout even-vertical"
