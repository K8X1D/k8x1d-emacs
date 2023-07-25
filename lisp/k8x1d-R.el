



;;;; Treesitter support
;;(use-package r-ts-mode
;;  :init
;;  ;; tmp
;;  (unless (package-installed-p 'r-ts-mode)
;;    (package-vc-install "https://github.com/sje30/r-ts-mode")
;;    )
;;  :mode "\\.R$")



(use-package ess
  ;;:hook (ess-r-mode . eglot-ensure)
  )

;; TODO: update package
;; TODO: rewrite package for auto-update
;; TODO: move package to project on gitlab
(use-package R-vterm
  :defer t
  ;;:straight (:type git :host gitlab :repo "K8X1D/r-vterm") ;; integrated trought guix
  :hook (ess-r-mode . R-vterm-mode)
  :general
  (k8x1d/leader-keys
    "orr" '(R-vterm-repl :which-key "R")
    )
  :bind 
  (("C-c o r r" . R-vterm-repl)
   :map R-vterm-mode-map
   ("C-c i" . R-vterm-send-include-buffer-file))
  :config
  (setq vterm-kill-buffer-on-exit nil)
  ;; Use radian instead of R
  (setq R-vterm-repl-program "radian")
  (require 'bind-key)
  (unbind-key "C-c TAB" R-vterm-mode-map)
  )

(provide 'k8x1d-R)
