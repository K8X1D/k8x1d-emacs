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

(use-package flycheck
  :if (equal k8x1d-lsp-module "lsp-mode")
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-mode-line-prefix "!" )
  )

(use-package consult-flycheck
  :if (equal k8x1d-lsp-module "lsp-mode")
  :bind (("M-g f" . consult-flycheck))
  )

(use-package flycheck-guile
  :if (equal k8x1d-lsp-module "lsp-mode"))

(provide 'k8x1d-checker)
;;; k8x1d-system.el ends here
