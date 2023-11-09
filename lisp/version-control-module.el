;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package magit
  :general 
  (k8x1d/leader-keys
    "g"  '(:ignore t :which-key "Git")
    "gg" '(magit :which-key "Status")
    "gl" '(:ignore t :which-key "List")
    "glt" '(magit-todos-list :which-key "Todo")
    )
  :config
  (setq magit-define-global-key-bindings t)
  )

(use-package forge
  :general 
  (k8x1d/leader-keys
    "gli" '(forge-list-issues :which-key "Issue")
    "gc" '(:ignore t :which-key "Create")
    "gci" '(forge-create-issue :which-key "Issue")
    "gcp" '(forge-create-post :which-key "Post")
    "ga" '(forge-add-repository :which-key "Add repository")
    )
  :init
  (setq forge-add-default-bindings nil)
  :after magit
  :config
  (setq auth-sources '("~/.authinfo.gpg"))
  )

;; (use-package orgit-forge)

(use-package magit-todos
  :after magit
  ;; :general
  ;; (k8x1d/leader-keys
  ;; "glt" '(magit-todos-list :which-key "Todos")
  ;; )
  ;; :bind ("C-x g t l" ("List" . magit-todos-list))
  )

(use-package magit-org-todos
  :after magit
  ;; :general
  ;; (k8x1d/leader-keys
  ;; :keymaps 'project-prefix-map
  ;; "pl" '(magit-org-todos--magit-visit-org-todo :which-key "Todo list"))
  :config
  (magit-org-todos-autoinsert))



(provide 'version-control-module)
;;; version-control-module.el ends here
