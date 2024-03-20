;; Version control management
(use-package magit
  :bind ("C-c g" . magit-status))

;; Issue creation/interaction
(use-package forge
  :after magit)

;; List todo in magit buffer
(use-package magit-todos
  :after magit
  :hook (magit-mode . magit-todos-mode)
  )

;; Evil compatibility
(use-package magit
  :config
  :hook (git-commit-mode . evil-insert-state)
  )

(provide 'version-control-module)
