;;; hl-todo.el -*- lexical-binding: t; -*-

(after! hl-todo
  (setq hl-todo-keyword-faces
        '(("TODO"       . "#3FB0B6")
          ("FIXME"      . "#C76B6B")
          ("NOTE"       . "#A0A0A0")
          ("DEPRECATED" . "#CF8656")
          ("HACK"       . "#A65A5A")
          ("REVIEW"     . "#6CA0A3")))
  (global-hl-todo-mode -1)
  (global-hl-todo-mode +1))
