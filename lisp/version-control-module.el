
;; Version control management
(use-package magit
  :bind ("C-c g" . magit-status))

;; Issue creation/interaction
(use-package forge
  :after magit)

;; List todo in magit buffer
(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(provide 'version-control-module)
