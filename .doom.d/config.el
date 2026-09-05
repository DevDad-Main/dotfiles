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


;; --- Auto-closing tags (emmet) in React/TSX via the :lang web module ---
;; The :lang web module hooks emmet-mode into rjsx-mode/web-mode, but our
;; React+TSX files open in tsx-ts-mode/typescript-ts-mode (tree-sitter), so we
;; opt emmet-mode in there too. Type `<div` then TAB to expand to `<div></div>`.
(after! emmet-mode
  (add-hook! 'tsx-ts-mode-hook #'emmet-mode)
  (add-hook! 'typescript-ts-mode-hook #'emmet-mode)
  (add-hook! 'js-ts-mode-hook #'emmet-mode)
  (setq emmet-move-cursor-between-quotes t)
  (map! :map emmet-mode-keymap
        [tab] #'+web/indent-or-yas-or-emmet-expand
        "M-E" #'emmet-expand-line))

;; --- AI completion: Codeium (free tier) ---
;; Ghost-text style completions via corfu. Replaces a broken supermaven.el fork.
;; First-time setup: `M-x codeium-install`, then `M-x codeium-auth` (opens a
;; browser to register for a free API key).
(use-package! codeium
  :config
  (setq use-dialog-box nil)
  (setq codeium-mode-line-enable
        (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
  (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
  (setq codeium-api-enabled
        (lambda (api)
          (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
  (setq codeium-metadata-enabled nil)
  (setq codeium-documentation-enable nil)
  (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
  (add-hook 'after-init-hook #'codeium-init))
