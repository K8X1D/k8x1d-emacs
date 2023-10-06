;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package magit
  :config
  (setq magit-define-global-key-bindings t)
  )


(use-package forge
  :init
  (setq forge-add-default-bindings nil)
  :after magit
  ;; :bind
  ;; (("gli" '(forge-list-issues :which-key "Issues")
  ;; "gc" '(:ignore t :which-key "Create")
  ;; "gci" '(forge-create-issue :which-key "Issues")
  ;; ))
  ;; :bind ("C-x g i c" ("Create" . )
  ;; 	 "C-x g i l" ("List" . forge-list-issues))
  :config
  (setq auth-sources '("~/.authinfo.gpg")))

(use-package orgit-forge)

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
