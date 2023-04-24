

;;
;; Project management
;;
(setq multi-vterm-dedicated-window-height 18)
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))

;;(add-hook 'dired-sidebar-mode #'dired-git-info-mode)



;;(global-set-key (kbd "C-x p o t") 'multi-vterm-project)
;;(global-set-key (kbd "C-x p o e") 'dired-sidebar-toggle-sidebar)
;;(global-set-key (kbd "C-x p o e") 'sidebar-toggle) ;; bug with ibuffer-sidebar upd

;;(defun sidebar-toggle ()
;;  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
;;  (interactive)
;;  (dired-sidebar-toggle-sidebar)
;;  (ibuffer-sidebar-toggle-sidebar))


;; Terminal
(use-package vterm
  :hook
  (vterm-mode . visual-line-mode))

(use-package multi-vterm
  :bind
  ("C-c o t" . multi-vterm-dedicated-toggle)
  :config
  (setq multi-vterm-dedicated-window-height 18))

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



;; Project
(use-package project
  :bind
  (("C-x p o t" . multi-vterm-project)
   ("C-x p o e" . dired-sidebar-toggle-sidebar))
  )




(provide 'k8x1d-project)
