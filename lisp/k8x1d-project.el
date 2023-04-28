

;;
;; Project management
;;
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


;; Project
(use-package project
  :bind
  (("C-x p o t" . multi-vterm-project)
   ("C-x p o e" . dired-sidebar-toggle-sidebar))
  )




(provide 'k8x1d-project)
