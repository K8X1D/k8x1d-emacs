

;;
;; Project management
;;
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))
;; Project
(use-package project
  :defer t
  :general 
  (k8x1d/leader-keys
   "p"  '(:ignore t :which-key "Projects")
   "pp" '(project-switch-project :which-key "Switch")
   "pc" '(project-compile :which-key "Compile")
   "pe" '(dired-sidebar-toggle-sidebar :which-key "Explorer")
   "pf" '(project-find-file :which-key "Find file")
   "pd" '(project-find-dir :which-key "Find dir")
   "pr" '(project-find-regexp :which-key "Find regexp")
   )
  :bind
  (("C-x p o t" . multi-vterm-project)
   ("C-x p o e" . dired-sidebar-toggle-sidebar))
  )




(provide 'k8x1d-project)
