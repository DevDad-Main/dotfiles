;;; shell.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make uv-installed tools available to Emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
(setenv "PATH"
        (concat (expand-file-name "~/.local/bin")
                path-separator
                (getenv "PATH")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq shell-file-name (executable-find "bash"))

(setq-default
 vterm-shell "/bin/fish"
 explicit-shell-file-name "/bin/fish")

(after! vterm
  (setq vterm-enable-manipulate-selection-data-by-osc52 nil)
  (setq vterm-term-environment-variable "xterm-256color"))
