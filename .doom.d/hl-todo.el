;;; hl-todo.el -*- lexical-binding: t; -*-

(after! hl-todo
  (setq hl-todo-keyword-faces
        '(("TODO"       . nezburn-hl-todo-todo)
          ("FIXME"      . nezburn-hl-todo-fixme)
          ("NOTE"       . nezburn-hl-todo-note)
          ("DEPRECATED" . nezburn-hl-todo-deprecated)
          ("HACK"       . nezburn-hl-todo-hack)
          ("REVIEW"     . nezburn-hl-todo-review))))
