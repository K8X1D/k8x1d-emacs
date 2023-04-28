






;; Better buffer manager
(use-package emacs
  :bind
  ("C-x C-b" . ibuffer))


;; Add icons to ibuffer
(use-package all-the-icons-ibuffer
  :hook
  (ibuffer-mode . all-the-icons-ibuffer-mode))



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




(provide 'k8x1d-buffers)
