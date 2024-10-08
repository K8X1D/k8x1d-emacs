;; -*- lexical-binding: t; -*-

(use-package project
  :general
  (k8x1d/leader-keys
    "p" '(:keymap project-prefix-map
		  :which-key "Project")
   )
  )

(provide 'projects-module)
