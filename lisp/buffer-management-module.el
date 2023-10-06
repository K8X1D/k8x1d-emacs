;;; package --- Summary

;;; Commentary:

;;; Code:

;; Buffer management
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  )

;; Icons support
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; Buffer grouping
(use-package ibuffer-project
  :config
  (add-hook
   'ibuffer-hook
   (lambda ()
     (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
     (unless (eq ibuffer-sorting-mode 'project-file-relative)
       (ibuffer-do-sort-by-project-file-relative)))))

(provide 'buffer-management-module)
;;; buffer-management-module.el ends here
