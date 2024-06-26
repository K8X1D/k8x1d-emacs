;; Tramp
(use-package tramp
  :config
  (setq org-display-remote-inline-images 'cache)
  ;; Worl around for https://issues.guix.gnu.org/55443
  (connection-local-set-profile-variables
   'guix-system
   '((tramp-remote-path . (tramp-own-remote-path))))

  (connection-local-set-profiles
   `(:application tramp :protocol "sudo" :machine ,(system-name))
   'guix-system)

  ;; Tips to speed up connections
  (setq tramp-verbose 0)
  (setq tramp-chunksize 2000)
  (setq tramp-use-ssh-controlmaster-options nil)
  ;; allow .dir-locals
  (setq enable-remote-dir-locals t)
  )

;; Predefined connections
(use-package tramp
  :init
  (defvar k8x1d-ssh-addresses
    '(("Mariadb"  . "kkaiser@206.12.89.239")
      ("Serenity_kkaiser"  . "kkaiser@206.12.92.226")
      ("Shelly"  . "k8x1d@67.68.116.59")
      ("Serenity_ubuntu"  . "ubuntu@206.12.92.226")
      ("Mariadb-Hive-1" . "kkaiser@198.168.185.123")
      ("Mariadb-Hive-2" . "kkaiser@198.168.186.137")
      ("Mariadb-Hive-3" . "kkaiser@198.168.187.221")
      ("Debian-WM" . "test@127.0.0.1")
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
  (defun k8x1d/eat-ssh (vm)
    (interactive (list (concat "ssh" " " (k8x1d/select-ssh-address))))
    (eat vm)
    )

  (defun k8x1d/vterm-ssh ()
    (interactive)
    (let* ((ssh-address (k8x1d/select-ssh-address))
	   (port (completing-read "Port: " nil nil nil "22")))
      (multi-vterm)
      (vterm-send-string (concat "ssh" " " ssh-address " -p " port))
      (vterm-send-return)
      ))
  :config
  ;; Remote variable
  ;; For eat, following https://codeberg.org/akib/emacs-eat/issues/144
  (setq tramp-terminal-type "xterm-256color")
  (add-to-list 'tramp-remote-process-environment '"TERMINFO=")
  (add-to-list 'tramp-remote-process-environment '"xterm-256color")
 )


(provide 'remote-module)
