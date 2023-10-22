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
  :hook (after-init . global-flycheck-mode)
  :config
  )

(use-package consult-flycheck
  
  :if (equal lsp-framework "lsp-mode")
  :bind (("M-g f" . consult-flycheck))
  )

(provide 'checker-module)
;;; checker-module.el ends here
