;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package dashboard
  :hook (after-init . (lambda () (dashboard-setup-startup-hook)))
  :config
  ;; Depedencies
  (require 'dashboard)
  (require 'nerd-icons)

  ;; Banner
  (setq dashboard-startup-banner (concat user-emacs-directory "/banners/k8x1d-avatar_dark.png"))
  (setq dashboard-banner-logo-title "Welcome to K8X1D Emacs Dashboard!")

  ;; Widget list
  (defun dashboard-insert-find-file (list-size)
    (dashboard-insert-heading "Find File"
			      nil
			      (nerd-icons-mdicon "nf-md-file_find"
						 :height 1.2
						 :v-adjust 0.0
						 :face 'dashboard-heading))
    (insert "    SPC f f"))
  (defun dashboard-insert-open-project (list-size)
    (dashboard-insert-heading "Open Project"
			      nil
			      (nerd-icons-mdicon "nf-md-folder_search"
						 :height 1.2
						 :v-adjust 0.0
						 :face 'dashboard-heading))
    (insert "    SPC p p"))
  (defun dashboard-insert-open-agenda (list-size)
    (dashboard-insert-heading "Open Agenda"
			      nil
			      (nerd-icons-mdicon "nf-md-calendar"
						 :height 1.2
						 :v-adjust 0.0
						 :face 'dashboard-heading))
    (insert "    SPC d e"))
  (defun dashboard-insert-open-video (list-size)
    (dashboard-insert-heading "Open video"
			      nil
			      (nerd-icons-mdicon "nf-md-video_box"
						 :height 1.2
						 :v-adjust 0.0
						 :face 'dashboard-heading))
    (insert "    SPC v v"))
  (defun dashboard-insert-open-music (list-size)
    (dashboard-insert-heading "Open Music List"
			      nil
			      (nerd-icons-mdicon "nf-md-music_box"
						 :height 1.2
						 :v-adjust 0.0
						 :face 'dashboard-heading))
    (insert "    SPC M l"))
  (add-to-list 'dashboard-item-generators  '(file . dashboard-insert-find-file))
  (add-to-list 'dashboard-item-generators  '(project . dashboard-insert-open-project))
  (add-to-list 'dashboard-item-generators  '(agenda . dashboard-insert-open-agenda))
  (add-to-list 'dashboard-item-generators  '(video . dashboard-insert-open-video))
  (add-to-list 'dashboard-item-generators  '(music . dashboard-insert-open-music))
  ;; (add-to-list 'dashboard-items '(custom) t)
  (setq dashboard-items '((file)
			  (project)
			  (agenda)
			  (video)
			  (music)))

  ;; UI
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-set-footer nil)
  (setq dashboard-center-content t)

  ;; Icons support
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
)
  

(use-package page-break-lines
  :hook
  (dashboard-mode . page-break-lines-mode))

(provide 'dashboard-module)
;;; dashboard-module-alt.el ends here
