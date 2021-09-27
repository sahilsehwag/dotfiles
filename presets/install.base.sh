source $SCRIPTS_CORE/install.sh
source $SCRIPTS_ROOT/base/install.sh
source $SCRIPTS_ROOT/custom/install.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
	setup=(brew)
elif [[ $(uname -r) =~ 'WSL' ]]; then
	setup=(scoop choco)
else
	setup=()
fi

base=(curl wget make cmake gcc g++ git)
dev=(python go rust node lua)
utils=(ripgrep fd fzf sd choose path-extractor up redo yank grex)
testing=(sregx srex)
data=(yq jq gron jc jo)
alts=(
	sshs
	bat
	exa
	erdtree
	dust
	duf
	procs
	hyperfine
	navi

	btop
	vtop

	httpie
	curlie
	gping

	delta
	difftastic
	diffsitter
)
tools=(broot fasd sad)
fonts=()
apps=(kmonad zsh tmux mprocs neovim vifm lazygit)
misc=(terminfo)

F_install ${setup[@]} ${base[@]} ${dev[@]} ${utils[@]} ${testing[@]} ${data[@]} ${alts[@]} ${tools[@]} ${fonts[@]} ${apps[@]} ${misc[@]}
