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

;; Which-Key popup in posframe
(use-package whick-key-posframe
  :if k8x1d/posframe-support
  :hook (which-key-mode . which-key-posframe-mode)
  :config
  (setq which-key-posframe-poshandler 'posframe-poshandler-frame-center)
  (setq which-key-posframe-parameters
	'((left-fringe . 10)
	  (right-fringe . 10)
	  (alpha-background . 100) ;; no transparency
	  ))
  )
fringe-indicator-alist

(provide 'keybindings-module)
