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
  :hook ((eshell-load . eat-eshell-mode)
	 (eshell-load . eat-eshell-visual-command-mode))
  :bind ("C-c o e" . eat)
  )

(provide 'terminal-module)
;;; terminal-module.el ends here
