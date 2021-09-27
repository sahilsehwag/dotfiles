;;; ../../dotfiles/packages/doomemacs/dotfiles/plugins/evil-extensions/init.el -*- lexical-binding: t; -*-

(defun evil/bd-wc ()
	"evil-delete-buffer -> evil-window-delete"
	(evil-delete-buffer)
	(evil-window-delete))
