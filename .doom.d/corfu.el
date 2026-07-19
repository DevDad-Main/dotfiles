;;; corfu.el -*- lexical-binding: t; -*-


;; Flycheck configuration.
(after! flycheck
  (setq flycheck-idle-change-delay 0.1)

  (flycheck-define-error-level 'lsp-flycheck-info-unnecessary
    :severity 0
    :compilation-level 0
    :overlay-category 'flycheck-info-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    :fringe-face 'flycheck-fringe-info
    :error-list-face 'flycheck-error-list-info))

;; LSP configuration.
(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-completion-enable-additional-text-edit t
        lsp-modeline-code-actions-enable t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Corfu kind icon completion ported from nvim config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-corfu-icon (icon)
  (lambda (_cand) icon))

(use-package! nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters
               #'nerd-icons-corfu-formatter)

  (setq nerd-icons-corfu-mapping
        `((array          :fn ,(my-corfu-icon "󰅪 ") :face font-lock-type-face)
          (boolean        :fn ,(my-corfu-icon " ") :face font-lock-builtin-face)
          (class          :fn ,(my-corfu-icon " ") :face font-lock-type-face)
          (color          :fn ,(my-corfu-icon " ") :face font-lock-constant-face)
          (constant       :fn ,(my-corfu-icon " ") :face font-lock-constant-face)
          (constructor    :fn ,(my-corfu-icon "󰆧 ") :face font-lock-function-name-face)
          (enum           :fn ,(my-corfu-icon " ") :face font-lock-type-face)
          (enum-member    :fn ,(my-corfu-icon " ") :face font-lock-constant-face)
          (event          :fn ,(my-corfu-icon " ") :face font-lock-warning-face)
          (field          :fn ,(my-corfu-icon " ") :face font-lock-variable-name-face)
          (file           :fn ,(my-corfu-icon " ") :face font-lock-string-face)
          (folder         :fn ,(my-corfu-icon " ") :face font-lock-string-face)
          (function       :fn ,(my-corfu-icon "󰆧 ") :face font-lock-function-name-face)
          (interface      :fn ,(my-corfu-icon " ") :face font-lock-type-face)
          (keyword        :fn ,(my-corfu-icon " ") :face font-lock-keyword-face)
          (method         :fn ,(my-corfu-icon "󰆧 ") :face font-lock-function-name-face)
          (module         :fn ,(my-corfu-icon "󰅩 ") :face font-lock-constant-face)
          (namespace      :fn ,(my-corfu-icon "󰅩 ") :face font-lock-constant-face)
          (null           :fn ,(my-corfu-icon "󰢤 ") :face font-lock-constant-face)
          (number         :fn ,(my-corfu-icon "󰎠 ") :face font-lock-constant-face)
          (object         :fn ,(my-corfu-icon "󰅩 ") :face font-lock-type-face)
          (operator       :fn ,(my-corfu-icon " ") :face font-lock-keyword-face)
          (package        :fn ,(my-corfu-icon "󰆧 ") :face font-lock-constant-face)
          (property       :fn ,(my-corfu-icon " ") :face font-lock-variable-name-face)
          (reference      :fn ,(my-corfu-icon " ") :face font-lock-variable-name-face)
          (snippet        :fn ,(my-corfu-icon " ") :face font-lock-string-face)
          (string         :fn ,(my-corfu-icon " ") :face font-lock-string-face)
          (struct         :fn ,(my-corfu-icon " ") :face font-lock-type-face)
          (text           :fn ,(my-corfu-icon "󰀬 ") :face font-lock-doc-face)
          (type-parameter :fn ,(my-corfu-icon " ") :face font-lock-type-face)
          (unit           :fn ,(my-corfu-icon " ") :face font-lock-constant-face)
          (value          :fn ,(my-corfu-icon " ") :face font-lock-constant-face)
          (variable       :fn ,(my-corfu-icon " ") :face font-lock-variable-name-face)
          (t              :fn ,(my-corfu-icon " ") :face font-lock-warning-face))))
