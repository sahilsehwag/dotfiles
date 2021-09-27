;;; mappings.el -*- lexical-binding: t; -*-

;help

;buffers
(map! :leader "b a" #'evil-buffer-new)

(map! :leader "b c c" #'evil-delete-buffer)
(map! :leader "b c a" #'+evil:kill-all-buffers)
(map! :leader "b c r" #'+evil:kill-matching-buffers)
(map! :leader "b c o" #'doom/kill-other-buffers)
(map! :leader "b c p" #'doom/kill-project-buffers)

(map! :leader "b d c" 'evil/bd-wc)

(map! :ne "C-n" #'next-buffer)
(map! :ne "C-p" #'previous-buffer)
(map! :ne "C-s" #'save-buffer)


;windows
(map! :leader "w s" #'evil-window-split)
(map! :leader "w v" #'evil-window-vsplit)
(map! :leader "w c" #'evil-window-delete)
(map! :leader "w o" #'doom/window-maximize-buffer)

(map! :leader "w =" #'balance-windows)
(map! :leader "w m" #'maximize-windows)

(map! :ne "C-h" #'evil-window-left)
(map! :ne "C-j" #'evil-window-down)
(map! :ne "C-k" #'evil-window-up)
(map! :ne "C-l" #'evil-window-right)

(map! :ne "C-S-h" #'evil-window-decrease-width)
(map! :ne "C-S-j" #'evil-window-decrease-height)
(map! :ne "C-S-k" #'evil-window-increase-height)
(map! :ne "C-S-l" #'evil-window-increase-width)

(map! :leader "w h" #'+evil/window-move-left)
(map! :leader "w j" #'+evil/window-move-down)
(map! :leader "w k" #'+evil/window-move-up)
(map! :leader "w l" #'+evil/window-move-right)


;tabs
(map! :ne "C-9" #'tab-next)
(map! :ne "C-0" #'tab-previous)


;workspaces[tmux-windows]
;; (map! :leader "W l" #'+workspace/display)
;; (map! :leader "W n" #'+workspace/new)
;; (map! :leader "W N" #'+workspace/new-named)
;; (map! :leader "W d" #'+workspace/delete)
;; (map! :leader "W r" #'+workspace/rename)
;; (map! :leader "W s" #'+workspace/save)
;; (map! :leader "W n" #'+workspace/switch-right)
;; (map! :leader "W p" #'+workspace/switch-left)
;; (map! :leader "W 9" #'+workspace/swap-left)
;; (map! :leader "W 0" #'+workspace/swap-right)

;; few not-working
(map! :ne "M-c M-w" #'+workspace/new)
(map! :ne "M-x" #'+workspace/delete)
(map! :ne "M-r" #'+workspace/rename)
(map! :ne "M-n" #'+workspace/switch-right)
(map! :ne "M-p" #'+workspace/switch-left)
(map! :ne "M--" #'+workspace/swap-left)
(map! :ne "M-=" #'+workspace/swap-right)
(map! :ne "M-s" #'+workspace/save)


;frames[tmux-sessions]
(map! :ne "M-c M-f" #'make-frame)
(map! :ne "M-9" #'+evil/previous-frame)
(map! :ne "M-0" #'+evil/next-frame)


;operators
;objects
;motions
;find|fuzzy
;projects
;lsp
;open
