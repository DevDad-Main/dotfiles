;;; appearance.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'mocha)

(add-to-list 'custom-theme-load-path "~/.config/dotfiles/.doom.d/")

(load-theme 'nezburn t)
;; (load-theme 'gruber-darker t)
;; (setq doom-font (font-spec :family "IoskeleyMono Nerd Font" :size 15 :weight 'medium)
;;       doom-variable-pitch-font (font-spec :family "IoskeleyMono Nerd Font" :size 15))

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 17 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 17))

(set-frame-parameter (selected-frame) 'alpha '(80 80))
(add-to-list 'default-frame-alist '(alpha 80 80))

(setq display-line-numbers-type 'relative)

(advice-add #'vi-tilde-fringe-mode :override #'ignore)

(setq org-directory "~/org/")
(setq select-enable-clipboard t)

(after! dired
  (custom-set-faces
   '(dired-directory ((t (:background nil :foreground nil :weight normal :underline nil))))
   '(diredfl-dir-name ((t (:background nil :foreground nil :weight normal :underline nil))))))
