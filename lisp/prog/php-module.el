
;; Syntax highlight
(use-package php-mode)

;; LSP
(use-package eglot
  :if (string= k8x1d/lsp-backend "eglot")
  :hook (php-mode . eglot-ensure)
  )

;; Checker
(use-package flymake-php
  :hook (php-mode . flymake-php-load))

(provide 'php-module)
