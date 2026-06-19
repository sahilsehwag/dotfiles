#!/usr/bin/env bash
source $DOTFILES_ROOT/custom/install.sh

if F_isMac; then
	xcode-select –-install
	setup=(brew)
elif F_isWindows || F_isWSL; then
	setup=(scoop choco)
else
	setup=()
fi

sudo chown -R $(whoami) ~/.local
chmod -R 777 ~/.local

base=(curl wget make cmake gcc g++)
git=(git gh glab mani git-workspace)
dev=(python go rust node lua pipx nvm)
utils=(rg fd sd choose path-extractor up redo yank grex gnu-sed)
testing=(sregx srex ast-grep)
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
fonts=(font-fira-code)
# kanata (kmonad alternative)
apps=(fzf zsh tmux nvim vifm lazygit kanata pi)
misc=(terminfo)
ai=(cursor cursor-agent claude opencode agent-browser oh-my-pi fallow)
skills=(visual-plan visual-recap mattpocock-skills plannotator)
mcps=(chrome-devtools-mcp)
mac=(
	alacritty #warp
	#kindavim #svim #macos wide vim emulation
	aerospace #yabai
	notion
	notion-mail
	alfred
	vscode
	google-chrome
	google-drive
	vlc
)
gui=(
	espanso
)

F_install ${setup[@]} ${base[@]} ${git[@]} ${dev[@]} ${utils[@]} ${data[@]} ${testing[@]} ${alts[@]} ${tools[@]} ${fonts[@]} ${apps[@]} ${misc[@]} ${skills[@]} ${mcps[@]}

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
