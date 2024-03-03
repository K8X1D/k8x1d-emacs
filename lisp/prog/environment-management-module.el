;; Support direnv (buffer-locally)
(use-package envrc
  :hook (after-init . envrc-global-mode))

(provide 'environment-management-module)
