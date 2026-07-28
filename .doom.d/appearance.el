;; appearance.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'mocha)

(add-to-list 'custom-theme-load-path "~/.config/dotfiles/.doom.d/")

;; --- function definitions (must come before startup calls) ---

;; Use underline instead of background for LSP reference highlights in
;; doom-tomorrow-night (the background highlight is intrusive)
(defun +doom-tomorrow-night-faces ()
  (custom-theme-set-faces 'doom-tomorrow-night
    '(lsp-face-highlight-textual ((t (:underline t :background nil :weight normal))))
    '(lsp-face-highlight-read ((t (:underline t :background nil :weight normal))))
    '(lsp-face-highlight-write ((t (:underline t :background nil :weight normal))))))

(defun +write-rofi-colorscheme (variant)
  (let* ((dotdir (expand-file-name "~/.config/dotfiles"))
         (file (concat dotdir "/rofi/rofi-collection/colorscheme/oliverm.rasi")))
    (with-temp-file file
      (insert
       (pcase variant
         ('tomorrow-night
          "* {
  bg0: #1d1f21;
  bg1: #1d1f21;
  fg0: #c5c8c6;
  fg1: #c5c8c6;

  red: #cc6666;
  red-trans: #cc666615;
  green: #b5bd68;
  green-trans: #b5bd6815;
  yellow: #f0c674;
  yellow-trans: #f0c67415;
  blue: #81a2be;
  blue-trans: #81a2be15;
  purple: #b294bb;
  purple-trans: #b294bb15;
  aqua: #8abeb7;
  aqua-trans: #8abeb715;
}")
         ('gruber-darker
          "* {
  bg0: #1e1e1e;
  bg1: #181818;
  fg0: #e4e4ef;
  fg1: #e4e4ef;

  red: #f43841;
  red-trans: #f4384115;
  green: #b8bb26;
  green-trans: #b8bb2615;
  yellow: #ffdd33;
  yellow-trans: #ffdd3315;
  blue: #ffdd33;
  blue-trans: #ffdd3315;
  purple: #d3869b;
  purple-trans: #d3869b15;
  aqua: #8ec07c;
  aqua-trans: #8ec07c15;
}")))
      (message "Rofi scheme set to %s" variant))))

;; --- startup theme load ---

(load-theme 'doom-tomorrow-night t)
(+doom-tomorrow-night-faces)
(+write-rofi-colorscheme 'tomorrow-night)

;; Match comment color to Tomorrow Night palette
(custom-set-faces!
  '(font-lock-comment-face :foreground "#969896")
  '(font-lock-comment-delimiter-face :foreground "#969896")
  '(minibuffer-prompt :background unspecified)
  '(minibuffer :background unspecified))

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
        (setq doom-theme 'gruber-darker)
        (+write-rofi-colorscheme 'gruber-darker))
    (disable-theme 'gruber-darker)
    (load-theme 'doom-tomorrow-night t)
    (setq doom-theme 'doom-tomorrow-night)
    (+doom-tomorrow-night-faces)
    (+write-rofi-colorscheme 'tomorrow-night)))

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

