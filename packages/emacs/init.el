;NOT TO TOUCH
	(require 'package)
	(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
	(package-initialize)
;PACKAGES
		;DEPENDENCIES
		;PAGE-BREAK-LINES
			;(turn-on-page-break-lines-mode)
		;EMACS-ASYNC
			(add-to-list 'load-path "~/.emacs.d/packages/emacs-async")
		;POPUP-EL
			(add-to-list 'load-path "~/.emacs.d/packages/popup-el")
	;LIBRARIES
		;DASH
			(add-to-list 'load-path "~/.emacs.d/packages/dash.el")
			(require 'dash)
		;S
			(add-to-list 'load-path "~/.emacs.d/packages/s.el")
			(require 's)
		;F
			(add-to-list 'load-path "~/.emacs.d/packages/f.el")
			(require 'f)
	;EMACS
		;ORIGAMI
			;(add-to-list 'load-path "~/.emacs.d/packages/origami.el")
			;(require 'origami)
			;(global-origami-mode 1)
		;VIMISH-FOLD
			(add-to-list 'load-path "~/.emacs.d/packages/vimish-fold")
			(require 'vimish-fold)
			(vimish-fold-global-mode 1)
		;WHICH-KEY
			(add-to-list 'load-path "~/.emacs.d/packages/emacs-which-key")
			(require 'which-key)
			(which-key-mode)
			(setq which-key-idle-delay 0)
			(setq which-key-allow-evil-operators t)
			(setq which-key-show-operator-state-maps t)
			;(which-key-setup-minibuffer)
			;(setq which-key-popup-type 'minibuffer)
				;'minibuffer
				;'frame
				;'side-window
			;(setq which-key-side-window-location 'bottom)
				;'bottom
				;'top
				;'left
				;'right
			;(setq which-key-side-window-max-width 0.33)
			;(setq which-key-side-window-max-height 0.25)
			;(setq which-key-frame-max-width 60)
			;(setq which-key-frame-max-height 20)
	;EVIL
		;EVIL-MODE
			;CONFIGURATION
				(add-to-list 'load-path "~/.emacs.d/packages/evil")
				(require 'evil)
				(evil-mode 1)
				(setq evil-normal-state-modes
					(append evil-insert-state-modes
							evil-normal-state-modes))
				(setq evil-motion-state-modes
					(append evil-emacs-state-modes
							evil-motion-state-modes))
			;SETTINGS
				(setq evil-auto-indent t)
				(setq evil-shift-width 4)
				(setq evil-tab-stop 4)
			;REMAPPINGS
			;MAPPINGS
				;EVIL
					(define-key evil-normal-state-map ";" 'evil-ex)
				;OPERATORS
					;NERD-COMMENTER
						(define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
						(define-key evil-normal-state-map "gC" 'evilnc-copy-and-comment-operator)
				;TEXT-OBJECTS
					;INDENT-OBJECT
						(define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
						(define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
						(define-key evil-inner-text-objects-map "I" 'evil-indent-plus-i-indent-up)
						(define-key evil-outer-text-objects-map "I" 'evil-indent-plus-a-indent-up)
						(define-key evil-inner-text-objects-map "j" 'evil-indent-plus-i-indent-up-down)
						(define-key evil-outer-text-objects-map "j" 'evil-indent-plus-a-indent-up-down)
					;EVIL-NERD-COMMENTER
						(define-key evil-inner-text-objects-map "k" 'evilnc-comment-text-object)
						(define-key evil-outer-text-objects-map "k" 'evilnc-comment-text-object)
					;TEXTOBJ-COLUMN
						;(define-key evil-inner-text-objects-map "k" 'evil-textobj-column-word)
						;(define-key evil-inner-text-objects-map "K" 'evil-textobj-column-WORD)
					;EVIL-ARGS
						(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
						(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
					;EVIL-TEXTOBJ-ENTIRE
						(define-key evil-inner-text-objects-map "e" 'evil-entire-entire-buffer)
						(define-key evil-outer-text-objects-map "e" 'evil-entire-entire-buffer)
				;WINDOWS
					(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
					(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
					(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
					(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
				;BUFFER
					(define-key evil-normal-state-map "H" 'evil-prev-buffer)
					(define-key evil-normal-state-map "L" 'evil-next-buffer)
				;EVIL-NUMBERS
					(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
					(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
				;FOLDING
					;(define-key evil-normal-state-map "za" 'origami-forward-toggle-node)
					;(define-key evil-normal-state-map "zR" 'origami-close-all-nodes)
					;(define-key evil-normal-state-map "zM" 'origami-open-all-nodes)
					;(define-key evil-normal-state-map "zr" 'origami-close-node-recursively)
					;(define-key evil-normal-state-map "zm" 'origami-open-node-recursively)
					;(define-key evil-normal-state-map "zo" 'origami-show-node)
					;(define-key evil-normal-state-map "zc" 'origami-close-node)
					;(define-key evil-normal-state-map "zj" 'origami-forward-fold)
					;(define-key evil-normal-state-map "zk" 'origami-previous-fold)
			;COMMANDS
		;EVIL-LEADER
			;CONFIGURATION
				(add-to-list 'load-path "~/.emacs.d/packages/evil-leader")
				(require 'evil-leader)
				(global-evil-leader-mode)
			;MAPPINGS
				(evil-leader/set-leader "<SPC>")
				(evil-leader/set-key
					;VIM
						"vq" 'evil-quit
						"vl" 'linum-relative-global-mode
					;BUFFERS
						"be" 'evil-edit
						"bw" 'evil-save
						"bn" 'evil-buffer-new
						"bd" 'evil-delete-buffer
						;"bD" 'kill-buffer-and-window
						"bl" 'list-buffers
					;WINDOWS
						"wc" 'evil-window-delete
						"wh" 'evil-window-new
						"wv" 'evil-window-vnew
					;JUMPING
						"jf" 'evil-ace-jump-char-mode
						"jt" 'evil-ace-jump-char-to-mode
						"jw" 'evil-ace-jump-word-mode
						"jl" 'evil-ace-jump-line-mode
					;COMMENTS
						"cc" 'evilnc-comment-or-uncomment-lines
						"cy" 'evilnc-copy-and-comment-lines
					;NAVIGATION
						"nf" 'find-file)
		;VI-TILDE-FRINGE
			(add-to-list 'load-path "~/.emacs.d/packages/vi-tilde-fringe")
			(require 'vi-tilde-fringe)
			(global-vi-tilde-fringe-mode)
		;EVIL-SURROUND
			(add-to-list 'load-path "~/.emacs.d/packages/evil-surround")
			(require 'evil-surround)
			(global-evil-surround-mode 1)
		;EVIL-NERD-COMMENTER
			(add-to-list 'load-path "~/.emacs.d/packages/evil-nerd-commenter")
			(require 'evil-nerd-commenter)
		;EVIL-INDENT-PLUS
			(add-to-list 'load-path "~/.emacs.d/packages/evil-indent-plus")
			(require 'evil-indent-plus)
		;EVIL-ESCAPE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-escape")
			(require 'evil-escape)
			(setq-default evil-escape-key-sequence "hl")
		;EVIL-NUMBERS
			(add-to-list 'load-path "~/.emacs.d/packages/evil-numbers")
			(require 'evil-numbers)
		;EVIL-TEXTOBJ-COLUMN
			;(add-to-list 'load-path "~/.emacs.d/packages/evil-textobj-column")
			;(require 'evil-textobj-column)
		;EVIL-TEXTOBJ-LINE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-textobj-line")
			(require 'evil-textobj-line)
		;EVIL-TEXTOBJ-ENTIRE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-textobj-entire")
			(require 'evil-textobj-entire)
		;EVIL-TEXTOBJ-ANYBLOCK
			(add-to-list 'load-path "~/.emacs.d/packages/evil-textobj-anyblock")
			(require 'evil-textobj-anyblock)
		;EVIL-MC
			(add-to-list 'load-path "~/.emacs.d/packages/evil-mc")
			(require 'evil-mc)
			(global-evil-mc-mode 1)
		;EVIL-MATCHIT
			(add-to-list 'load-path "~/.emacs.d/packages/evil-matchit")
			(require 'evil-matchit)
			(global-evil-matchit-mode 1)
		;EVIL-ORG-MODE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-org-mode")
			(require 'evil-org)
			(add-hook 'org-mode-hook 'evil-org-mode)
			(evil-org-set-key-theme '(navigation insert textobjects additional))
		;EVIL-GOOGLES
			(add-to-list 'load-path "~/.emacs.d/packages/evil-goggles")
			(require 'evil-goggles)
			(evil-goggles-mode)

			(setq evil-goggles-duration 0.100)
			(custom-set-faces
				'(evil-goggles-delete-face ((t (:inherit 'shadow))))
				'(evil-goggles-paste-face ((t (:inherit 'lazy-highlight))))
				'(evil-goggles-yank-face ((t (:inherit 'isearch-fail)))))
		;EVIL-TABS
			;(add-to-list 'load-path "~/.emacs.d/packages/evil-tabs")
			;(require 'evil-tabs)
			;(global-evil-tabs-mode t)
		;EVIL-PLUGINS
			(add-to-list 'load-path "~/.emacs.d/packages/evil-plugins")
			(require 'evil-textobj-between)
			(require 'evil-operator-comment)
				(global-evil-operator-comment-mode 1)
			;(require 'evil-little-word)
			;(require 'evil-relative-linum)
			;(require 'evil-mode-line)
		;EVIL-LION
			(add-to-list 'load-path "~/.emacs.d/packages/evil-lion")
			(require 'evil-lion)
			(setq evil-lion-left-align-key (kbd "g a"))
			(setq evil-lion-right-align-key (kbd "g A"))
			(evil-lion-mode)
		;EVIL-ARGS
			(add-to-list 'load-path "~/.emacs.d/packages/evil-args")
			(require 'evil-args)
		;EVIL-TERMINAL-CURSOR-CHANGER
			;(add-to-list 'load-path "~/.emacs.d/packages/evil-terminal-cursor-changer")
			;(require 'evil-terminal-cursor-changer)
			;(setq evil-motion-state-cursor 'box)
			;(setq evil-visual-state-cursor 'box)
			;(setq evil-normal-state-cursor 'box)
			;(setq evil-insert-state-cursor 'bar)
			;(setq evil-emacs-state-cursor  'hbar)
		;EVIL-VIMISH-FOLD
			(add-to-list 'load-path "~/.emacs.d/packages/evil-vimish-fold")
			(require 'evil-vimish-fold)
			(evil-vimish-fold-mode 1)
		;LINUM-RELATIVE
			(add-to-list 'load-path "~/.emacs.d/packages/linum-relative")
			(require 'linum-relative)
			(linum-on)
		;EVIL-SNIPE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-snipe")
			(require 'evil-snipe)
		;EVIL-VISUALSTAR
			(add-to-list 'load-path "~/.emacs.d/packages/evil-visualstar")
			(require 'evil-visualstar)
		;EVIL-JUMPER
			(add-to-list 'load-path "~/.emacs.d/packages/evil-jumper")
			(require 'evil-jumper)
		;EVIL-EXTRA-OPERATOR
			(add-to-list 'load-path "~/.emacs.d/packages/evil-extra-operator")
			(require 'evil-extra-operator)
		;EVIL-EXCHANGE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-exchange")
			(require 'evil-exchange)
	;DEVELOPMENT
		;EMACS-QUICKRUN
			(add-to-list 'load-path "~/.emacs.d/packages/emacs-quickrun")
			(require 'quickrun)
	;LANGUAGES
		;ORG-MODE
			(add-to-list 'load-path "~/.emacs.d/packages/org-mode/lisp")
		;VIMSCRIPT
			(add-to-list 'load-path "~/.emacs.d/packages/vimscript")
			(require 'vimscript)
			(add-to-list 'auto-mode-alist '("\\.vim\\'" . vimscript-mode))
			(add-to-list 'auto-mode-alist '("\\.exrc\\'" . vimscript-mode))
			(add-to-list 'auto-mode-alist '("\\.vimrc\\'" . vimscript-mode))
		;PYTHON
		;C++
		;JAVA
		;C#
		;R
		;SCALA
		;GO
		;AHK
		;HASKELL
		;HTML
		;CSS
		;JAVASCRIPT
		;LATEX
		;MARKDOWN
		;PHP
		;RUBY
		;SHELL
		;TYPESCRIPT
		;CSV
	;EDITING
		;TARGETS.EL
			;(add-to-list 'load-path "~/.emacs.d/packages/targets.el")
			;(require 'targets.el)
	;PRODUCTIVITY
		;ACE-JUMP-MODE
			(add-to-list 'load-path "~/.emacs.d/packages/ace-jump-mode")
			(require 'ace-jump-mode)
		;HELM
			;(add-to-list 'load-path "~/.emacs.d/packages/helm")
			;(require 'helm-config)
	;LOOK & FEEL
		;EMACS-POWERLINE
			;(add-to-list 'load-path "~/.emacs.d/packages/emacs-powerline")
			;(require 'powerline)
		;POWERLINE
			(add-to-list 'load-path "~/.emacs.d/packages/powerline")
			;(add-to-list 'load-path "~/.emacs.d/packages/evil-powerline")
			(require 'powerline)
			(powerline-default-theme)
		;AIRLINE-THEMES
			(add-to-list 'load-path "~/.emacs.d/packages/airline-themes")
			(require 'airline-themes)
		;DASHBOARD
			(add-to-list 'load-path "~/.emacs.d/packages/dashboard")
			(require 'dashboard)
			(dashboard-setup-startup-hook)
			(setq dashboard-banner-logo-title "WELCOME to Evil Emacs!!!")
			(setq dashboard-startup-banner 'logo)
			(setq dashboard-items '(
				(recents   . 5)
				(bookmarks . 5)
				;(projects  . 5)
				;(agenda    . 5)
				(registers . 5)))
;PREFERENCES
	;THEMES
		(setq-default custom-safe-themes t)
		(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
		(load-theme 'airline-powerlineish)
		(load-theme 'molokai t)
	;UI
    (if (display-graphic-p)
      (progn
				(menu-bar-mode -1)
				(tool-bar-mode -1)
				(scroll-bar-mode -1)
				;(toggle-frame-maximized)
				(toggle-frame-fullscreen)))
	;FONT
    (if (display-graphic-p)
      (progn
				(set-default-font "Inconsolata Nerd Font")
				(set-face-attribute 'default nil :height 160)))
	;FILE HANDLING
		;(setq custom-file "~/.emacs.d/custom.el")
		;(load custom-file)
	;TEXT
		;(set-selective-display 1)
		(setq-default tab-width 2)
		(setq-default indent-tabs-mode t)
		(setq tab-stop-list '(2 4 8 12 16))
;NOT TO TOUCH
	(custom-set-variables)
	(custom-set-faces)
