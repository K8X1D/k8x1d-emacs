;; -*- lexical-binding: t; -*-

(use-package guix
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "og"  '(guix :which-key "Guix")
    )
  )



(provide 'guix-module)
