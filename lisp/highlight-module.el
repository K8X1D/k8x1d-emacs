;; -*- lexical-binding: t; -*-

(use-package hl-line
  :hook
  (prog-mode . hl-line-mode))

;; TODO: exclude org-mode
(use-package hl-todo
  :hook
  (after-init . global-hl-todo-mode))

;; Color parenthesis
(use-package rainbow-delimiters
  :hook
  (after-init . rainbow-delimiters-mode))
	      
;; Highlight colors name
(use-package rainbow-mode
  :hook
  (after-init . rainbow-mode))



(provide 'highlight-module)
