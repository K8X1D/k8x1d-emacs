
;; Syntax highlight + REPL
(use-package python
  :config
  (setq major-mode-remap-alist
	'((python-mode . python-ts-mode)))
  )

;; LSP
(use-package eglot
  :hook (python-ts-mode . eglot-ensure))

;; Documentation
(use-package eldoc
  :hook (python-ts-mode . eldoc-mode))


(provide 'python-module)
