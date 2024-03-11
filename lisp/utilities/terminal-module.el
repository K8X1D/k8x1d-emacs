(use-package eat
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
  )

(provide 'terminal-module)
