;;
;; Git support
;;


;; Git interaction
(use-package magit
  :bind
   ("C-c g" . magit-file-dispatch)
  :config
  (setq auth-sources '("~/.authinfo.gpg"))
  (defun k8x1d/magit-status-w-forge-upd ()
    (interactive)
    (magit-todos-mode)
    (magit-status)
    (forge-pull))
  )

;; Show todos of the project in magit buffer
(use-package magit-todos
  :after magit)

;; Interaction with github/gitlab
(use-package forge
  :after magit
  :config
  ;; evil-collection compat, see https://github.com/emacs-evil/evil-collection/issues/543
  (setq forge-add-default-sections nil)
  (setq forge-add-default-bindings nil)
  (setq auth-sources '("~/.authinfo.gpg"))
  )


(provide 'git-module)
