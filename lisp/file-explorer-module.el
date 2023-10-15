;;; package --- Summary

;;; Commentary:

;;; Code:

;; File-explorer
(use-package dired
  :ensure nil
  :config
  (setq dired-auto-revert-buffer t)
  )

;; Icons support
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))



(provide 'file-explorer-module)
;;; file-explorer-module.el ends here
