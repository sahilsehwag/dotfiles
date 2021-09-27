if [[ $SHELL =~ 'zsh' ]]
then
	eval "$(zoxide init zsh)"
else
	eval "$(zoxide init bash)"
fi

#eval "$(zoxide init fish)"
