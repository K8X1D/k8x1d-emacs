;;; package --- Summary

;;; Commentary:

;;; Code:

;; High performance terminal
(use-package vterm
  :config
  (setq vterm-max-scrollback 10000)
  )

;; Dedicated terminal
(use-package vterm-toggle
  :bind (("C-c o t" . vterm-toggle-cd)))

;; Multiple terminals
(use-package multi-vterm
  :bind (("C-x p t" . multi-vterm-project))
  :config
  (setq multi-vterm-dedicated-window-height-percent 30))

;; High performance eshell
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
  :hook ((eshell-load . eat-eshell-mode)
	 (eshell-load . eat-eshell-visual-command-mode))
  :bind (("C-c o e" . eat))
  :config
  ;; Evil compatibility
  (evil-collection-define-key 'normal 'eat-semi-char-mode-map "p" 'eat-yank)
  (evil-collection-define-key 'normal 'eat-semi-char-mode-map "p" 'eat-yank)
  )


(provide 'terminal-module)
;;; terminal-module.el ends here
