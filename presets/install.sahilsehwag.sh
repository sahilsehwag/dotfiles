#!/usr/bin/env bash
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
utils=(rg fd sd choose path-extractor up redo yank grex gnu-sed)
data=(yq jq gron jc jo)
alts=(
	sshs
	bat
	exa
	procs
	hyperfine
	delta
)
tools=(broot fasd sad zoxide)
fonts=(fira-code)
apps=(fzf zsh tmux nvim vifm lazygit kmonad)
misc=(terminfo)
mac=(
	alacritty
	yabai
	notion
	alfred
	google-chrome
	google-drive
	vlc
)

F_install ${setup[@]} ${base[@]} ${git[@]} ${dev[@]} ${utils[@]} ${data[@]} ${alts[@]} ${tools[@]} ${fonts[@]} ${apps[@]} ${misc[@]} ${mac[@]} ${testing[@]}

if ! F_isSoftlink "$HOME/Documents/projects/personal/mani.yml"; then
	ln -sv "$DOTFILES_ROOT/configs/mani.yaml" "$HOME/Documents/projects/personal/mani.yml"
	if F_isFile "$HOME/.tokens"; then
		mani sync
	fi
fi

