;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(require 'doom)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'doom-one)
(setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'macchiato)
(setq catppuccin-flavor 'mocha)

(setq doom-font (font-spec :family "IoskeleyMono Nerd Font" :size 15 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "IoskeleyMono Nerd Font" :size 15))

;; (set-frame-parameter (selected-frame) 'alpha '(85 85))
;; (add-to-list 'default-frame-alist '(alpha 85 85))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")
(setq select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq shell-file-name (executable-find "bash"))

(setq-default
 vterm-shell "/bin/fish"
 explicit-shell-file-name "/bin/fish")

;; remove LSP delays
(after! flycheck
  (setq flycheck-idle-change-delay 0.1))
(after! lsp-mode
  (setq lsp-idle-delay 0.1)
  (setq lsp-completion-enable-additional-text-edit t)
  (setq lsp-modeline-code-actions-enable t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Escape insert mode with jj
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! key-chord
  :config
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "jj"
                    #'evil-normal-state))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window navigation (like Neovim)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :n "C-h" #'evil-window-left
 :n "C-j" #'evil-window-down
 :n "C-k" #'evil-window-up
 :n "C-l" #'evil-window-right)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resize windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :n "M-h" #'evil-window-decrease-width
 :n "M-l" #'evil-window-increase-width
 :n "M-j" #'evil-window-increase-height
 :n "M-k" #'evil-window-decrease-height)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insert mode helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :i "C-h" #'left-char
 :i "C-l" #'right-char
 :i "C-x" #'delete-backward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Leader‑key bindings for the evil‑mc (multiple‑cursors) integration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! evil-mc
  (evil-mc-mode 1))

(map! :leader
      :prefix ("m c" . "multiple cursors")
      "m" #'evil-mc-make-all-cursors
      "n" #'evil-mc-make-and-goto-next-cursor
      "p" #'evil-mc-make-and-goto-prev-cursor
      "d" #'evil-mc-make-and-goto-next-match
      "s" #'evil-mc-skip-and-goto-next-match
      "j" #'evil-mc-make-cursor-move-next-line
      "k" #'evil-mc-make-cursor-move-prev-line
      "q" #'evil-mc-undo-all-cursors
      "z" #'+multiple-cursors/evil-mc-toggle-cursor-here)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; System clipboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun +default/yank-to-clipboard (beg end)
  "Yank region BEG END to system clipboard."
  (interactive "r")
  (evil-yank beg end ?+))

(map!
 :leader
 :desc "Yank to clipboard"
 "y" #'+default/yank-to-clipboard)

(map!
 :nv "C-y"
 #'+default/yank-to-clipboard)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Snippet navigation (ported from nvim luasnip → yasnippet)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :i "C-e" #'yas-expand
 :i "C-j" #'yas-next-field-or-maybe-expand
 :i "C-k" #'yas-prev-field)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Workspace / Tab navigation (ported from nvim C-t, C-x, <leader>1-8)
;; C-t/C-x conflict with core Emacs, using s- prefix instead
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :n "s-t" #'+workspace/new
 :n "s-x" #'+workspace/delete
 :n "s-1" #'+workspace/switch-to-0
 :n "s-2" #'+workspace/switch-to-1
 :n "s-3" #'+workspace/switch-to-2
 :n "s-4" #'+workspace/switch-to-3
 :n "s-5" #'+workspace/switch-to-4
 :n "s-6" #'+workspace/switch-to-5
 :n "s-7" #'+workspace/switch-to-6
 :n "s-8" #'+workspace/switch-to-7)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Config editing (ported from nvim <leader>v/z/o/O)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 :desc "Edit Doom config"
 "v" #'doom/open-private-config
 :desc "Config directory"
 "z" #'(lambda () (interactive) (find-file doom-private-dir))
 :desc "Reload config"
 "o" #'doom/reload
 :desc "Restart Emacs"
 "O" #'doom/restart)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility maps (ported from nvim)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 ;; :desc "Format buffer"
 ;; "m" #'+format/buffer
 :desc "Select all"
 "a" #'mark-whole-buffer
 :desc "Write & quit all"
 "Q" #'(lambda () (interactive) (evil-save-and-quit)))

;; nvim <C-s> = :%s/ — C-s is isearch in Emacs, using s-s instead
(map!
 :nv "s-s" #'query-replace)

;; Spelling correction (ported from nvim <leader>c = 1z=)
(map!
 :leader
 :desc "Spelling correction"
 "c" #'ispell-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Quickfix / diagnostics list (ported from nvim <C-q> = :copen)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! flycheck
  (map!
   :n "s-q" #'flycheck-list-errors))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Inlay hints toggle (ported from nvim <leader>h)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! lsp-mode
  (map!
   :leader
   :desc "Toggle inlay hints"
   "h" #'lsp-toggle-inlay-hints))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Line / buffer diagnostics (ported from nvim <leader>d / <leader>D)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! flycheck
  (map!
   :leader
   :desc "Show line diagnostics"
   "d" #'flycheck-display-error-at-point))

(map!
 :leader
 :desc "Show buffer diagnostics"
 "x" #'+default/diagnostics)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 :desc "Toggle Treemacs"
 "e" #'+treemacs/toggle
 :desc "Dired (file explorer)"
 "-" #'dired-jump)

;; Allocate a keybind for creating a new file in dired mode
(after! dired
  (map! :map dired-mode-map
        :n "-" #'dired-create-empty-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Better navigation (ported from nvim C-d, C-u, n, N with recenter)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(advice-add #'evil-scroll-page-down :after #'recenter)
(advice-add #'evil-scroll-page-up :after #'recenter)
(advice-add #'evil-search-next :after #'recenter)
(advice-add #'evil-search-previous :after #'recenter)

;; nvim <esc> -> :noh — clear search highlight after navigating
(map!
 :n "s-l" #'(lambda () (interactive) (evil-ex-nohighlight) (recenter)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pounce → Avy (ported from nvim h/H for Pounce)
;; nvim remaps h to :Pounce — in Emacs h would break left movement
;; Using s-h / s-H instead
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :nv "s-h" #'avy-goto-char-timer
 :n  "s-H" #'avy-goto-char-2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insert mode: quickly enter new line (ported from nvim C-;)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :i "s-;" #'evil-open-below)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Splits
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 :desc "Vertical split"
 "wv" #'+evil/window-vsplit-and-follow
 :desc "Horizontal split"
 "ws" #'+evil/window-split-and-follow)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Telescope → Consult (ported from nvim <leader>s*)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 :prefix "s"
 :desc "Search buffer symbol"
 "s" #'consult-line
 :desc "Grep symbol at point"
 "i" #'+default/search-project-for-symbol-at-point
 :desc "Recent files"
 "o" #'consult-recent-file
 :desc "Help tags"
 "h" #'consult-info
 :desc "Man pages"
 "m" #'consult-man
 :desc "LSP references"
 "r" #'+lookup/references
 :desc "LSP definitions"
 "d" #'+lookup/definition
 :desc "LSP type definitions"
 "T" #'+lookup/type-definition
 :desc "Find files"
 "g" #'project-find-file
 :desc "Diagnostics"
 "x" #'+default/diagnostics
 :desc "Code actions"
 "a" #'lsp-execute-code-action
 :desc "Spell suggest"
 "c" #'ispell-word
 :desc "Keymaps"
 "k" #'describe-bindings
 :desc "Command palette"
 "t" #'execute-extended-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit (ported from nvim <leader>l = lazygit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 :desc "Magit status"
 "l" #'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test keybinds (ported from nvim neotest <leader>t*)
;; Using <leader>r prefix since SPC t is Doom's toggle prefix
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader
 :prefix "r"
 :desc "Run nearest test"
 "r" #'compile
 :desc "Run current file tests"
 "f" #'compile
 :desc "Debug nearest test"
 "d" #'compile
 :desc "Stop tests"
 "s" #'kill-compilation
 :desc "Toggle output panel"
 "o" #'switch-to-errors
 :desc "Toggle summary"
 "S" #'compilation-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Common leader keys (ported / extended from nvim)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :leader

 :desc "Save"
 "w w" #'save-buffer

 :desc "Quit buffer"
 "q" #'evil-quit

 :desc "Format buffer"
 "=" #'+format/buffer

 :desc "Recent files"
 "fr" #'consult-recent-file

 :desc "Find buffer"
 "b" #'consult-buffer

 :desc "Search project"
 "/" #'+default/search-project

 :desc "Project search symbol"
 "*" #'+default/search-project-for-symbol-at-point

 :desc "Magit"
 "g" #'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things from nvim that don't have direct Emacs equivalents:
;;
;; - Treesitter textobjects (af/if/ac/ic/ab/ib/aa/ia) → Use Doom's
;;   built-in evil-textobjects instead (SPC h t for help)
;; - Treesitter swap (<leader>sp / <leader>sP) → No direct equivalent
;; - DBUI (<leader>db) → No direct equivalent in base Doom
;; - fff (<leader>f) → Covered by project-find-file / consult
;; - Legacy vim ex commands (g=, gK, C-r patterns) → Use native Emacs fns
;; - nvim-tmux-navigation → Doom has its own tmux module enabled
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(after! sql
  (setq sql-ms-program "sqlcmd"
        sql-ms-options '("-C")))

(defvar my-sqlserver-connection
  '(:server "localhost"
    :user "sa"
    :password "Str0ngP4ssw0rd!"
    :database "AdventureWorksDW2025"))

(defvar my-sqlserver-completions-cache nil)

(defun my-sqlserver-query (query)
  (let* ((server (plist-get my-sqlserver-connection :server))
         (user (plist-get my-sqlserver-connection :user))
         (password (plist-get my-sqlserver-connection :password))
         (database (plist-get my-sqlserver-connection :database))
         (cmd (format "sqlcmd -C -S %s -U %s -P '%s' -d %s -h -1 -W -Q \"%s\""
                      server user password database query)))
    (split-string (shell-command-to-string cmd) "\n" t "[ \t\r\n]+")))

(defun my-sqlserver-refresh-completions ()
  (interactive)
  (setq my-sqlserver-completions-cache
        (append
         ;; tables/views
         (my-sqlserver-query
          "SET NOCOUNT ON; SELECT TABLE_SCHEMA + '.' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;")
         ;; columns
         (my-sqlserver-query
          "SET NOCOUNT ON; SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS;")
         ;; schema.table.column
         (my-sqlserver-query
          "SET NOCOUNT ON; SELECT TABLE_SCHEMA + '.' + TABLE_NAME + '.' + COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS;")))
  (message "Loaded %d SQL completions" (length my-sqlserver-completions-cache)))

(defun my-sqlserver-completion-at-point ()
  (let ((bounds (bounds-of-thing-at-point 'symbol)))
    (when bounds
      (list (car bounds)
            (cdr bounds)
            (or my-sqlserver-completions-cache
                (progn
                  (my-sqlserver-refresh-completions)
                  my-sqlserver-completions-cache))))))

(add-hook 'sql-mode-hook
          (lambda ()
            (corfu-mode 1)
            (setq-local corfu-auto t
                        corfu-auto-prefix 1
                        corfu-auto-delay 0.1)
            (setq-local completion-at-point-functions
                        (cons #'my-sqlserver-completion-at-point
                              (remove #'my-sqlserver-completion-at-point
                                      completion-at-point-functions)))))


;; Add the directory containing emacs-db-ui.el to the load path
(add-to-list 'load-path "~/emacs-db-ui/")

;; Require the package
(require 'emacs-db-ui)

;; removes the need to confirm when quitting
(setq confirm-kill-emacs nil)

;; Optional: Enable SQL completion in SQL buffers (recommended)
(add-hook 'sql-interactive-mode-hook #'emacs-db-ui-sql-complete-mode)
(add-hook 'sql-mode-hook #'emacs-db-ui-sql-complete-mode)


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
        `((array          :fn ,(my-corfu-icon "󰅪") :face font-lock-type-face)
          (boolean        :fn ,(my-corfu-icon "") :face font-lock-builtin-face)
          (class          :fn ,(my-corfu-icon "") :face font-lock-type-face)
          (color          :fn ,(my-corfu-icon "") :face font-lock-constant-face)
          (constant       :fn ,(my-corfu-icon "") :face font-lock-constant-face)
          (constructor    :fn ,(my-corfu-icon "󰆧") :face font-lock-function-name-face)
          (enum           :fn ,(my-corfu-icon "") :face font-lock-type-face)
          (enum-member    :fn ,(my-corfu-icon "") :face font-lock-constant-face)
          (event          :fn ,(my-corfu-icon "") :face font-lock-warning-face)
          (field          :fn ,(my-corfu-icon "") :face font-lock-variable-name-face)
          (file           :fn ,(my-corfu-icon "") :face font-lock-string-face)
          (folder         :fn ,(my-corfu-icon "") :face font-lock-string-face)
          (function       :fn ,(my-corfu-icon "󰆧") :face font-lock-function-name-face)
          (interface      :fn ,(my-corfu-icon "") :face font-lock-type-face)
          (keyword        :fn ,(my-corfu-icon "") :face font-lock-keyword-face)
          (method         :fn ,(my-corfu-icon "󰆧") :face font-lock-function-name-face)
          (module         :fn ,(my-corfu-icon "󰅩") :face font-lock-constant-face)
          (namespace      :fn ,(my-corfu-icon "󰅩") :face font-lock-constant-face)
          (null           :fn ,(my-corfu-icon "󰢤") :face font-lock-constant-face)
          (number         :fn ,(my-corfu-icon "󰎠") :face font-lock-constant-face)
          (object         :fn ,(my-corfu-icon "󰅩") :face font-lock-type-face)
          (operator       :fn ,(my-corfu-icon "") :face font-lock-keyword-face)
          (package        :fn ,(my-corfu-icon "󰆧") :face font-lock-constant-face)
          (property       :fn ,(my-corfu-icon "") :face font-lock-variable-name-face)
          (reference      :fn ,(my-corfu-icon "") :face font-lock-variable-name-face)
          (snippet        :fn ,(my-corfu-icon "") :face font-lock-string-face)
          (string         :fn ,(my-corfu-icon "") :face font-lock-string-face)
          (struct         :fn ,(my-corfu-icon "") :face font-lock-type-face)
          (text           :fn ,(my-corfu-icon "󰀬") :face font-lock-doc-face)
          (type-parameter :fn ,(my-corfu-icon "") :face font-lock-type-face)
          (unit           :fn ,(my-corfu-icon "") :face font-lock-constant-face)
          (value          :fn ,(my-corfu-icon "") :face font-lock-constant-face)
          (variable       :fn ,(my-corfu-icon "") :face font-lock-variable-name-face)
          (t              :fn ,(my-corfu-icon "") :face font-lock-warning-face))))

;; (use-package! nerd-icons-corfu
;;   :after corfu
;;   :config
;;   (add-to-list 'corfu-margin-formatters
;;                #'nerd-icons-corfu-formatter))
