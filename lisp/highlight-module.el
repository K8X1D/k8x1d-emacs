;; Highlight searched terms
(use-package anzu
  :hook (after-init . global-anzu-mode)
  :config
  (setq anzu-cons-mode-line-p nil)
  )

;; Highlight todo
(use-package hl-todo
  :hook (after-init . global-hl-todo-mode))

;; Highlight colors
(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

(provide 'highlight-module)
