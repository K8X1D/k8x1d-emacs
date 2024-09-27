;; Syntaxe highligh + REPL + +++
(use-package ess-r-mode
  :mode "\\.R\\'"
  :config
  (setq ess-eval-visibly 'nowait) 
  )

;; LSP
(use-package lsp-mode
  :hook
  (ess-r-mode . lsp-deferred)
  )

;; Diagnostic
(use-package flycheck
  :hook
  (ess-r-mode . flycheck-mode)
  )

;; Data viewer 
(use-package ess-view-data
  :bind (:map ess-r-mode-map
	      ("C-c RET" . ess-view-data-print)))

(provide 'r-module)
