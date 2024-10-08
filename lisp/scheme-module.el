;; -*- lexical-binding: t -*-

;; Syntax highlight
(use-package geiser)
(use-package geiser-guile)
;; (use-package geiser-repl
;;   :ensure nil
;;   :config
;;   (setq geiser-scheme-implementation 'guile)
;;   )

;; LSP
(use-package lsp-scheme
  :if (string= k8x1d/lsp "lsp-mode")
  :hook
  (scheme-mode  . (lambda ()
                       (lsp-scheme-guile)
                       (lsp-deferred))
  ))

;; Checker
(use-package flycheck-guile
  :if (string= k8x1d/checker "flycheck")
  :hook
  (scheme-mode  . (lambda ()
                    (require 'flycheck-guile)
                    ))
  )


(provide 'scheme-module)
