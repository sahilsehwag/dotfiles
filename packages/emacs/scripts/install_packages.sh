#!/usr/bin/env bash
#META
#EVIL
	[[ ! -d ~/.emacs.d/packages/evil                         ]] && git clone https://github.com/emacs-evil/evil/                      ~/.emacs.d/packages/evil
	[[ ! -d ~/.emacs.d/packages/evil-leader                  ]] && git clone https://github.com/cofi/evil-leader/                     ~/.emacs.d/packages/evil-leader
	[[ ! -d ~/.emacs.d/packages/evil-escape                  ]] && git clone https://github.com/syl20bnr/evil-escape/                 ~/.emacs.d/packages/evil-escape
	[[ ! -d ~/.emacs.d/packages/evil-surround                ]] && git clone https://github.com/emacs-evil/evil-surround/             ~/.emacs.d/packages/evil-surround
	[[ ! -d ~/.emacs.d/packages/evil-nerd-commenter          ]] && git clone https://github.com/redguardtoo/evil-nerd-commenter/      ~/.emacs.d/packages/evil-nerd-commenter
	[[ ! -d ~/.emacs.d/packages/evil-indent-plus             ]] && git clone https://github.com/TheBB/evil-indent-plus/               ~/.emacs.d/packages/evil-indent-plus
	[[ ! -d ~/.emacs.d/packages/evil-mc                      ]] && git clone https://github.com/gabesoft/evil-mc/                     ~/.emacs.d/packages/evil-mc
	[[ ! -d ~/.emacs.d/packages/evil-numbers                 ]] && git clone https://github.com/cofi/evil-numbers/                    ~/.emacs.d/packages/evil-numbers
	[[ ! -d ~/.emacs.d/packages/evil-textobj-column          ]] && git clone https://github.com/noctuid/evil-textobj-column/          ~/.emacs.d/packages/evil-textobj-column
	[[ ! -d ~/.emacs.d/packages/evil-textobj-entire          ]] && git clone https://github.com/supermomonga/evil-textobj-entire/     ~/.emacs.d/packages/evil-textobj-entire
	[[ ! -d ~/.emacs.d/packages/evil-textobj-line            ]] && git clone https://github.com/syohex/evil-textobj-line/             ~/.emacs.d/packages/evil-textobj-line
	[[ ! -d ~/.emacs.d/packages/evil-textobj-anyblock        ]] && git clone https://github.com/noctuid/evil-textobj-anyblock/        ~/.emacs.d/packages/evil-textobj-anyblock
	[[ ! -d ~/.emacs.d/packages/evil-matchit                 ]] && git clone https://github.com/redguardtoo/evil-matchit/             ~/.emacs.d/packages/evil-matchit
	[[ ! -d ~/.emacs.d/packages/evil-lion                    ]] && git clone https://github.com/edkolev/evil-lion/                    ~/.emacs.d/packages/evil-lion
	[[ ! -d ~/.emacs.d/packages/evil-args                    ]] && git clone https://github.com/wcsmith/evil-args/                    ~/.emacs.d/packages/evil-args
	[[ ! -d ~/.emacs.d/packages/evil-terminal-cursor-changer ]] && git clone https://github.com/7696122/evil-terminal-cursor-changer/ ~/.emacs.d/packages/evil-terminal-cursor-changer
	[[ ! -d ~/.emacs.d/packages/evil-vimish-fold             ]] && git clone https://github.com/alexmurray/evil-vimish-fold/          ~/.emacs.d/packages/evil-vimish-fold
	[[ ! -d ~/.emacs.d/packages/evil-org-mode                ]] && git clone https://github.com/Somelauw/evil-org-mode/               ~/.emacs.d/packages/evil-org-mode
	[[ ! -d ~/.emacs.d/packages/evil-tabs                    ]] && git clone https://github.com/krisajenkins/evil-tabs/               ~/.emacs.d/packages/evil-tabs
	[[ ! -d ~/.emacs.d/packages/evil-goggles                 ]] && git clone https://github.com/edkolev/evil-goggles/                 ~/.emacs.d/packages/evil-goggles
	[[ ! -d ~/.emacs.d/packages/evil-plugins                 ]] && git clone https://github.com/tarao/evil-plugins/                   ~/.emacs.d/packages/evil-plugins
	[[ ! -d ~/.emacs.d/packages/evil-exchange                ]] && git clone https://github.com/Dewdrops/evil-exchange                ~/.emacs.d/packages/evil-exchange
	[[ ! -d ~/.emacs.d/packages/evil-extra-operator          ]] && git clone https://github.com/Dewdrops/evil-extra-operator          ~/.emacs.d/packages/evil-extra-operator
	[[ ! -d ~/.emacs.d/packages/evil-jumper                  ]] && git clone https://github.com/bling/evil-jumper                     ~/.emacs.d/packages/evil-jumper
	[[ ! -d ~/.emacs.d/packages/evil-visualstar              ]] && git clone https://github.com/bling/evil-visualstar                 ~/.emacs.d/packages/evil-visualstar
	[[ ! -d ~/.emacs.d/packages/evil-snipe                   ]] && git clone https://github.com/hlissner/evil-snipe                   ~/.emacs.d/packages/evil-snipe
	[[ ! -d ~/.emacs.d/packages/linum-relative               ]] && git clone https://github.com/coldnew/linum-relative                ~/.emacs.d/packages/linum-relative
	[[ ! -d ~/.emacs.d/packages/vi-tilde-fringe              ]] && git clone https://github.com/syl20bnr/vi-tilde-fringe              ~/.emacs.d/packages/vi-tilde-fringe
#EMACS
	[[ ! -d ~/.emacs.d/packages/vimish-fold   ]] && git clone https://github.com/mrkkrp/vimish-fold/      ~/.emacs.d/packages/vimish-fold
	[[ ! -d ~/.emacs.d/packages/ace-jump-mode ]] && git clone https://github.com/winterTTr/ace-jump-mode/ ~/.emacs.d/packages/ace-jump-mode
	[[ ! -d ~/.emacs.d/packages/targets.el    ]] && git clone https://github.com/noctuid/targets.el/      ~/.emacs.d/packages/targets.el
	[[ ! -d ~/.emacs.d/packages/origami.el    ]] && git clone https://github.com/gregsexton/origami.el    ~/.emacs.d/packages/origami.el
#PRODUCTIVITY
	#might have to do brew install helm
	[[ ! -d ~/.emacs.d/packages/helm            ]] && git clone https://github.com/emacs-helm/helm ~/.emacs.d/packages/helm && cd ~/.emacs.d/packages/helm && sudo make install
	[[ ! -d ~/.emacs.d/packages/emacs-which-key ]] && git clone https://github.com/justbur/emacs-which-key ~/.emacs.d/packages/emacs-which-key
#DEVELOPMENT
	[[ ! -d ~/.emacs.d/packages/emacs-quickrun  ]] && git clone https://github.com/syohex/emacs-quickrun ~/.emacs.d/packages/emacs-quickrun
#LANGUAGES
	[[ ! -d ~/.emacs.d/packages/org-mode  ]] && git clone https://github.com/jwiegley/org-mode/ ~/.emacs.d/packages/org-mode
	[[ ! -d ~/.emacs.d/packages/vimscript ]] && git clone https://github.com/nverno/vimscript ~/.emacs.d/packages/vimscript
#LOOK & FEEL
	[[ ! -d ~/.emacs.d/packages/dashboard        ]] && git clone https://github.com/rakanalh/emacs-dashboard          ~/.emacs.d/packages/dashboard
	[[ ! -d ~/.emacs.d/packages/powerline        ]] && git clone https://github.com/milkypostman/powerline/           ~/.emacs.d/packages/powerline
	[[ ! -d ~/.emacs.d/packages/evil-powerline   ]] && git clone https://github.com/Dewdrops/powerline		           ~/.emacs.d/packages/evil-powerline
	[[ ! -d ~/.emacs.d/packages/airline-themes   ]] && git clone https://github.com/AnthonyDiGirolamo/airline-themes/ ~/.emacs.d/packages/airline-themes
	[[ ! -d ~/.emacs.d/packages/emacs-powerline  ]] && git clone https://github.com/jonathanchu/emacs-powerline/      ~/.emacs.d/packages/emacs-powerline
	[[ ! -d ~/.emacs.d/packages/spaceline        ]] && git clone https://github.com/TheBB/spaceline                   ~/.emacs.d/packages/spaceline
	#THEMES
		mkdir ~/.emacs.d/themes
		[[ ! -f ~/.emacs.d/themes/molokai-theme.el ]] && curl --create-dirs https://raw.githubusercontent.com/hbin/molokai-theme/master/molokai-theme.el > ~/.emacs.d/themes/molokai-theme.el
		[[ ! -f ~/.emacs.d/themes/dracula-theme.el ]] && curl --create-dirs https://raw.githubusercontent.com/dracula/emacs/master/dracula-theme.el      > ~/.emacs.d/themes/dracula-theme.el
#DEPENDENCIES
	[[ ! -d ~/.emacs.d/packages/page-break-lines ]] && git clone https://github.com/purcell/page-break-lines ~/.emacs.d/packages/page-break-lines
	[[ ! -d ~/.emacs.d/packages/goto-chg         ]] && git clone https://github.com/emacs-evil/goto-chg      ~/.emacs.d/packages/goto-chg
	[[ ! -d ~/.emacs.d/packages/undo-tree        ]] && git clone https://github.com/emacsmirror/undo-tree    ~/.emacs.d/packages/undo-tree
	[[ ! -d ~/.emacs.d/packages/emacs-async      ]] && git clone https://github.com/jwiegley/emacs-async    ~/.emacs.d/packages/emacs-async
	[[ ! -d ~/.emacs.d/packages/popup-el         ]] && git clone https://github.com/auto-complete/popup-el    ~/.emacs.d/packages/popup-el
#LIBRARIES
	[[ ! -d ~/.emacs.d/packages/dash.el ]] && git clone https://github.com/magnars/dash.el ~/.emacs.d/packages/dash.el
	[[ ! -d ~/.emacs.d/packages/f.el    ]] && git clone https://github.com/rejeep/f.el     ~/.emacs.d/packages/f.el
	[[ ! -d ~/.emacs.d/packages/s.el    ]] && git clone https://github.com/magnars/s.el    ~/.emacs.d/packages/s.el
