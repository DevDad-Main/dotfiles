;; languages.el -*- lexical-binding: t; -*-

;; Overwrite Dooms default black formatter to the faster ruff, to use black then just comment out this logic
(after! python
  (set-formatter! 'ruff '("ruff" "format" "-") :modes '(python-mode))
  (setq apheleia-formatter 'ruff))


(use-package gdscript-mode
  :hook (gdscript-mode . eglot-ensure))

;; Enable all Go static analyzers (not done by default)
(after! lsp-mode
  (setq lsp-go-analyses '((fieldalignment . t)
                           (nilness . t)
                           (shadow . t)
                           (unusedparams . t)
                           (unusedwrite . t)
                           (useany . t)
                           (unusedvariable . t))))
