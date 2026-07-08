;;; appearance.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'mocha)

(setq doom-font (font-spec :family "IoskeleyMono Nerd Font" :size 15 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "IoskeleyMono Nerd Font" :size 15))

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")
(setq select-enable-clipboard t)
