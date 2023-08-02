

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
  :general 
  (k8x1d/leader-keys
   "p" '(:keymap project-prefix-map
		 :which-key "Project"))
  (k8x1d/leader-keys
    "po" '(:ignore t :which-key "Open")
    "poe" '(dired-sidebar-toggle-sidebar :which-key "Explorer")
   )
  )




(provide 'k8x1d-project)
