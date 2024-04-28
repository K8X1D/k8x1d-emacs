;; Syntax highlight
(use-package fennel-mode)

;; Checker
(use-package flymake-fennel
  :hook (fennel-mode . flymake-fennel-setup))

(provide 'fennel-module)
