;;; package --- Summary -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:


(defvar k8x1d-ssh-addresses
      '(("Mariadb"  . "kkaiser@206.12.89.239")
	("Serenity_kkaiser"  . "kkaiser@206.12.92.226")
	("Shelly"  . "k8x1d@67.68.116.59")
	("Serenity_ubuntu"  . "ubuntu@206.12.92.226")
	("Groudon" . "kkaiser@130.104.60.82")))


;; Tramp
(use-package tramp
  :config
  ;; Enable full-featured Dirvish over TRAMP on certain connections
  ;; https://www.gnu.org/software/tramp/#Improving-performance-of-asynchronous-remote-processes-1.
  (add-to-list 'tramp-connection-properties
	       (list
		(regexp-quote "/ssh:kkaiser@206.12.89.239:")
		"direct-async-process" t))
  (add-to-list 'tramp-connection-properties
	       (list
		(regexp-quote "/ssh:kkaiser@206.12.92.226:")
		"direct-async-process" t))
  (add-to-list 'tramp-connection-properties
	       (list
		(regexp-quote "/ssh:k8x1d@67.68.116.59:")
		"direct-async-process" t))
  (add-to-list 'tramp-connection-properties
	       (list
		(regexp-quote "/ssh:ubuntu@206.12.92.226:")
		"direct-async-process" t))
  (add-to-list 'tramp-connection-properties
	       (list
		(regexp-quote "/ssh:kkaiser@130.104.60.82:")
		"direct-async-process" t))
  ;; Tips to speed up connections
  (setq tramp-verbose 0)
  (setq tramp-chunksize 2000)
  (setq tramp-use-ssh-controlmaster-options nil))

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
