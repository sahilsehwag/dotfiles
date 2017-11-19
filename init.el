;NOT TO TOUCH
	(package-initialize)

	(require 'package)
	(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
	(package-initialize)
;PACKAGES
	;EVIL
		;EVIL-MODE
			;CONFIGURATION
				(add-to-list 'load-path "~/.emacs.d/packages/evil")
				(require 'evil)
				(evil-mode 1)
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
					;BUFFERS
						"be" 'evil-edit
						"bw" 'evil-save
						"bn" 'evil-buffer-new
						"bd" 'evil-delete-buffer
					;WINDOWS
						"wc" 'evil-window-delete
						"wh" 'evil-window-new
						"wv" 'evil-window-vnew
						"wo" 'evil-window-only
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
		;EVIL-TEXTOBJ-ENTIRE
			(add-to-list 'load-path "~/.emacs.d/packages/evil-textobj-entire")
			(require 'evil-textobj-entire)
		;EVIL-VIMISH-FOLD
			;(add-to-list 'load-path "~/.emacs.d/packages/evil-vimish-fold")
			;(require 'evil-vimish-fold)
			;(evil-vimish-fold-mode 1)
	;ORG-MODE
		(add-to-list 'load-path "~/.emacs.d/packages/org-mode/lisp")
	;VIMISH-FOLD
		;(add-to-list 'load-path "~/.emacs.d/packages/vimish-fold")
		;(require 'vimish-fold)
		;(vimish-fold-global-mode 1)
	;TARGETS.EL
		;(add-to-list 'load-path "~/.emacs.d/packages/targets.el")
		;(require 'targets.el)
	;ACE-JUMP-MODE
		(add-to-list 'load-path "~/.emacs.d/packages/ace-jump-mode")
		(require 'ace-jump-mode)
;THEMES
	(setq-default custom-safe-themes t)
	;COLORSCHMEMS
		(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
	;STATUSLINE THEMES
		;EMACS-POWERLINE
			;(add-to-list 'load-path "~/.emacs.d/packages/emacs-powerline")
			;(require 'powerline)
		;POWERLINE
			(add-to-list 'load-path "~/.emacs.d/packages/powerline")
			(require 'powerline)
			(powerline-default-theme)
		;AIRLINE-THEMES
			(add-to-list 'load-path "~/.emacs.d/packages/airline-themes")
			(require 'airline-themes)
	(load-theme 'airline-light)
	(load-theme 'dracula t)
;PREFERENCES
	;UI
		(menu-bar-mode -1)
	;FONT
		(set-default-font "Inconsolata Nerd Font")
		(set-face-attribute 'default nil :height 180)
;NOT TO TOUCH
	(custom-set-variables
	 ;; custom-set-variables was added by Custom.
	 ;; If you edit it by hand, you could mess it up, so be careful.
	 ;; Your init file should contain only one such instance.
	 ;; If there is more than one, they won't work right.
	 '(package-selected-packages (quote (fzf org-edna))))
	(custom-set-faces
	 ;; custom-set-faces was added by Custom.
	 ;; If you edit it by hand, you could mess it up, so be careful.
	 ;; Your init file should contain only one such instance.
	 ;; If there is more than one, they won't work right.
	 )
