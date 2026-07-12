;;; monochrome-theme.el --- Charcoal monochrome color theme for Emacs

;; Copyright (C) 2024

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
;; A monochrome charcoal theme with grey and silver accents.
;; Designed for calm, low-contrast editing sessions.

(deftheme monochrome
  "Charcoal monochrome color theme for Emacs")

(let ((mc-bg        "#151515")
      (mc-bg-1      "#0a0a0a")
      (mc-bg+1      "#1e1e1e")
      (mc-bg+2      "#282828")
      (mc-bg+3      "#323232")
      (mc-bg+4      "#3c3c3c")
      (mc-fg        "#d4d4d4")
      (mc-fg+1      "#e0e0e0")
      (mc-fg+2      "#ececec")
      (mc-white     "#f5f5f5")
      (mc-black     "#000000")
      (mc-silver    "#a0a0a0")
      (mc-steel     "#707070")
      (mc-red       "#cc7a7a")
      (mc-red+1     "#d98a8a")
      (mc-green     "#7acc9a")
      (mc-yellow    "#ccb87a")
      (mc-blue      "#7a9ecc")
      (mc-magenta   "#9e7acc")
      (mc-cyan      "#7acccc")
      (mc-brown     "#8a7a5a"))
  (custom-theme-set-variables
   'monochrome
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'monochrome

   `(default ((t ,(list :foreground mc-fg :background mc-bg))))
   `(cursor ((t (:background ,mc-silver))))
   `(fringe ((t (:background nil :foreground ,mc-bg+4))))
   `(border ((t (:background ,mc-bg-1 :foreground ,mc-bg+2))))
   `(vertical-border ((t (:foreground ,mc-bg+2))))
   `(link ((t (:foreground ,mc-blue :underline t))))
   `(link-visited ((t (:foreground ,mc-magenta :underline t))))
   `(match ((t (:background ,mc-bg+4))))
   `(shadow ((t (:foreground ,mc-steel))))
   `(minibuffer-prompt ((t (:foreground ,mc-silver))))
   `(secondary-selection ((t (:background ,mc-bg+3 :foreground nil))))
   `(trailing-whitespace ((t (:foreground ,mc-black :background ,mc-red))))
   `(tooltip ((t (:background ,mc-bg+4 :foreground ,mc-white))))

   `(font-lock-builtin-face ((t (:foreground ,mc-yellow))))
   `(font-lock-comment-face ((t (:foreground ,mc-steel))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,mc-steel))))
   `(font-lock-constant-face ((t (:foreground ,mc-silver))))
   `(font-lock-doc-face ((t (:foreground ,mc-steel))))
   `(font-lock-function-name-face ((t (:foreground ,mc-fg+1))))
   `(font-lock-keyword-face ((t (:foreground ,mc-fg+2 :bold t))))
   `(font-lock-preprocessor-face ((t (:foreground ,mc-silver))))
   `(font-lock-string-face ((t (:foreground ,mc-silver))))
   `(font-lock-type-face ((t (:foreground ,mc-silver))))
   `(font-lock-variable-name-face ((t (:foreground ,mc-fg+1))))
   `(font-lock-warning-face ((t (:foreground ,mc-yellow))))

   `(highlight ((t (:background ,mc-bg+1 :foreground nil))))
   `(line-number ((t (:inherit default :foreground ,mc-steel))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,mc-silver))))

   `(region ((t (:background ,mc-bg+3))))
   `(isearch ((t (:background ,mc-silver :foreground ,mc-black))))
   `(isearch-fail ((t (:background ,mc-red :foreground ,mc-black))))
   `(lazy-highlight ((t (:background ,mc-bg+4 :foreground ,mc-fg+1))))

   `(mode-line ((t (:background ,mc-bg+1 :foreground ,mc-fg))))
   `(mode-line-inactive ((t (:background ,mc-bg+1 :foreground ,mc-steel))))
   `(mode-line-buffer-id ((t (:background ,mc-bg+1 :foreground ,mc-white))))

   `(header-line ((t (:background nil :foreground nil))))

   `(show-paren-match ((t (:background ,mc-bg+4))))
   `(show-paren-mismatch ((t (:background ,mc-red))))

   ;; Dired
   `(dired-directory ((t (:foreground ,mc-silver :weight bold))))
   `(diredfl-dir-name ((t (:foreground ,mc-silver :weight bold))))
   `(diredfl-dir-heading ((t (:foreground ,mc-silver))))
   `(diredfl-file-name ((t (:foreground ,mc-fg))))
   `(diredfl-file-suffix ((t (:foreground ,mc-fg))))
   `(diredfl-no-priv ((t (:foreground ,mc-steel))))
   `(diredfl-read-priv ((t (:foreground ,mc-steel))))
   `(diredfl-write-priv ((t (:foreground ,mc-silver))))
   `(diredfl-exec-priv ((t (:foreground ,mc-green))))
   `(diredfl-number ((t (:foreground ,mc-steel))))
   `(diredfl-date-time ((t (:foreground ,mc-steel))))
   `(diredfl-flag-mark ((t (:foreground ,mc-yellow :background ,mc-bg+2))))
   `(diredfl-flag-mark-line ((t (:background ,mc-bg+2))))
   `(diredfl-deletion ((t (:foreground ,mc-red :background ,mc-bg+2))))
   `(diredfl-deletion-file-name ((t (:foreground ,mc-red))))
   `(diredfl-symlink ((t (:foreground ,mc-silver))))
   `(diredfl-autofile-name ((t (:background ,mc-bg+1))))

   ;; Compilation
   `(compilation-info ((t (:foreground ,mc-green))))
   `(compilation-warning ((t (:foreground ,mc-yellow :bold t))))
   `(compilation-error ((t (:foreground ,mc-red+1))))
   `(compilation-mode-line-fail ((t (:foreground ,mc-red :weight bold))))
   `(compilation-mode-line-exit ((t (:foreground ,mc-green :weight bold))))

   ;; Diff
   `(diff-removed ((t (:foreground ,mc-red :background nil))))
   `(diff-added ((t (:foreground ,mc-green :background nil))))

   ;; Magit
   `(magit-branch ((t (:foreground ,mc-silver))))
   `(magit-diff-hunk-header ((t (:background ,mc-bg+2))))
   `(magit-diff-file-header ((t (:background ,mc-bg+4))))
   `(magit-log-sha1 ((t (:foreground ,mc-red+1))))
   `(magit-log-author ((t (:foreground ,mc-yellow))))
   `(magit-log-head-label-head ((t (:background ,mc-bg+1 :foreground ,mc-fg))))
   `(magit-log-head-label-local ((t (:background ,mc-bg+1 :foreground ,mc-silver))))
   `(magit-log-head-label-remote ((t (:background ,mc-bg+1 :foreground ,mc-green))))
   `(magit-log-head-label-tags ((t (:background ,mc-bg+1 :foreground ,mc-yellow))))
   `(magit-item-highlight ((t (:background ,mc-bg+1))))
   `(magit-tag ((t (:background ,mc-bg :foreground ,mc-yellow))))
   `(magit-blame-heading ((t (:background ,mc-bg+1 :foreground ,mc-fg))))

   ;; org-mode
   `(org-agenda-structure ((t (:foreground ,mc-silver))))
   `(org-column ((t (:background ,mc-bg-1))))
   `(org-column-title ((t (:background ,mc-bg-1 :underline t :weight bold))))
   `(org-done ((t (:foreground ,mc-green))))
   `(org-todo ((t (:foreground ,mc-red))))
   `(org-upcoming-deadline ((t (:foreground ,mc-yellow))))

   ;; Helm
   `(helm-candidate-number ((t (:background ,mc-bg+2 :foreground ,mc-silver :bold t))))
   `(helm-ff-directory ((t (:foreground ,mc-silver :background ,mc-bg :bold t))))
   `(helm-ff-executable ((t (:foreground ,mc-green))))
   `(helm-ff-file ((t (:foreground ,mc-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t (:background ,mc-red :foreground ,mc-bg))))
   `(helm-ff-symlink ((t (:foreground ,mc-yellow :bold t))))
   `(helm-selection-line ((t (:background ,mc-bg+1))))
   `(helm-selection ((t (:background ,mc-bg+1 :underline nil))))
   `(helm-source-header ((t (:foreground ,mc-silver :background ,mc-bg))))

   ;; Company mode
   `(company-tooltip ((t (:foreground ,mc-fg :background ,mc-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,mc-steel :background ,mc-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,mc-steel :background ,mc-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,mc-fg :background ,mc-bg-1))))
   `(company-tooltip-mouse ((t (:background ,mc-bg-1))))
   `(company-tooltip-common ((t (:foreground ,mc-green))))
   `(company-tooltip-common-selection ((t (:foreground ,mc-green))))
   `(company-scrollbar-fg ((t (:background ,mc-bg-1))))
   `(company-scrollbar-bg ((t (:background ,mc-bg+2))))
   `(company-preview ((t (:background ,mc-green))))
   `(company-preview-common ((t (:foreground ,mc-green :background ,mc-bg-1))))

   ;; Tab bar
   `(tab-bar ((t (:background ,mc-bg+1 :foreground ,mc-steel))))
   `(tab-bar-tab ((t (:background nil :foreground ,mc-silver :weight bold))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; vterm / ansi-term
   `(term-color-black ((t (:foreground ,mc-bg+3 :background ,mc-bg+4))))
   `(term-color-red ((t (:foreground ,mc-red :background ,mc-red))))
   `(term-color-green ((t (:foreground ,mc-green :background ,mc-green))))
   `(term-color-yellow ((t (:foreground ,mc-yellow :background ,mc-yellow))))
   `(term-color-blue ((t (:foreground ,mc-blue :background ,mc-blue))))
   `(term-color-magenta ((t (:foreground ,mc-magenta :background ,mc-magenta))))
   `(term-color-cyan ((t (:foreground ,mc-cyan :background ,mc-cyan))))
   `(term-color-white ((t (:foreground ,mc-fg :background ,mc-white))))

   ;; Orderless
   `(orderless-match-face-0 ((t (:foreground ,mc-yellow))))
   `(orderless-match-face-1 ((t (:foreground ,mc-green))))
   `(orderless-match-face-2 ((t (:foreground ,mc-blue))))
   `(orderless-match-face-3 ((t (:foreground ,mc-magenta))))

   ;; Flycheck / Flymake
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,mc-red) :inherit unspecified))
      (t (:foreground ,mc-red :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,mc-yellow) :inherit unspecified))
      (t (:foreground ,mc-yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,mc-green) :inherit unspecified))
      (t (:foreground ,mc-green :weight bold :underline t))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'monochrome)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; monochrome-theme.el ends here
