
(use-package bluetooth
  :bind ("C-c o b" . bluetooth-list-devices))


;; Keybindings
(use-package bluetooth 
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "ob" '(bluetooth-list-devices :which-key "Bluetooth"))
  )



(provide 'bluetooth-module)
