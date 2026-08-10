;;; gilded-noir-theme.el --- Gilded Noir color theme for Emacs

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
;; A monochrome noir theme with bronze-to-gold accents, drawn from the
;; Gilded Noir rice (naveen-og/gilded-noir).  Black, greyscale, and one
;; gold accent: code and UI read by brightness rather than hue, and gold
;; is reserved for whatever currently has your attention.

(deftheme gilded-noir
  "Gilded Noir color theme for Emacs")

(let ((gn-bg        "#0B0B0C")
      (gn-bg-1      "#070708")
      (gn-surface   "#131316")
      (gn-raised    "#191920")
      (gn-border    "#202027")
      (gn-bg+3      "#2A2A31")
      (gn-grey      "#3E3A2E")
      (gn-grey+1    "#4E4838")
      (gn-grey+2    "#5A5443")
      (gn-fg        "#C3B285")
      (gn-fg+1      "#D6C89C")
      (gn-fg+2      "#E4D8B4")
      (gn-white     "#E4D8B4")
      (gn-black     "#000000")
      (gn-accent    "#D4AF37")
      (gn-sun       "#E0C158")
      (gn-amber     "#866C2C")
      (gn-bronze    "#A88C46")
      (gn-orange    "#B8923C")
      (gn-muted     "#6A6249")
      (gn-blue      "#8C7738")
      (gn-purple    "#9A8452")
      (gn-teal      "#A88C46")
      (gn-red       "#8C4A32")
      (gn-red+1     "#A0603E")
      (gn-pink      "#B07A55"))
  (custom-theme-set-variables
   'gilded-noir
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'gilded-noir

   `(default ((t ,(list :foreground gn-fg :background gn-bg))))
   `(cursor ((t (:background ,gn-accent))))
   `(fringe ((t (:background nil :foreground ,gn-bg+3))))
   `(border ((t (:background ,gn-bg-1 :foreground ,gn-surface))))
   `(vertical-border ((t (:foreground ,gn-surface))))
   `(link ((t (:foreground ,gn-accent :underline t))))
   `(link-visited ((t (:foreground ,gn-purple :underline t))))
   `(match ((t (:background ,gn-bg+3))))
   `(shadow ((t (:foreground ,gn-muted))))
   `(minibuffer-prompt ((t (:foreground ,gn-accent))))
   `(secondary-selection ((t (:background ,gn-raised :foreground nil))))
   `(trailing-whitespace ((t (:foreground ,gn-black :background ,gn-red))))
   `(tooltip ((t (:background ,gn-bg+3 :foreground ,gn-white))))

   `(font-lock-builtin-face ((t (:foreground ,gn-bronze))))
   `(font-lock-comment-face ((t (:foreground ,gn-muted))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,gn-muted))))
   `(font-lock-constant-face ((t (:foreground ,gn-orange))))
   `(font-lock-doc-face ((t (:foreground ,gn-grey+2))))
   `(font-lock-function-name-face ((t (:foreground ,gn-accent))))
   `(font-lock-keyword-face ((t (:foreground ,gn-blue :bold t))))
   `(font-lock-preprocessor-face ((t (:foreground ,gn-grey+2))))
   `(font-lock-string-face ((t (:foreground ,gn-bronze))))
   `(font-lock-type-face ((t (:foreground ,gn-accent))))
   `(font-lock-variable-name-face ((t (:foreground ,gn-fg+1))))
   `(font-lock-warning-face ((t (:foreground ,gn-amber))))

   `(highlight ((t (:background ,gn-raised :foreground nil))))
   `(line-number ((t (:inherit default :foreground ,gn-grey+2))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,gn-accent))))

   `(region ((t (:background ,gn-amber :foreground ,gn-bg))))
   `(isearch ((t (:background ,gn-accent :foreground ,gn-black))))
   `(isearch-fail ((t (:background ,gn-red :foreground ,gn-black))))
   `(lazy-highlight ((t (:background ,gn-bg+3 :foreground ,gn-fg+1))))

   `(mode-line ((t (:background ,gn-surface :foreground ,gn-fg))))
   `(mode-line-inactive ((t (:background ,gn-surface :foreground ,gn-muted))))
   `(mode-line-buffer-id ((t (:background ,gn-surface :foreground ,gn-white))))

   `(header-line ((t (:background nil :foreground nil))))

   `(show-paren-match ((t (:background ,gn-bg+3))))
   `(show-paren-mismatch ((t (:background ,gn-red))))

   ;; Dired
   `(dired-directory ((t (:foreground ,gn-accent :weight bold))))
   `(diredfl-dir-name ((t (:foreground ,gn-accent :weight bold))))
   `(diredfl-dir-heading ((t (:foreground ,gn-accent))))
   `(diredfl-file-name ((t (:foreground ,gn-fg))))
   `(diredfl-file-suffix ((t (:foreground ,gn-fg))))
   `(diredfl-no-priv ((t (:foreground ,gn-grey+2))))
   `(diredfl-read-priv ((t (:foreground ,gn-grey+2))))
   `(diredfl-write-priv ((t (:foreground ,gn-bronze))))
   `(diredfl-exec-priv ((t (:foreground ,gn-orange))))
   `(diredfl-number ((t (:foreground ,gn-grey+2))))
   `(diredfl-date-time ((t (:foreground ,gn-grey+2))))
   `(diredfl-flag-mark ((t (:foreground ,gn-accent :background ,gn-surface))))
   `(diredfl-flag-mark-line ((t (:background ,gn-surface))))
   `(diredfl-deletion ((t (:foreground ,gn-red :background ,gn-surface))))
   `(diredfl-deletion-file-name ((t (:foreground ,gn-red))))
   `(diredfl-symlink ((t (:foreground ,gn-bronze))))
   `(diredfl-autofile-name ((t (:background ,gn-surface))))

   ;; Compilation
   `(compilation-info ((t (:foreground ,gn-bronze))))
   `(compilation-warning ((t (:foreground ,gn-amber :bold t))))
   `(compilation-error ((t (:foreground ,gn-red+1))))
   `(compilation-mode-line-fail ((t (:foreground ,gn-red :weight bold))))
   `(compilation-mode-line-exit ((t (:foreground ,gn-bronze :weight bold))))

   ;; Diff
   `(diff-removed ((t (:foreground ,gn-red :background nil))))
   `(diff-added ((t (:foreground ,gn-bronze :background nil))))

   ;; Magit
   `(magit-branch ((t (:foreground ,gn-accent))))
   `(magit-diff-hunk-header ((t (:background ,gn-surface))))
   `(magit-diff-file-header ((t (:background ,gn-bg+3))))
   `(magit-log-sha1 ((t (:foreground ,gn-red+1))))
   `(magit-log-author ((t (:foreground ,gn-accent))))
   `(magit-log-head-label-head ((t (:background ,gn-surface :foreground ,gn-fg))))
   `(magit-log-head-label-local ((t (:background ,gn-surface :foreground ,gn-accent))))
   `(magit-log-head-label-remote ((t (:background ,gn-surface :foreground ,gn-bronze))))
   `(magit-log-head-label-tags ((t (:background ,gn-surface :foreground ,gn-amber))))
   `(magit-item-highlight ((t (:background ,gn-surface))))
   `(magit-tag ((t (:background ,gn-bg :foreground ,gn-amber))))
   `(magit-blame-heading ((t (:background ,gn-surface :foreground ,gn-fg))))

   ;; org-mode
   `(org-agenda-structure ((t (:foreground ,gn-accent))))
   `(org-column ((t (:background ,gn-bg-1))))
   `(org-column-title ((t (:background ,gn-bg-1 :underline t :weight bold))))
   `(org-done ((t (:foreground ,gn-bronze))))
   `(org-todo ((t (:foreground ,gn-accent))))
   `(org-upcoming-deadline ((t (:foreground ,gn-amber))))

   ;; Helm
   `(helm-candidate-number ((t (:background ,gn-surface :foreground ,gn-accent :bold t))))
   `(helm-ff-directory ((t (:foreground ,gn-accent :background ,gn-bg :bold t))))
   `(helm-ff-executable ((t (:foreground ,gn-bronze))))
   `(helm-ff-file ((t (:foreground ,gn-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t (:background ,gn-red :foreground ,gn-bg))))
   `(helm-ff-symlink ((t (:foreground ,gn-amber :bold t))))
   `(helm-selection-line ((t (:background ,gn-raised))))
   `(helm-selection ((t (:background ,gn-raised :underline nil))))
   `(helm-source-header ((t (:foreground ,gn-accent :background ,gn-bg))))

   ;; Company mode
   `(company-tooltip ((t (:foreground ,gn-fg :background ,gn-surface))))
   `(company-tooltip-annotation ((t (:foreground ,gn-muted :background ,gn-surface))))
   `(company-tooltip-annotation-selection ((t (:foreground ,gn-muted :background ,gn-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,gn-fg :background ,gn-bg-1))))
   `(company-tooltip-mouse ((t (:background ,gn-bg-1))))
   `(company-tooltip-common ((t (:foreground ,gn-accent))))
   `(company-tooltip-common-selection ((t (:foreground ,gn-accent))))
   `(company-scrollbar-fg ((t (:background ,gn-bg-1))))
   `(company-scrollbar-bg ((t (:background ,gn-surface))))
   `(company-preview ((t (:background ,gn-amber))))
   `(company-preview-common ((t (:foreground ,gn-accent :background ,gn-bg-1))))

   ;; Tab bar
   `(tab-bar ((t (:background ,gn-surface :foreground ,gn-muted))))
   `(tab-bar-tab ((t (:background nil :foreground ,gn-accent :weight bold))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; vterm / ansi-term
   `(term-color-black ((t (:foreground ,gn-raised :background ,gn-bg+3))))
   `(term-color-red ((t (:foreground ,gn-amber :background ,gn-amber))))
   `(term-color-green ((t (:foreground ,gn-bronze :background ,gn-bronze))))
   `(term-color-yellow ((t (:foreground ,gn-bronze :background ,gn-bronze))))
   `(term-color-blue ((t (:foreground ,gn-muted :background ,gn-muted))))
   `(term-color-magenta ((t (:foreground ,gn-amber :background ,gn-amber))))
   `(term-color-cyan ((t (:foreground ,gn-bronze :background ,gn-bronze))))
   `(term-color-white ((t (:foreground ,gn-fg :background ,gn-white))))

   ;; Orderless
   `(orderless-match-face-0 ((t (:foreground ,gn-accent))))
   `(orderless-match-face-1 ((t (:foreground ,gn-bronze))))
   `(orderless-match-face-2 ((t (:foreground ,gn-blue))))
   `(orderless-match-face-3 ((t (:foreground ,gn-purple))))

   ;; Flycheck / Flymake
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gn-red) :inherit unspecified))
      (t (:foreground ,gn-red :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gn-amber) :inherit unspecified))
      (t (:foreground ,gn-amber :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gn-bronze) :inherit unspecified))
      (t (:foreground ,gn-bronze :weight bold :underline t))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'gilded-noir)

;; Local Variables:
;; no-byte-compile: t
;; End:
