;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(require 'doom)

;; Ensure npm global binaries are in PATH (for tsserver, etc.)
(setenv "PATH" (concat (getenv "HOME") "/.npm-global/bin:" (getenv "PATH")))
(push "/home/oliverm/.npm-global/bin" exec-path)

;; .NET global tools (csharpier for C# formatting, shader-ls, etc.)
(setenv "PATH" (concat (getenv "HOME") "/.dotnet/tools:" (getenv "PATH")))
(push "/home/oliverm/.dotnet/tools" exec-path)


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
(load! "unity")

;; Enable level-4 tree-sitter font-lock features (function, property, operator, bracket, delimiter)
(setq treesit-font-lock-level 4)

;; Don't auto-enable whitespace-mode to highlight tabs/indentation markers in
;; buffers whose indent style differs from indent-tabs-mode. That only adds
;; noisy glyphs at the start of every line. +trim and +guess still work.
(remove-hook 'after-change-major-mode-hook #'+whitespace-highlight-incorrect-indentation-h)
