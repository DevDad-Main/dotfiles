;; appearance.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'mocha)

(add-to-list 'custom-theme-load-path "~/.config/dotfiles/.doom.d/")

(defconst dotfiles-theme-file "~/.config/dotfiles/emacs/theme.el")
(when (file-exists-p dotfiles-theme-file)
  (load dotfiles-theme-file))
(unless (file-exists-p dotfiles-theme-file)
  (load-theme 'nezburn t))

;; Use underline instead of background for LSP reference highlights in
;; doom-tomorrow-night (the background highlight is intrusive)
(defun +doom-tomorrow-night-faces ()
  (custom-theme-set-faces 'doom-tomorrow-night
    '(lsp-face-highlight-textual ((t (:underline t :background nil :weight normal))))
    '(lsp-face-highlight-read ((t (:underline t :background nil :weight normal))))
    '(lsp-face-highlight-write ((t (:underline t :background nil :weight normal))))))
(when (custom-theme-enabled-p 'doom-tomorrow-night)
  (+doom-tomorrow-night-faces))

;; Match comment color to Tomorrow Night palette
(custom-set-faces!
  '(font-lock-comment-face :foreground "#969896")
  '(font-lock-comment-delimiter-face :foreground "#969896"))

(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(defvar +transparency--enabled t)

(defun +toggle-theme ()
  "Toggle between doom-tomorrow-night and gruber-darker."
  (interactive)
  (if (custom-theme-enabled-p 'doom-tomorrow-night)
      (progn
        (disable-theme 'doom-tomorrow-night)
        (load-theme 'gruber-darker t)
        (setq doom-theme 'gruber-darker))
    (disable-theme 'gruber-darker)
    (load-theme 'doom-tomorrow-night t)
    (setq doom-theme 'doom-tomorrow-night)
    (+doom-tomorrow-night-faces)))

(defun +toggle-transparency ()
  (interactive)
  (if (setq +transparency--enabled (not +transparency--enabled))
      (progn
        (set-frame-parameter nil 'alpha '(90 90))
        (message "Transparency enabled"))
    (set-frame-parameter nil 'alpha '(100 100))
    (message "Transparency disabled")))
;; (setq doom-font (font-spec :family "IoskeleyMono Nerd Font" :size 15 :weight 'medium)
;;       doom-variable-pitch-font (font-spec :family "IoskeleyMono Nerd Font" :size 15))

;; (setq doom-font (font-spec :family "Iosevka Nerd Font" :size 17 :weight 'medium)
;;       doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 17))

(setq doom-font (font-spec :family "DepartureMono Nerd Font Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "DepartureMono Nerd Font Mono" :size 16))

(setq display-line-numbers-type 'relative)

(advice-add #'vi-tilde-fringe-mode :override #'ignore)

(setq org-directory "~/org/")
(setq select-enable-clipboard t)

(after! dired
  (custom-set-faces
   '(dired-directory ((t (:weight normal :underline nil))))
   '(diredfl-dir-name ((t (:weight normal :underline nil))))))

