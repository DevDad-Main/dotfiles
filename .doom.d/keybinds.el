;;; keybinds.el --- Custom keybindings -*- lexical-binding: t; -*-

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
 :i "C-l" #'right-char)
;; :i "C-x" #'delete-backward-char)

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

(map! :leader
      :prefix ("TAB" . "workspaces")
      "n" #'+workspace/new
      "d" #'+workspace/delete
      "1" #'+workspace/switch-to-0
      "2" #'+workspace/switch-to-1
      "3" #'+workspace/switch-to-2
      "4" #'+workspace/switch-to-3
      "5" #'+workspace/switch-to-4
      "6" #'+workspace/switch-to-5
      "7" #'+workspace/switch-to-6
      "8" #'+workspace/switch-to-7)

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

;; Jump to a file or url thats under the cursors
(map! :leader
      :desc "Dynamically jump to file/url under cursor"
      "f ." #'ffap)

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
 :desc "Grep in current buffer"
 "s" #'consult-line
 :desc "Grep in project"
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
 :desc "Display Keymaps"
 "?" #'describe-bindings
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

 :desc "Alternate buffer"
 ;; Dosen't work as intended, we just overwrite the original SPC `
 ;; "SPC" #'switch-to-prev-buffer
 "SPC" #'evil-switch-to-windows-last-buffer

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
;; removes the need to confirm when quitting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq confirm-kill-emacs nil)

(after! embark
  (setf (alist-get 'kill-buffer embark-pre-action-hooks) nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; allows moving lines up and down in norm/visual mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! drag-stuff
  :defer nil
  :config
  (drag-stuff-global-mode 1)
  (map!
   :n "M-j" #'drag-stuff-down
   :n "M-k" #'drag-stuff-up
   :v "M-j" #'drag-stuff-down
   :v "M-k" #'drag-stuff-up))
