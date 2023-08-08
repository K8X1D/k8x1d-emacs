;; TODO revise names

(setq k8x1d-ssh-addresses
      '(("Mariadb"  . "/ssh:kkaiser@206.12.89.239:")
	("Serenity"  . "/ssh:kkaiser@206.12.92.226:")))

(defun k8x1d/select-ssh-address ()
  (list
  (alist-get
   (completing-read "Choose: " k8x1d-ssh-addresses)
   vms-adresses nil nil 'equal)))

(defun k8x1d/dired-ssh (vm)
  (interactive (k8x1d/select-ssh-address))
  (find-file vm)
  )

(defun k8x1d/vterm-ssh (vm)
  (interactive (k8x1d/select-ssh-address))
  (find-file vm)
  (multi-vterm)
  )

(provide 'k8x1d-ssh)
