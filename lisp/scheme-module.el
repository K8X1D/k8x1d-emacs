;; -*- lexical-binding: t -*-

;; Syntax highlight
(use-package geiser)
(use-package geiser-guile
  :diminish)
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

;; Notebook
(use-package org
  :config
  (add-to-list 'org-babel-load-languages '(scheme . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  )


(provide 'scheme-module)
