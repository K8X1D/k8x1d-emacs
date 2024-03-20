







(use-package emacs
  :init
  (defun k8x1d/update ()
    (interactive)
    (async-shell-command "k8x1d-emacs -u"))
  :bind
  ("C-c s u" . k8x1d/update)
)

(provide 'k8x1d-emacs-management-module)
