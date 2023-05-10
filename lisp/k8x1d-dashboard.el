(use-package dashboard
  :bind
  ("C-c d" .'dashboard-refresh-buffer)
  :config
  ;; Faces
  (custom-set-faces
   `(dashboard-items-face ((t (:inherit widget-button :height 0.85))))
   `(dashboard-heading ((t (:inherit font-lock-keyword-face :height 0.9))))
   )
  ;;(setq dashboard-startup-banner (concat user-emacs-directory "/banners/banner.txt"))
  ;;(setq dashboard-startup-banner 'logo) 
  (setq dashboard-startup-banner "~/Pictures/Personnel/k8x1d-avatar/k8x1d-avatar_200x200.png") 
  (setq dashboard-banner-logo-title "Welcome to K8X1d Emacs Dashboard!")
  (setq dashboard-match-agenda-entry "-main-mont-bud")
  (setq dashboard-page-separator "\n\f\n")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;;(setq dashboard-set-navigator t)
  (setq dashboard-projects-backend 'project-el)
  ;;(setq dashboard-items '((recents  . 4)
  ;;			  (bookmarks . 4)
  ;;			  (projects . 4)
  ;;			  (agenda . 4)))
  (setq dashboard-items '((bookmarks . 5)
			  (projects . 5)
			  (agenda . 5)))
  (setq dashboard-week-agenda t)
  (setq dashboard-agenda-sort-strategy '(time-up))
  (setq dashboard-center-content t)

  (setq dashboard-footer-messages '("The one true editor, Emacs!" "Who the hell uses VIM anyway? Go Evil!" "Free as free speech, free as free Beer" "Happy coding!" "Vi Vi Vi, the editor of the beast" "Welcome to the church of Emacs" "While any text editor can save your files, only Emacs can save your soul" "1937: Publication of Dobzhansky's 'Genetics and the Origin of Species, primer of Modern Synthesis"))
  (dashboard-setup-startup-hook))

(use-package page-break-lines
  :hook
  (after-init . global-page-break-lines-mode))

(provide 'k8x1d-dashboard)
