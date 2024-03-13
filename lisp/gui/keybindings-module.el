;; Show keybindings 
(use-package which-key
  :hook (after-init . which-key-mode)
  :config 
  (setq which-key-separator ": ")
  (setq which-key-min-display-lines 20)
  )


(provide 'keybindings-module)
