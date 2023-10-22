;;; package --- Summary

;;; Commentary:

;;; Code:

;; Interface with bluetooth
(use-package bluetooth
  
  :bind
  ("C-c o b" . bluetooth-list-devices)
  )

;; Interface with transimission
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

;; Interface with guix
(use-package guix
  
  :bind ("C-c o g" . guix)
  )

;; Process manager
(use-package proced
  :config
  (setq proced-auto-update-flag t)
  (setq proced-auto-update-interval 1))




;; Elogind interaction
(defvar loginctl-arg
  '(("Suspend"  . "suspend")
    ("Poweroff" . "poweroff")))

(defun k8x1d/select-loginctl-arg ()
  (alist-get
   (completing-read "Choose: " loginctl-arg)
   loginctl-arg nil nil 'equal))

(defun k8x1d/elogind (cmd)
  "Interact with elogind passing a CMD."
  (interactive (list (concat "loginctl" " " (k8x1d/select-loginctl-arg))))
  (shell-command cmd))


(provide 'system-module)
;;; system-module.el ends here
