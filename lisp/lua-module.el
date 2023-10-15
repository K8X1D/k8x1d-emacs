;;; package --- Summary

;;; Commentary:

;;; Code:

;; Syntax highlight
(use-package lua-mode)


;; Lsp
(use-package eglot
  :if (equal lsp-framework "eglot")
  :hook (lua-mode . eglot-ensure))

(provide 'lua-module)
;;; lua-module.el ends here
