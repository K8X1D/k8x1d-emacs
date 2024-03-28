(use-package eldoc)

;;(use-package eldoc-overlay
;;  :hook (after-init . eldoc-overlay-mode))

(use-package eldoc-box
  :if (and (string= k8x1d/lsp-backend "eglot") k8x1d/posframe-support)
  :after eglot
  :bind (:map eglot-mode-map
	      ([remap eldoc-doc-buffer] . eldoc-box-help-at-point))
  :config
  (setq eldoc-echo-area-prefer-doc-buffer t)
  )

(provide 'documentation-module)

