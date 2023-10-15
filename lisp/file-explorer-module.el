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


(use-package treemacs
  :config
  ;; (treemacs-follow-mode t)
  ;; (treemacs-git-mode 'deferred)
  (treemacs-project-follow-mode 1))

;; Project.el support
;; (use-package project-treemacs
;;   :after treemacs
;;   :config
;;   (project-treemacs-mode))

;; Evil support
(use-package treemacs-evil
  :after (treemacs evil))

;; Magit support
(use-package treemacs-magit
  :after (treemacs magit))

;; Icons support
(use-package treemacs-nerd-icons
  :config
  (treemacs-load-theme "nerd-icons"))(use-package treemacs-tab-bar)

;; Tab-bar support
(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :config (treemacs-set-scope-type 'Tabs))

;; LSP-mode support
(use-package lsp-treemacs
  :if (equal lsp-framework "lsp-mode")
  :after treemacs
  :config
  (lsp-treemacs-sync-mode))



(provide 'file-explorer-module)
;;; file-explorer-module.el ends here
