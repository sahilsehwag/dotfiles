# ==========================================
# SETUP
# ==========================================

alias uinstall="jz install"
alias usetup="uinstall && jz update-flipr"
alias ureset="git checkout -- ./flipr && git checkout main && git pull origin main && usetup"

# ==========================================
# CHECKS
# ==========================================

alias utype="jz typecheck"
alias ulint="jz lint --fix"
alias utest="jz test"
alias ucvr="jz cover"
alias ucheck="utype && ulint && utest"

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

alias aft="arh feature"
alias ap="arh publish"
alias aco="arh checkout"
alias arb="arh rebase"
alias ars="arh rebase --sync"
alias am="arh merge"
alias adf="arh discard"

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

alias ube="cerberus"
alias ufe="jz dev"

alias f7c="z fractal && cerberus"
alias f7d="z fractal && jz dev"
alias f7s="z fractal-studio && jz dev"
