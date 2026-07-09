;;; hl-todo.el -*- lexical-binding: t; -*-

(after! hl-todo
  (setq hl-todo-keyword-faces
        '(("TODO"       . "#D0BF72")
          ("FIXME"      . "#C76B6B")
          ("NOTE"       . "#E3C369")
          ("DEPRECATED" . "#CF8656")
          ("HACK"       . "#A65A5A")
          ("REVIEW"     . "#6CA0A3")))
  (global-hl-todo-mode -1)
  (global-hl-todo-mode +1))
