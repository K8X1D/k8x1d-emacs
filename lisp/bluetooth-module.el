;; -*- lexical-binding: t -*-

(use-package bluetooth
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "oB"  '(bluetooth-list-devices :which-key "Bluetooth")
    )
  :bind
  ("C-c o B" . bluetooth-list-devices)
  )

(provide 'bluetooth-module)
