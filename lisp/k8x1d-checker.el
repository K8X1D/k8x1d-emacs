;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package flymake
  :if (equal k8x1d-lsp-module "eglot")
  :general
  (k8x1d/local-leader-keys
    :keymaps 'flymake-mode-map
    "D" '(:ignore t :which-key "Diagnostic")
    "Db" '(flymake-show-buffer-diagnostics :which-key "List")
    "Dn" '(flymake-goto-next-error :which-key "Next")
    "Dp" '(flymake-goto-prev-error :which-key "Previous")
    "Ds" '(consult-flymake :which-key "Search")
    )
  :bind (("M-g f" . consult-flymake))
  )

;; (use-package flymake-guile
;;   :if (equal k8x1d-lsp-module "eglot")
;;   :straight (:host framagit :repo "flymake-backends/flymake-guile")
;;   :ensure t
;;   :hook (scheme-mode-hook . flymake-guile))

(use-package flycheck
  :if (equal k8x1d-lsp-module "lsp-mode")
  :init
  (defun flycheck-custom-mode-line-status (&optional status)
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
			 (format "%s|%s" (or .error 0) (or .warning 0))
                       "")))
                  (`interrupted ".")
                  (`suspicious "?"))))
      (concat "[" text "]")))
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-mode-line-prefix "!" )
  )

(use-package consult-flycheck
  :if (equal k8x1d-lsp-module "lsp-mode")
  :bind (("M-g f" . consult-flycheck))
  )

(use-package flycheck-guile
  :init
  (require 'flycheck-guile)
  :if (equal k8x1d-lsp-module "lsp-mode"))


(provide 'k8x1d-checker)
;;; k8x1d-system.el ends here
