;;; ember-theme.el --- Warm ember color theme for Emacs

;; Copyright (C) 2026

;; Author: oliverm
;; URL: https://github.com/anomalyco/opencode

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:
;;
;; A warm ember theme derived from the "wallpaperflare" ember wallpaper:
;; deep warm-brown backgrounds with flame-yellow and ember-red accents.

(deftheme ember
  "Warm ember color theme for Emacs")

(let ((eb-bg        "#1a0f08")
      (eb-bg-1      "#120a05")
      (eb-bg+1      "#2a1c12")
      (eb-bg+2      "#3a2b21")
      (eb-bg+3      "#4a382c")
      (eb-bg+4      "#5a4536")
      (eb-fg        "#eeddc0")
      (eb-fg+1      "#f5e8cf")
      (eb-fg+2      "#fcf3e0")
      (eb-white     "#fff9ec")
      (eb-black     "#000000")
      (eb-silver    "#c4ae93")
      (eb-steel     "#96755f")
      (eb-tan       "#dcb98c")
      (eb-amber     "#ff9e2e")
      (eb-red       "#ff3b1f")
      (eb-red+1     "#ff5c3a")
      (eb-green     "#9db06a")
      (eb-yellow    "#fdbd28")
      (eb-blue      "#8ba3ad")
      (eb-magenta   "#cf7f62")
      (eb-cyan      "#cfa878")
      (eb-brown     "#8f6a4a"))
  (custom-theme-set-variables
   'ember
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'ember

   `(default ((t ,(list :foreground eb-fg :background eb-bg))))
   `(cursor ((t (:background ,eb-amber))))
   `(fringe ((t (:background nil :foreground ,eb-bg+4))))
   `(border ((t (:background ,eb-bg-1 :foreground ,eb-bg+2))))
   `(vertical-border ((t (:foreground ,eb-bg+2))))
   `(link ((t (:foreground ,eb-blue :underline t))))
   `(link-visited ((t (:foreground ,eb-magenta :underline t))))
   `(match ((t (:background ,eb-bg+4))))
   `(shadow ((t (:foreground ,eb-steel))))
   `(minibuffer-prompt ((t (:foreground ,eb-amber))))
   `(secondary-selection ((t (:background ,eb-bg+3 :foreground nil))))
   `(trailing-whitespace ((t (:foreground ,eb-black :background ,eb-red))))
   `(tooltip ((t (:background ,eb-bg+4 :foreground ,eb-white))))

   `(font-lock-builtin-face ((t (:foreground ,eb-amber))))
   `(font-lock-comment-face ((t (:foreground ,eb-steel))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,eb-steel))))
   `(font-lock-constant-face ((t (:foreground ,eb-amber))))
   `(font-lock-doc-face ((t (:foreground ,eb-steel))))
   `(font-lock-function-name-face ((t (:foreground ,eb-fg+1))))
   `(font-lock-keyword-face ((t (:foreground ,eb-amber :bold t))))
   `(font-lock-preprocessor-face ((t (:foreground ,eb-silver))))
   `(font-lock-string-face ((t (:foreground ,eb-tan))))
   `(font-lock-type-face ((t (:foreground ,eb-amber))))
   `(font-lock-variable-name-face ((t (:foreground ,eb-fg+1))))
   `(font-lock-warning-face ((t (:foreground ,eb-red+1))))

   `(highlight ((t (:background ,eb-bg+1 :foreground nil))))
   `(line-number ((t (:inherit default :foreground ,eb-steel))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,eb-silver))))

   `(region ((t (:background ,eb-bg+3))))
   `(isearch ((t (:background ,eb-amber :foreground ,eb-black))))
   `(isearch-fail ((t (:background ,eb-red :foreground ,eb-black))))
   `(lazy-highlight ((t (:background ,eb-bg+4 :foreground ,eb-fg+1))))

   `(mode-line ((t (:background ,eb-bg+1 :foreground ,eb-fg))))
   `(mode-line-inactive ((t (:background ,eb-bg+1 :foreground ,eb-steel))))
   `(mode-line-buffer-id ((t (:background ,eb-bg+1 :foreground ,eb-white))))

   `(header-line ((t (:background nil :foreground nil))))

   `(show-paren-match ((t (:background ,eb-bg+4))))
   `(show-paren-mismatch ((t (:background ,eb-red))))

   ;; Dired
   `(dired-directory ((t (:foreground ,eb-amber :weight bold))))
   `(diredfl-dir-name ((t (:foreground ,eb-amber :weight bold))))
   `(diredfl-dir-heading ((t (:foreground ,eb-silver))))
   `(diredfl-file-name ((t (:foreground ,eb-fg))))
   `(diredfl-file-suffix ((t (:foreground ,eb-fg))))
   `(diredfl-no-priv ((t (:foreground ,eb-steel))))
   `(diredfl-read-priv ((t (:foreground ,eb-steel))))
   `(diredfl-write-priv ((t (:foreground ,eb-silver))))
   `(diredfl-exec-priv ((t (:foreground ,eb-green))))
   `(diredfl-number ((t (:foreground ,eb-steel))))
   `(diredfl-date-time ((t (:foreground ,eb-steel))))
   `(diredfl-flag-mark ((t (:foreground ,eb-yellow :background ,eb-bg+2))))
   `(diredfl-flag-mark-line ((t (:background ,eb-bg+2))))
   `(diredfl-deletion ((t (:foreground ,eb-red :background ,eb-bg+2))))
   `(diredfl-deletion-file-name ((t (:foreground ,eb-red))))
   `(diredfl-symlink ((t (:foreground ,eb-silver))))
   `(diredfl-autofile-name ((t (:background ,eb-bg+1))))

   ;; Compilation
   `(compilation-info ((t (:foreground ,eb-green))))
   `(compilation-warning ((t (:foreground ,eb-yellow :bold t))))
   `(compilation-error ((t (:foreground ,eb-red+1))))
   `(compilation-mode-line-fail ((t (:foreground ,eb-red :weight bold))))
   `(compilation-mode-line-exit ((t (:foreground ,eb-green :weight bold))))

   ;; Diff
   `(diff-removed ((t (:foreground ,eb-red :background nil))))
   `(diff-added ((t (:foreground ,eb-green :background nil))))

   ;; Magit
   `(magit-branch ((t (:foreground ,eb-silver))))
   `(magit-diff-hunk-header ((t (:background ,eb-bg+2))))
   `(magit-diff-file-header ((t (:background ,eb-bg+4))))
   `(magit-log-sha1 ((t (:foreground ,eb-red+1))))
   `(magit-log-author ((t (:foreground ,eb-amber))))
   `(magit-log-head-label-head ((t (:background ,eb-bg+1 :foreground ,eb-fg))))
   `(magit-log-head-label-local ((t (:background ,eb-bg+1 :foreground ,eb-silver))))
   `(magit-log-head-label-remote ((t (:background ,eb-bg+1 :foreground ,eb-green))))
   `(magit-log-head-label-tags ((t (:background ,eb-bg+1 :foreground ,eb-yellow))))
   `(magit-item-highlight ((t (:background ,eb-bg+1))))
   `(magit-tag ((t (:background ,eb-bg :foreground ,eb-amber))))
   `(magit-blame-heading ((t (:background ,eb-bg+1 :foreground ,eb-fg))))

   ;; org-mode
   `(org-agenda-structure ((t (:foreground ,eb-silver))))
   `(org-column ((t (:background ,eb-bg-1))))
   `(org-column-title ((t (:background ,eb-bg-1 :underline t :weight bold))))
   `(org-done ((t (:foreground ,eb-green))))
   `(org-todo ((t (:foreground ,eb-red))))
   `(org-upcoming-deadline ((t (:foreground ,eb-yellow))))

   ;; Helm
   `(helm-candidate-number ((t (:background ,eb-bg+2 :foreground ,eb-silver :bold t))))
   `(helm-ff-directory ((t (:foreground ,eb-amber :background ,eb-bg :bold t))))
   `(helm-ff-executable ((t (:foreground ,eb-green))))
   `(helm-ff-file ((t (:foreground ,eb-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t (:background ,eb-red :foreground ,eb-bg))))
   `(helm-ff-symlink ((t (:foreground ,eb-amber :bold t))))
   `(helm-selection-line ((t (:background ,eb-bg+1))))
   `(helm-selection ((t (:background ,eb-bg+1 :underline nil))))
   `(helm-source-header ((t (:foreground ,eb-silver :background ,eb-bg))))

   ;; Company mode
   `(company-tooltip ((t (:foreground ,eb-fg :background ,eb-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,eb-steel :background ,eb-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,eb-steel :background ,eb-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,eb-fg :background ,eb-bg-1))))
   `(company-tooltip-mouse ((t (:background ,eb-bg-1))))
   `(company-tooltip-common ((t (:foreground ,eb-green))))
   `(company-tooltip-common-selection ((t (:foreground ,eb-green))))
   `(company-scrollbar-fg ((t (:background ,eb-bg-1))))
   `(company-scrollbar-bg ((t (:background ,eb-bg+2))))
   `(company-preview ((t (:background ,eb-green))))
   `(company-preview-common ((t (:foreground ,eb-green :background ,eb-bg-1))))

   ;; Tab bar
   `(tab-bar ((t (:background ,eb-bg+1 :foreground ,eb-steel))))
   `(tab-bar-tab ((t (:background nil :foreground ,eb-silver :weight bold))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; vterm / ansi-term
   `(term-color-black ((t (:foreground ,eb-bg+3 :background ,eb-bg+4))))
   `(term-color-red ((t (:foreground ,eb-red :background ,eb-red))))
   `(term-color-green ((t (:foreground ,eb-green :background ,eb-green))))
   `(term-color-yellow ((t (:foreground ,eb-yellow :background ,eb-yellow))))
   `(term-color-blue ((t (:foreground ,eb-blue :background ,eb-blue))))
   `(term-color-magenta ((t (:foreground ,eb-magenta :background ,eb-magenta))))
   `(term-color-cyan ((t (:foreground ,eb-cyan :background ,eb-cyan))))
   `(term-color-white ((t (:foreground ,eb-fg :background ,eb-white))))

   ;; Orderless
   `(orderless-match-face-0 ((t (:foreground ,eb-amber))))
   `(orderless-match-face-1 ((t (:foreground ,eb-green))))
   `(orderless-match-face-2 ((t (:foreground ,eb-blue))))
   `(orderless-match-face-3 ((t (:foreground ,eb-magenta))))

   ;; Flycheck / Flymake
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eb-red) :inherit unspecified))
      (t (:foreground ,eb-red :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eb-yellow) :inherit unspecified))
      (t (:foreground ,eb-yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eb-green) :inherit unspecified))
      (t (:foreground ,eb-green :weight bold :underline t))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ember)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; ember-theme.el ends here
