;;
;; file explorer
;;


(use-package dired-sidebar
  :bind
  ("C-c o p" . dired-sidebar-toggle-sidebar)
  )

;; Show git info in Emacs Dired
(use-package dired-git-info
  :hook
  (dired-after-readin . dired-git-info-auto-enable)
  :config
  ;; Don't hide dired details when showing git status
  (setq dgi-auto-hide-details-p nil)
  )

;; add icon to dired
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; Add icons to ibuffer
(use-package all-the-icons-ibuffer
  :hook
  (ibuffer-mode . all-the-icons-ibuffer-mode))
;;
;;
;;;; Group buffers by project in ibuffer
;;(use-package ibuffer-project
;;  :hook
;;  (ibuffer . (lambda ()
;;	       (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
;;	       (unless (eq ibuffer-sorting-mode 'project-file-relative)
;;		 (ibuffer-do-sort-by-project-file-relative)))))
;;
;;
;;




(provide 'file-explorer-module)
