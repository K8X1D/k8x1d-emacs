;; Highlight searched terms
(use-package anzu
  :hook (after-init . global-anzu-mode)
  :custom-face (anzu-mode-line ((t (:foreground ,(doom-color 'green)))))
  (anzu-mode-line-no-match ((t (:foreground ,(doom-color 'red)))))
  :config
  (setq anzu-cons-mode-line-p nil)
  )

;; Highlight todo
(use-package hl-todo
  :hook ((LaTeX-mode prog-mode) . hl-todo-mode)
  ;; FIXME : adjust
  :config
  (add-to-list 'hl-todo-keyword-faces '("XXX" . (doom-color 'red)))
  (add-to-list 'hl-todo-keyword-faces '("XXXX" . (doom-color 'red)))
  )

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
