


;; Don't work...
(define-key lisp-mode-map (kbd "C-c <tab>") nil)
(global-set-key (kbd "C-c <tab>") nil)

(use-package lisp-mode
  :config
  ;; Clean binding
  ;;(define-key lisp-mode-map (kbd "C-c <tab>") nil)
  (require 'bind-key)
  (unbind-key "[TAB]" lisp-mode-map)
  (unbind-key "C-c TAB" lisp-mode-map)
  )

(use-package geiser-mode
  :config
  ;; Clean binding
  (require 'bind-key)
  (unbind-key "C-c TAB" geiser-mode-map))

(use-package geiser-guile)



(provide 'k8x1d-lisp)
