(use-package emacs
  :init
  (defun k8x1d/update ()
    (interactive)
    (async-shell-command "k8x1d-emacs -u"))
  (defun k8x1d/upgrade ()
    (interactive)
    (async-shell-command "k8x1d-emacs -U"))
  :bind
  (
   ;;("C-c s" ("System" . ignore))
   ("C-c s u" ("Update Emacs" . k8x1d/update))
   ("C-c s U" ("Upgrade Emacs" . k8x1d/upgrade)))
  )

(provide 'k8x1d-emacs-management-module)
