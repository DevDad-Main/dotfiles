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
              (setq-local apheleia-formatter 'csharpier))))

;; Keep the daemon alive when closing the last GUI frame. Without this, the X
;; window-manager close button (and `C-x C-c') calls `save-buffers-kill-emacs',
;; which kills the entire daemon process. In daemon mode, ask before killing;
;; if declined, delete the frame (the window closes, daemon survives, and
;; `rider2emacs' creates a fresh frame on the next Unity file open). To kill
;; the daemon without prompting, use `emacsclient -e "(kill-emacs)"' or
;; `C-u M-x save-buffers-kill-emacs'.
(when (daemonp)
  (setq confirm-kill-emacs
        (lambda (&optional _)
          (if (y-or-n-p "Kill the Emacs daemon? (no = just close this frame) ")
              t
            (condition-case _ (delete-frame (selected-frame) t) (error nil))
            nil))))
