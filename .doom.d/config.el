;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(require 'doom)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things from nvim that don't have direct Emacs equivalents:
;;
;; - Treesitter textobjects (af/if/ac/ic/ab/ib/aa/ia) → Use Doom's
;;   built-in evil-textobjects instead (SPC h t for help)
;; - Treesitter swap (<leader>sp / <leader>sP) → No direct equivalent
;; - DBUI (<leader>db) → No direct equivalent in base Doom
;; - fff (<leader>f) → Covered by project-find-file / consult
;; - Legacy vim ex commands (g=, gK, C-r patterns) → Use native Emacs fns
;; - nvim-tmux-navigation → Doom has its own tmux module enabled
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(load! "appearance")
(load! "shell")
(load! "keybinds")
(load! "sql")
(load! "corfu")
(load! "hl-todo")
(load! "languages")
