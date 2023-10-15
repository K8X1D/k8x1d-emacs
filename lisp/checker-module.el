;;; package --- Summary

;;; Commentary:

;;; Code:

;; Checker
(use-package flymake
  :defer t
  :if (equal lsp-framework "eglot")
  :hook (prog-mode . flymake-mode))

(use-package flymake-collection
  :defer t
  :if (equal lsp-framework "eglot")
  :hook (after-init . flymake-collection-hook-setup))


(use-package flycheck
  :defer t
  :if (equal lsp-framework "lsp-mode")
  :hook (after-init . global-flycheck-mode)
  )

(use-package consult-flycheck
  :defer t
  :if (equal lsp-framework "lsp-mode")
  :bind (("M-g f" . consult-flycheck))
  )

(provide 'checker-module)
;;; checker-module.el ends here
