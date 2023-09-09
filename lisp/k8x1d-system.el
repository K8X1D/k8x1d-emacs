;;; package --- Summary



;;; Commentary:

;;; Code:


(use-package guix
  :hook (after-init . global-guix-prettify-mode)
  :general
  (k8x1d/leader-keys
    "o g" '(guix :which-key "Guix package manager"))
  )

(use-package transmission
  :init
  (defun k8x1d/herd-transmission (command)
    "Interact with user service."
    (interactive "sCommand: ")
    (async-shell-command (concat "herd" " " command " " "transmission")))
  :general
  (k8x1d/leader-keys
    "oT" '(transmission :which-key "Transmission")
    "s" '(:ignore t :which-key "Guix System")
    "ss" '(:ignore t :which-key "Shepherd")
    "sss" '((async-shell-command "shepherd") :which-key "Start")
    "ssh" '(:ignore t :which-key "herd")
    "ssht" '(k8x1d/herd-transmission :which-key "Transmission"))
  )




(provide 'k8x1d-system)
;;; k8x1d-system.el ends here
