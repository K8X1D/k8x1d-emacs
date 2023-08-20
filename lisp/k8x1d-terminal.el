

;; Terminal
(use-package vterm
  :bind (:map minibuffer-local-map
	      ("C-q" . vterm-send-next-key))
  :config
  ;; Tramp support
  (setq vterm-tramp-shells '(("ssh" "/bin/bash")))
  (setq tramp-histfile-override nil)
  (setq vterm-max-scrollback 10000))

;; From https://github.com/suonlight/multi-vterm
(use-package multi-vterm
  :after project
  :general 
  (k8x1d/leader-keys
    "ot" '(multi-vterm-dedicated-toggle :which-key "Terminal")
   )
  (k8x1d/leader-keys
    "pt" '(multi-vterm-project :which-key "Terminal")
   )
  :config
  (add-hook 'vterm-mode-hook
	    (lambda ()
	      (setq-local evil-insert-state-cursor 'bar)
	      (evil-insert-state)))
  (define-key vterm-mode-map [return]                      #'vterm-send-return)
  (setq multi-vterm-dedicated-window-height 17)
  (setq vterm-keymap-exceptions nil)
  )

;; In test
(use-package eat
  :config
  (eat-eshell-mode)
  (setq eshell-visual-commands '()))


(provide 'k8x1d-terminal)
