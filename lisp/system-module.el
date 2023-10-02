;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package bluetooth
  :bind
    ("C-c o b" . bluetooth-list-devices)
    )

(use-package transmission
  ;; :init
  ;; (defun k8x1d/herd-transmission (command)
    ;; "Interact with user service."
    ;; (interactive "sCommand: ")
    ;; (async-shell-command (concat "herd" " " command " " "transmission")))
  :bind
  ("C-c o T" . transmission)
  :config
(setq transmission-refresh-modes '(transmission-mode transmission-files-mode transmission-info-mode transmission-peers-mode))
  )


(use-package guix
  :bind ("C-c o g" . guix)
)

(provide 'system-module)
;;; system-module.el ends here
