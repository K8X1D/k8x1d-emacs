;; Syntaxe highligh + REPL + +++
(use-package ess)

(use-package ess-r-mode
  :ensure nil
  :mode "\\.R\\'"
  :config
  (setq ess-eval-visibly 'nowait) 
  (setq ess-use-flymake nil) 
  (setq ess-history-file nil)
  )

;; LSP
(use-package lsp-mode
  :if (string= k8x1d/lsp "lsp-mode")
  :hook
  (ess-r-mode . lsp-deferred)
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
  :config
  (setq flycheck-lintr-caching t)
  ;; (setq flycheck-lintr-linters "default_linters")
  (setq flycheck-lintr-linters "trailing_whitespace_linter(allow_empty_lines = TRUE, allow_in_strings = TRUE)")
  )

(use-package flymake
  :if (string= k8x1d/checker "flymake")
  :hook
  (ess-r-mode . flymake-mode)
  )

;; Data viewer 
(use-package ess-view-data
  :bind (:map ess-r-mode-map
	      ("C-c RET" . ess-view-data-print)))


;; Notebook
(use-package org
  :config
  (add-to-list 'org-babel-load-languages '(R . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  )


(provide 'r-module)
