;;; unity.el -*- lexical-binding: t; -*-

;; Enable unity.el's interop hooks (auto-moves/deletes .meta files with their
;; asset, etc). Used alongside `rider2emacs' so Unity opens files in emacsclient
;; and generates .sln/.csproj for OmniSharp.
(add-hook 'after-init-hook #'unity-mode)

;; Let project.el recognise a Unity/C# project by its .sln file, so lsp-mode
;; (and eglot) can locate the project root even without a VCS marker.
(cl-defmethod project-root ((project (head csharp)))
  (cdr project))

(defun +unity-project-try-csharp (dir)
  "Treat a directory containing a .sln file as a C# project root."
  (if-let ((root (locate-dominating-file
                  dir (lambda (d)
                        (directory-files d nil "\\.sln$" t 1)))))
      (cons 'csharp root)))

(add-hook 'project-find-functions #'+unity-project-try-csharp)

;; ShaderLab LSP for .shader / .cginc files. The lsp-shader client targets the
;; `shader-ls' .NET tool. NOTE: shader-ls 0.1.3 is built against the EOL
;; net7.0 runtime and won't run on a net8-only install (Arch dropped net7), so
;; the auto-hook is intentionally disabled. shader-mode still provides syntax
;; highlighting regardless. To re-enable once a compatible runtime is present,
;; install the server (`dotnet tool install -g shader-ls') and uncomment:
;;
;; (with-eval-after-load 'lsp-shader
;;   (when (executable-find "shader-ls")
;;     (add-hook 'shader-mode-hook #'lsp-deferred)))

(after! csharp-mode
  ;; Don't let OmniSharp choke trying to resolve every Unity package; rely on
  ;; the .sln/.csproj that rider2emacs tricks Unity into generating.
  (setq lsp-auto-guess-root t)

  ;; Force CSharpier as the C# formatter. By default Doom's format module
  ;; delegates to the LSP server's formatter in lsp-managed buffers (via
  ;; `+format-with-lsp-toggle-h', which only fires when `apheleia-formatter' is
  ;; nil). Setting it buffer-locally to `csharpier' here prevents that takeover,
  ;; so `SPC =' (`+format/buffer' -> `apheleia-format-buffer') and format-on-save
  ;; both run CSharpier instead of OmniSharp's (optionless) formatting. Requires
  ;; `dotnet tool install -g csharpier'.
  (add-hook 'csharp-mode-hook
            (defun +unity-csharp-use-csharpier-h ()
              (setq-local apheleia-formatter 'csharpier)))

  ;; Show Unity/C# doc strings in the minibuffer as the cursor moves over
  ;; symbols (eldoc hover). OmniSharp registers textDocument/hover dynamically
  ;; and returns XML doc summaries for Unity APIs (e.g. Transform.Translate).
  (setq lsp-eldoc-enable-hover t
        lsp-eldoc-render-all nil)

  ;; Bind K directly to lsp-describe-thing-at-point in csharp buffers so
  ;; pressing K on a Unity method/property shows its full documentation in a
  ;; help buffer (signature + XML doc summary).
  (map! :map csharp-mode-map :n "K" #'lsp-describe-thing-at-point)

  ;; Auto-insert parentheses after completing a method name. OmniSharp returns
  ;; completions as plain text (insertTextFormat 1) with just the label — no
  ;; snippet, no parens. This advice fires after lsp-mode inserts a completion
  ;; item: if it was a Method (kind 2) or Function (kind 3), append () and
  ;; place cursor between them so you can type args immediately. Signature help
  ;; (parameter hints) activates automatically via lsp-signature-auto-activate.
  (defun +unity-csharp-auto-parens-h (candidate &rest _)
    "Add () after a method/function completion if not already present."
    (when (derived-mode-p 'csharp-mode)
      (let* ((props (text-properties-at 0 candidate))
             (item (plist-get props 'lsp-completion-item))
             (kind (when item (lsp:completion-item-kind? item))))
        (when (and (memq kind '(2 3))   ; 2=Method, 3=Function
                   (not (eq (char-after) ?\()))
          (insert "()")
          (backward-char 1)))))
  (with-eval-after-load 'lsp-completion
    (advice-add #'lsp-completion--exit-fn :after #'+unity-csharp-auto-parens-h))

  ;; Surface yasnippet snippets in corfu completion alongside LSP suggestions.
  ;; `yasnippet-capf' is a CAPF that offers snippet keys (for, mono, start,
  ;; etc.) as completion candidates — selecting one expands it inline.
  (add-hook 'csharp-mode-hook
            (defun +unity-csharp-add-yas-capf-h ()
              (add-hook 'completion-at-point-functions #'yasnippet-capf 15 t))))

;; Keep the daemon alive when closing the last GUI frame. Without this, the X
;; window-manager close button (and `C-x C-c') calls `save-buffers-kill-emacs',
;; which kills the entire daemon process. In daemon mode, ask before killing;
;; if declined, make the frame invisible (the X window closes, daemon survives,
;; and `rider2emacs' creates a fresh frame on the next Unity file open). To kill
;; the daemon without prompting, use `emacsclient -e "(kill-emacs)"' or
;; `C-u M-x save-buffers-kill-emacs'.
(when (daemonp)
  (setq confirm-kill-emacs
        (lambda (&optional _)
          (if (y-or-n-p "Kill the Emacs daemon? (no = just close this frame) ")
              t
            (ignore-errors (make-frame-invisible (selected-frame)))
            nil))))
