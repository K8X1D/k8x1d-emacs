;;; package --- Summary

;;; Commentary:

;;; Code:

;; Cheker
(use-package flymake
  :if (equal lsp-framework "eglot")
  :hook (prog-mode . flymake-mode))

(use-package flymake-collection
  :if (equal lsp-framework "eglot")
  :hook (after-init . flymake-collection-hook-setup))


(use-package flycheck
  :if (equal lsp-framework "lsp-mode")
  :hook (after-init . global-flycheck-mode)
  )

(use-package consult-flycheck
  :if (equal lsp-framework "lsp-mode")
  :bind (("M-g f" . consult-flycheck))
  )

(provide 'checker-module)
;;; checker-module.el ends here
