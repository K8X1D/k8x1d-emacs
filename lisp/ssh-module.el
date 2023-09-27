;;; package --- Summary

;;; Commentary:

;;; Code:

(setq k8x1d-ssh-addresses
      '(("Mariadb"  . "kkaiser@206.12.89.239")
	("Serenity_kkaiser"  . "kkaiser@206.12.92.226")
	("Shelly"  . "k8x1d@67.68.116.59")
	("Serenity_ubuntu"  . "ubuntu@206.12.92.226")
	("Groudon" . "kkaiser@130.104.60.82")))

(defun k8x1d/select-ssh-address ()
  (alist-get
   (completing-read "Choose: " k8x1d-ssh-addresses)
   k8x1d-ssh-addresses nil nil 'equal))

(defun k8x1d/dired-ssh (vm)
  (interactive (list (concat "/ssh:" (k8x1d/select-ssh-address) ":")))
  (find-file vm)
  )

;; Sometimes, cannot insert back in evil mode. Test alternative
(defun k8x1d/vterm-ssh (vm)
  (interactive (list (concat "ssh" " " (k8x1d/select-ssh-address))))
  (multi-vterm)
  (vterm-send-string vm)
  (vterm-send-return)
  )

;; ;; Do not solve the problem, but is slower...
;; (defun k8x1d/vterm-ssh (vm)
;;   (interactive (list (concat "/ssh:" (k8x1d/select-ssh-address) ":")))
;;   (find-file vm)
;;   (multi-vterm)
;;   )


(use-package tramp
  :config
  (setq org-display-remote-inline-images 'cache))


(provide 'ssh-module)
;;; ssh-module.el ends here
