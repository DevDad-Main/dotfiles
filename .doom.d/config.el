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


;; --- AI completion: Supermaven (free tier) ---
(use-package! supermaven
  :config
  ;; One persistent sm-agent process for the whole Emacs session (like nvim).
  ;; supermaven-auto-start is disabled so supermaven-mode's per-buffer body
  ;; doesn't kill/restart the single process on every prog-mode buffer.
  (setq supermaven-auto-start nil)
  (setq supermaven-ignore-filetypes '("org" "txt" "md"))
  ;; Never re-download/overwrite an in-use sm-agent binary at boot. Without
  ;; this, supermaven--ensure-binary re-fetches on every startup and can hit
  ;; "Text file busy" while the previous daemon still has the file open.
  (when (fboundp 'supermaven--ensure-binary)
    (advice-add 'supermaven--ensure-binary :around
                (lambda (orig &rest args)
                  (let ((bin (and (fboundp 'supermaven--get-binary-path)
                                  (supermaven--get-binary-path))))
                    (if (and bin (file-executable-p bin))
                        (setq supermaven-binary-path bin)
                      (apply orig args))))))
  (supermaven-start)
  (supermaven-use-free)
  (global-supermaven-mode +1)
  (message "Supermaven started (free version, single process)"))
