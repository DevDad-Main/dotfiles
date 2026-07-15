;; languages.el -*- lexical-binding: t; -*-

;; Overwrite Dooms default black formatter to the faster ruff, to use black then just comment out this logic
(after! python
  (set-formatter! 'ruff '("ruff" "format" "-") :modes '(python-mode))
  (setq apheleia-formatter 'ruff))
