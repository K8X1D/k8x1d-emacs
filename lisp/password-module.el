;; -*- lexical-binding: t; -*-

(use-package pass
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "op"  '(pass :which-key "Pass")
    )
  :bind
  ("C-c o p" . pass)
  )

(provide 'password-module)
