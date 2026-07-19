(setq custom-file "~/.emacs.custom.el")
(package-initialize)

;; Quiet first-run package install
(setq package-check-signature nil)

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
(load "~/.emacs.rc/autocommit-rc.el")

;;; Appearance
(defun rc/set-font ()
  (when (eq system-type 'gnu/linux)
    (set-frame-font (font-spec :family "Iosevka Nerd Font" :size 17 :weight 'medium) nil t)))

(rc/set-font)
(add-hook 'after-make-frame-functions (lambda (_) (rc/set-font)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(rc/require-theme 'gruber-darker)
;; (rc/require-theme 'zenburn)
;; (load-theme 'adwaita t)

(eval-after-load 'zenburn
  (set-face-attribute 'line-number nil :inherit 'default))

;;; ido
(rc/require 'smex 'ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; uxntal-mode

(ignore-errors (rc/require 'uxntal-mode))

;;; Haskell mode
(rc/require 'haskell-mode)

(setq haskell-process-type 'cabal-new-repl)
(setq haskell-process-log t)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

(ignore-errors
  (require 'basm-mode)
  (require 'fasm-mode)
  (add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))
  (require 'porth-mode)
  (require 'noq-mode)
  (require 'jai-mode)
  (require 'simpc-mode)
  (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
  (add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))
  (require 'tatr)
  (require 'umka-mode)
  (require 'c3-mode))

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

;;; display-line-numbers-mode
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;;; helm
(rc/require 'helm)

(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-c h f") 'helm-find)
(when (fboundp 'helm-org-agenda-files-headings)
  (global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings))
(global-set-key (kbd "C-c h r") 'helm-recentf)

;;; yasnippet
(rc/require 'yasnippet)

(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))

(yas-global-mode 1)

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; nxml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; tramp
;;; http://stackoverflow.com/questions/13794433/how-to-disable-autosave-for-tramp-buffers-in-emacs
(setq tramp-auto-save-directory "/tmp")

;;; powershell
(rc/require 'powershell)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
(add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode))

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

;;; Company
(rc/require 'company)
(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

;;; Typescript
(rc/require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode))

;;; Tide
(rc/require 'tide)

(defun rc/turn-on-tide-and-flycheck ()  ;Flycheck is a dependency of tide
  (interactive)
  (tide-setup)
  (flycheck-mode 1))

(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)

;;; Proof general
(rc/require 'proof-general)
(add-hook 'coq-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-q C-n")
                            (quote proof-assert-until-point-interactive))))

;;; LaTeX mode
(add-hook 'tex-mode-hook
          (lambda ()
            (interactive)
            (add-to-list 'tex-verbatim-environments "code")))

(setq font-latex-fontify-sectioning 'color)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; Ebisp
(add-to-list 'auto-mode-alist '("\\.ebi\\'" . lisp-mode))

;;; Packages that don't require configuration
(rc/require
 'scala-mode
 'd-mode
 'yaml-mode
 'glsl-mode
 'tuareg
 'lua-mode
 'less-css-mode
 'graphviz-dot-mode
 'clojure-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'jinja2-mode
 'markdown-mode
 'purescript-mode
 'nix-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'kotlin-mode
 'php-mode
 'racket-mode
 'qml-mode
 'ag
 'elpy
 'typescript-mode
 'rfc-mode
 'sml-mode
 )

(load "~/.emacs.shadow/shadow-rc.el" t)

(defun astyle-buffer (&optional justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))

(require 'compile)

;; pascalik.pas(24,44) Error: Can't evaluate constant expression

compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

;;; LSP support via eglot (built-in since Emacs 29)
(require 'eglot)

;; Use pyright for Python, lua-language-server for Lua
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(lua-mode . ("lua-language-server"))))

(defun rc/eglot-maybe ()
  (interactive)
  (eglot-ensure))

(add-hook 'python-mode-hook 'rc/eglot-maybe)
(add-hook 'rust-mode-hook 'rc/eglot-maybe)
(add-hook 'kotlin-mode-hook 'rc/eglot-maybe)
(add-hook 'php-mode-hook 'rc/eglot-maybe)
(add-hook 'java-mode-hook 'rc/eglot-maybe)
(add-hook 'c-mode-hook 'rc/eglot-maybe)
(add-hook 'c++-mode-hook 'rc/eglot-maybe)
(add-hook 'lua-mode-hook 'rc/eglot-maybe)
(add-hook 'yaml-mode-hook 'rc/eglot-maybe)
(add-hook 'dockerfile-mode-hook 'rc/eglot-maybe)
(add-hook 'nix-mode-hook 'rc/eglot-maybe)
(add-hook 'sh-mode-hook 'rc/eglot-maybe)
(add-hook 'cmake-mode-hook 'rc/eglot-maybe)

;; Disable flymake in python-mode since elpy has its own
(with-eval-after-load 'python
  (add-hook 'python-mode-hook (lambda () (flymake-mode -1))))

(global-set-key (kbd "M-.") 'xref-find-definitions)
(global-set-key (kbd "M-,") 'xref-find-references)
(global-set-key (kbd "C-c r") 'eglot-rename)

;; Vim-like end of word (like 'e')
(defun rc/end-of-word ()
  "Move to end of current word (like vim's 'e')."
  (interactive)
  (forward-word)
  (backward-word)
  (right-char))
(global-set-key (kbd "C-c e") 'rc/end-of-word)

;; Custom movement swap: C-j/k for up/down, C-n/p for old C-j/k
(defvar rc/swapped-keys-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-j") 'next-line)
    (define-key map (kbd "C-k") 'previous-line)
    (define-key map (kbd "C-n") 'newline-and-indent)
    (define-key map (kbd "C-p") 'kill-line)
    map)
  "Keymap swapping C-j/k with C-n/p.")

(define-minor-mode rc/swapped-keys-mode
  "Minor mode that swaps C-j/k with C-n/p for movement."
  :global t
  :keymap rc/swapped-keys-map)

(rc/swapped-keys-mode 1)

(load-file custom-file)

;; Override whitespace-style to hide $ and · markers
(setq whitespace-style '(face tabs spaces trailing space-before-tab indentation empty))
