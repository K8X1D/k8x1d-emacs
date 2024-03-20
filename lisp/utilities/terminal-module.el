(use-package eat
  :if (string= k8x1d/terminal "eat")
  :after evil-collection
  :init
  (defun eat-vertical ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 16)
    (eat))

  (defun eat-project-vertical ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 16)
    (eat-project))
  :bind
  (("C-c o t" . eat-vertical)
   (:map project-prefix-map
         ("t" . eat-project-vertical)))
  :hook ((eshell-load . eat-eshell-mode)
         (eshell-load . eat-eshell-visual-command-mode))
  :config
  ;; Evil compatibility
  (evil-collection-define-key 'normal 'eat-semi-char-mode-map "p" 'eat-yank)
  (define-key eat-semi-char-mode-map (kbd "<delete>")  #'eat-self-input)
  (add-to-list 'evil-insert-state-modes 'eat-mode)
  ;; Remote
  (add-to-list 'eat-tramp-shells '("ssh" . "/bin/bash"))
  )



;; High performance terminal
(use-package vterm
  :if (string= k8x1d/terminal "vterm")
  :config
  (setq vterm-max-scrollback 10000)
  ;; Remote
  (add-to-list 'vterm-tramp-shells '("ssh" "/usr/bin/bash"))
  )

;; Dedicated terminal
(use-package vterm-toggle
  :if (string= k8x1d/terminal "vterm")
  :bind (("C-c o t" . vterm-toggle-cd)))

;; Multiple terminals
(use-package multi-vterm
  :if (string= k8x1d/terminal "vterm")
  :bind (:map project-prefix-map
              ("t" . multi-vterm-project))
  :config
  (setq multi-vterm-dedicated-window-height-percent 30))







(provide 'terminal-module)
