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
  :config
  ;; Remote variable
  ;; For eat, following https://codeberg.org/akib/emacs-eat/issues/144
  (setq tramp-terminal-type "xterm-256color")
  (add-to-list 'tramp-remote-process-environment '"TERMINFO=")
  (add-to-list 'tramp-remote-process-environment '"xterm-256color")
 )

;; Docker interaction (inspiration: https://www.emacswiki.org/emacs/TrampAndDocker)
(use-package tramp
  :config
  ;; Open files in Docker containers like so: /docker:drunk_bardeen:/etc/passwd
  (push
   (cons
    "docker"
    '((tramp-login-program "docker")
      (tramp-login-args (("exec" "-it") ("%h") ("/bin/bash")))
      (tramp-remote-shell "/bin/sh")
      (tramp-remote-shell-args ("-i") ("-c"))))
   tramp-methods)

  (defadvice tramp-completion-handle-file-name-all-completions
      (around dotemacs-completion-docker activate)
    "(tramp-completion-handle-file-name-all-completions \"\" \"/docker:\" returns
        a list of active Docker container names, followed by colons."
    (if (equal (ad-get-arg 1) "/docker:")
        (let* ((dockernames-raw (shell-command-to-string "docker ps | awk '$NF != \"NAMES\" { print $NF \":\" }'"))
               (dockernames (cl-remove-if-not
                             #'(lambda (dockerline) (string-match ":$" dockerline))
                             (split-string dockernames-raw "\n"))))
          (setq ad-return-value dockernames))
      ad-do-it))
  )

(provide 'remote-module)
