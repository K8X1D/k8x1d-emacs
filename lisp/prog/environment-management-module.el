;; Support direnv (buffer-locally)
;; (use-package envrc
;;   :hook (after-init . envrc-global-mode))


;; Async evaluation, but global, in test...
(use-package direnv
 :config
 (direnv-mode))


(provide 'environment-management-module)
