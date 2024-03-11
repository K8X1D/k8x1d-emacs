;; Highlight searched terms
(use-package anzu
  :hook (after-init . global-anzu-mode)
  :config
  (setq anzu-cons-mode-line-p nil)
  )

;; Highlight todo
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))

;; Highlight colors
(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

;; Highlight indents 
;;(use-package highlight-indentation
;;  :hook (prog-mode . highlight-indentation-mode))
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom-face (highlight-indent-guides-character-face ((t (:inherit 'font-lock-doc-face))))
  :config
  (setq highlight-indent-guides-method 'character)
  )

(provide 'highlight-module)
