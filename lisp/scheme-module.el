;;; package --- Summary

;;; Commentary:

;;; Code:

;; REPL
(use-package geiser-guile)

;; LSP
(use-package lsp-scheme
  :if (equal lsp-framework "lsp-mode")
  :hook (scheme-mode . lsp-scheme-guile)
  )

;; Checker
(use-package flymake-guile
  :if (equal lsp-framework "eglot")
  :hook (scheme-mode-hook . flymake-guile))

(use-package flycheck-guile
  :if (equal lsp-framework "lsp-mode"))

(provide 'scheme-module)
;;; scheme-module.el ends here
