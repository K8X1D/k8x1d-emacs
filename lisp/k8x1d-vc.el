;;
;; Git support
;;

(use-package magit
  :defer t
  :init
  (defun k8x1d/magit-status-w-forge-upd ()
    (interactive)
    (magit-todos-mode)
    (magit-status)
    (forge-pull))
  :general
  (k8x1d/leader-keys
    "g"  '(:ignore t :which-key "Git")
    "gg" '(k8x1d/magit-status-w-forge-upd :which-key "Status"))
  :hook
  (with-editor-mode . evil-insert-state)
  )

;;  :bind
;;   (("C-x g y" . 'k8x1d/magit-status-w-forge-upd)
;;   ("C-x g s" . 'magit-status)))

(use-package forge
  :after magit
  :general
  (k8x1d/leader-keys
    "gl" '(:ignore t :which-key "List")
    "gli" '(forge-list-issues :which-key "Issues")
    "gc" '(:ignore t :which-key "Create")
    "gci" '(forge-create-issue :which-key "Issues")
    )
  ;; :bind ("C-x g i c" ("Create" . )
  ;; 	 "C-x g i l" ("List" . forge-list-issues))
  :config
  (setq auth-sources '("~/.authinfo.gpg")))


(use-package magit-todos
  :after magit
  :general
  (k8x1d/leader-keys
    "glt" '(magit-todos-list :which-key "Todos")
    )
 ;; :bind ("C-x g t l" ("List" . magit-todos-list))
  )

(use-package magit-org-todos
  :after magit
  :general
  (k8x1d/leader-keys
    :keymaps 'project-prefix-map
    "pl" '(magit-org-todos--magit-visit-org-todo :which-key "Todo list"))
  :config
  (magit-org-todos-autoinsert))

(provide 'k8x1d-vc)
