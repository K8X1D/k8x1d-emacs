



;;;; Treesitter support
;;(use-package r-ts-mode
;;  :init
;;  ;; tmp
;;  (unless (package-installed-p 'r-ts-mode)
;;    (package-vc-install "https://github.com/sje30/r-ts-mode")
;;    )
;;  :mode "\\.R$")



(use-package ess
  :hook (ess-r-mode . eglot-ensure)
  )



(provide 'k8x1d-R)
