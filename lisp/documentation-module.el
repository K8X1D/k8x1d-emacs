(use-package eldoc)

;;(use-package eldoc-overlay
;;  :hook (after-init . eldoc-overlay-mode))

(use-package eldoc-box
  :if (string= k8x1d/lsp-backend "eglot")
  :after eglot
  :bind (:map eglot-mode-map
	      ([remap eldoc-doc-buffer] . eldoc-box-help-at-point))
  )


(provide 'documentation-module)

