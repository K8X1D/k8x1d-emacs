;;
;; file explorer
;;


;; File explorer
(use-package dired-sidebar
  :bind (("C-c o e" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  ;;(setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))



;;;; Show git info in Emacs Dired
;;(use-package dired-git-info
;;  :hook
;;  (dired-after-readin . dired-git-info-auto-enable)
;;  :config
;;  ;; Don't hide dired details when showing git status
;;  (setq dgi-auto-hide-details-p nil)
;;  )

;;




(provide 'k8x1d-file-explorer)
