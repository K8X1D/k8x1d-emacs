;; consult integration
;; (use-package consult-jump-project
;;   :custom (consult-jump-direct-jump-modes '(dired-mode))
;;   :bind ("C-x p j" . consult-jump-project))

(use-package project-butler
  :config
  (keymap-set project-prefix-map "k" #'project-butler-cleanup)
  (customize-set-variable 'project-butler-projects-list
                          '(("~/.config/k8x1d-emacs/" .     ; project
                             ("1|2"                     ; window pattern
                              ("README.md" "init.el")))  ; path-list
                            ))
  )

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
