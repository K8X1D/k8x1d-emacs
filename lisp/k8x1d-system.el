;; -*- lexical-binding: t; -*-


(use-package guix
  :hook (after-init . global-guix-prettify-mode)
  :general
  (k8x1d/leader-keys
    "o g" '(guix :which-key "Guix package manager")))


(provide 'k8x1d-system)



