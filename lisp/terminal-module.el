;;; package --- Summary

;;; Commentary:

;;; Code:

;; Terminal
(use-package vterm)
(use-package multi-vterm
  :bind (("C-c o t" . multi-vterm-dedicated-toggle)
	 ("C-x p t" . multi-vterm-project))
  :config
  (setq multi-vterm-dedicated-window-height-percent 30))

(provide 'terminal-module)
;;; terminal-module.el ends here
