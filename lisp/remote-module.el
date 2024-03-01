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
