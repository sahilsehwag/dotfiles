source $DOTFILES_ROOT/custom/install.sh

if F_isMac; then
	xcode-select –install
	setup=(brew)
elif F_isWindows || F_isWSL; then
	setup=(scoop choco)
else
	setup=()
fi


base=(curl wget make cmake gcc g++)
git=(git gh glab mani git-workspace)
dev=(python go rust node lua)
utils=(rg fd fzf sd choose path-extractor up redo yank grex)
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
fonts=(fira-code font-hack-nerd-font)
# kanata (kmonad alternative)
apps=(kmonad zsh tmux mprocs nvim vifm lazygit)
misc=(terminfo git-sim)

F_install ${setup[@]} ${base[@]} ${git[@]} ${dev[@]} ${utils[@]} ${data[@]} ${alts[@]} ${tools[@]} ${fonts[@]} ${apps[@]} ${misc[@]} ${mac[@]} ${testing[@]}

if ! F_isSoftlink "$HOME/Documents/projects/personal/mani.yml"; then
	ln -sv "$DOTFILES_ROOT/configs/mani.yaml" "$HOME/Documents/projects/personal/mani.yml"
	if F_isFile "$HOME/.tokens"; then
		mani sync
	fi
fi
