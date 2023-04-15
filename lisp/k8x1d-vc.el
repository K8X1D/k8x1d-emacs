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
  :bind
   (("C-x g y" . 'k8x1d/magit-status-w-forge-upd)
   ("C-x g s" . 'magit-status)))

(use-package forge
  :after magit
  :bind ("C-x g i c" ("Create" . forge-create-issue)
	 "C-x g i l" ("List" . forge-list-issues))
  :config
  (setq auth-sources '("~/.authinfo.gpg")))


(use-package magit-todos
  :after magit
  :bind ("C-x g t l" ("List" . magit-todos-list)))

(use-package magit-org-todos
  :after magit
  :bind ("C-x p t" ("Todo list" . magit-org-todos--magit-visit-org-todo))
  :config
  (magit-org-todos-autoinsert))

(provide 'k8x1d-vc)
