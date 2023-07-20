


(use-package lisp-mode
  :defer t
  :config
  ;; Clean binding
  ;;(define-key lisp-mode-map (kbd "C-c <tab>") nil)
  (require 'bind-key)
  (unbind-key "[TAB]" lisp-mode-map)
  (unbind-key "C-c TAB" lisp-mode-map)
  )

(use-package geiser-mode
  :defer t
  :general
  (k8x1d/local-leader-keys
    :keymaps 'geiser-mode-map
    "'" '(run-geiser :which-key "Open REPL")
    "r" '(geiser-eval-region :which-key "Send region")
    )
  :config
  ;; Clean binding
  (require 'bind-key)
  (unbind-key "C-c TAB" geiser-mode-map))

(use-package geiser-guile
  :defer t)



(provide 'k8x1d-lisp)
