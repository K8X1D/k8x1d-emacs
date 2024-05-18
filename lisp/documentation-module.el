(use-package eldoc
  :config
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (setq eldoc-echo-area-use-multiline-p nil)
  ;; (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1)))

  (setq eldoc-display-functions '(eldoc-display-in-buffer))
  )

;;(use-package eldoc-box
;; :if (and (string= k8x1d/lsp-backend "eglot") k8x1d/posframe-support)
;; :after eglot
;; :bind (:map eglot-mode-map
;;	      ([remap eldoc-doc-buffer] . eldoc-box-help-at-point))
;; )

(provide 'documentation-module)

