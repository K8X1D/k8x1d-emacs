(use-package emacs
  :init
  (defun k8x1d/update ()
    (interactive)
    (async-shell-command "k8x1d-emacs -u")
    (guix-emacs-autoload-packages)
    )
  (defun k8x1d/upgrade ()
    (interactive)
    (async-shell-command "k8x1d-emacs -U"))
  :bind
  (
   ;;("C-c s" ("System" . ignore))
   ("C-c s u" ("Update Emacs" . k8x1d/update))
   ("C-c s U" ("Upgrade Emacs" . k8x1d/upgrade)))
  )


;; Keybindings
(use-package emacs
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "s"  '(:ignore t :which-key "Emacs")
    "su" '(k8x1d/update :which-key "Update")
    "sU" '(k8x1d/upgrade :which-key "Upgrade")
    )
  )

(provide 'k8x1d-emacs-management-module)
