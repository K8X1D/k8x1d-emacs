;; Syntaxe highligh + REPL + +++
(use-package ess)

(use-package ess-r-mode
  :ensure nil
  :mode "\\.R\\'"
  :config
  (setq ess-eval-visibly 'nowait) 
  (setq ess-use-flymake nil) 
  )

;; LSP
(use-package lsp-mode
  :if (string= k8x1d/lsp "lsp-mode")
  :hook
  (ess-r-mode . lsp-deferred)
  (ess-r-mode . lsp-ui-sideline-mode)
  )
(use-package eglot 
  :if (string= k8x1d/lsp "eglot")
  :hook
  (ess-r-mode . eglot-ensure )
  )

;; Diagnostic
(use-package flycheck
  :if (string= k8x1d/checker "flycheck")
  :hook
  (ess-r-mode . flycheck-mode)
  )
(use-package flycheck
  :if (string= k8x1d/checker "flymake")
  :hook
  (ess-r-mode . flycheck-mode)
  )

;; Data viewer 
(use-package ess-view-data
  :bind (:map ess-r-mode-map
	      ("C-c RET" . ess-view-data-print)))

(provide 'r-module)
