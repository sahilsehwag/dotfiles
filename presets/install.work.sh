#!/usr/bin/env bash

if F_isMac; then
	xcode-select –-install
	setup=(brew)
fi

sudo chown -R $(whoami) ~/.local
chmod -R 777 ~/.local

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
tools=(broot fasd sad)
fonts=(fira-code)
# kanata (kmonad alternative)
apps=(fzf zsh tmux nvim vifm lazygit kmonad)
misc=(terminfo)
mac=(
	alacritty #warp
    kitty
	#kindavim #svim #macos wide vim emulation
	aerospace #yabai
	notion
	alfred
)
gui=(
	# espanso
)

F_install ${setup[@]} ${base[@]} ${git[@]} ${dev[@]} ${utils[@]} ${data[@]} ${alts[@]} ${tools[@]} ${fonts[@]} ${apps[@]} ${misc[@]}

if F_isMac; then
	F_install ${mac[@]}
fi

if ! F_isSoftlink "$HOME/Documents/projects/personal/mani.yml"; then
	ln -sv "$DOTFILES_ROOT/configs/mani.yaml" "$HOME/Documents/projects/personal/mani.yml"
	if F_isFile "$HOME/.tokens"; then
		mani sync
	fi
fi

# since mac already has zsh installed
if F_isMac; then
	source "$DOTFILES_ROOT/packages/zsh/install.sh"
fi
