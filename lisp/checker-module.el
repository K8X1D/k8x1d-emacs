;;; package --- Summary

;;; Commentary:

;;; Code:

;; Native option
(use-package flymake
  :if (equal lsp-framework "eglot")
  :hook (prog-mode . flymake-mode))

(use-package flymake-collection
  :if (equal lsp-framework "eglot")
  :hook (after-init . flymake-collection-hook-setup))

;; Alternative
(use-package flycheck
  :if (equal lsp-framework "lsp-mode")
  :hook (prog-mode . flycheck-mode)
  :config
  ;; Custom modeline
  (defun flycheck-mode-line-status-text (&optional status)
    "Get a text describing STATUS for use in the mode line.

STATUS defaults to `flycheck-last-status-change' if omitted or
nil."
    (let ((text (pcase (or status flycheck-last-status-change)
                  (`not-checked "")
                  (`no-checker "-")
                  (`running "*")
                  (`errored "!")
                  (`finished
                   (let-alist (flycheck-count-errors flycheck-current-errors)
                     (if (or .error .warning)
			 (format "!: [%s|%s]" (or .error 0) (or .warning 0))
                       "")))
                  (`interrupted ".")
                  (`suspicious "?"))))
      (concat " " text)))
  )

(use-package consult-flycheck
  :if (equal lsp-framework "lsp-mode")
  :bind (("M-g f" . consult-flycheck))
  )

(provide 'checker-module)
;;; checker-module.el ends here
