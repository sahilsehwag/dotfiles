#!usr/bin/env bash
/usr/bin/env bash "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git             ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone           https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone           https://github.com/zsh-users/zsh-autosuggestions         ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone           https://github.com/joshskidmore/zsh-fzf-history-search   ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone           https://github.com/olets/zsh-abbr                        ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-abbr
git clone           https://github.com/QuarticCat/zsh-smartcache             ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-smartcache

script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
[[ ! -L $HOME/.zshrc ]] && ln -sv $script_directory/.zshrc $HOME/.zshrc
[[ ! -L ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/configs ]] && ln -sv $script_directory/plugins ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/configs

if [[ "$OSTYPE" == "darwin"* ]]; then
	source $script_directory/scripts/install.mac.sh
fi

chsh -s $(which zsh)
