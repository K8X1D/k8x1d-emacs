;; -*- lexical-binding: t; -*-
(use-package eldoc
  :diminish
  :config
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (setq eldoc-echo-area-use-multiline-p nil)
  ;; (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1)))
  (setq eldoc-display-functions '(eldoc-display-in-buffer))
  )

(provide 'documentation-module)

