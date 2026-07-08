;;; sql.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SQL Related Config
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

(after! format
  (set-formatter!
    'sqlfluff
    '("sqlfluff" "format"
      "--dialect" "tsql"
      "-")
    :modes '(sql-mode)))

;; Add the directory containing emacs-db-ui.el to the load path
(add-to-list 'load-path "~/emacs-db-ui/")

;; Require the package
(require 'emacs-db-ui)

;; Optional: Enable SQL completion in SQL buffers (recommended)
(add-hook 'sql-interactive-mode-hook #'emacs-db-ui-sql-complete-mode)
(add-hook 'sql-mode-hook #'emacs-db-ui-sql-complete-mode)
