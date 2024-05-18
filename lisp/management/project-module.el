;; consult integration
;; (use-package consult-jump-project
;;   :custom (consult-jump-direct-jump-modes '(dired-mode))
;;   :bind ("C-x p j" . consult-jump-project))

;; Keybindings
(use-package project
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "p" '(:keymap project-prefix-map
		  :which-key "Project")
    )
  )




(provide 'project-module)
