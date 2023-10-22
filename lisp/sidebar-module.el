;;; package --- Summary

;;; Commentary:

;;; Code:


(use-package dired-sidebar
  
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  ;; (defun sidebar-toggle ()
  ;; "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  ;; (interactive)
  ;; (dired-sidebar-toggle-sidebar)
  ;; (ibuffer-sidebar-toggle-sidebar))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  ;; (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; Don't work, refreshing buffer ends on nil
;; (use-package ibuffer-sidebar
;; :commands (ibuffer-sidebar-toggle-sidebar)
;; :config
;; (setq ibuffer-sidebar-use-custom-font t)
;; (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140)))

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
  
  :hook (treemacs-mode . (lambda () (require 'treemacs-nerd-icons)))
  :config
  (treemacs-load-theme "nerd-icons"))

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


;;
;; Minimap
;;
(use-package minimap
  
  :config
  (setq minimap-window-location 'right
        minimap-update-delay 0
        minimap-width-fraction 0.09
        minimap-minimum-width 15)
  )


(provide 'sidebar-module)
;;; sidebar-module.el ends here
