;; Show keybindings 
(use-package which-key
  :hook (after-init . which-key-mode)
  :config 
  ;; (setq which-key-separator ": ")
  ;; From doom emacs
  (setq which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10)
  )

(provide 'keybindings-module)
