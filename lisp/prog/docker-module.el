
;; Support for Dockerfile syntax
;; (use-package dockerfile-mode) ;; treesitter support now native to emacs


;; Support for docker-compose syntax
(use-package docker-compose-mode)

;; Manage docker images
(use-package docker)


;; Checker support
(use-package flymake-hadolint
  :hook (dockerfile-mode  . flymake-hadolint-setup))



;; Tramp integration (inspiration: https://www.emacswiki.org/emacs/TrampAndDocker)
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


;; General Keybindings
(use-package docker 
  :if k8x1d/use-general-keybindings
  :general
  ;; Buffers
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "od" '(docker :which-key "Docker")
   "oD" '(docker-compose :which-key "Docker Compose")
   )
  )




(provide 'docker-module)
