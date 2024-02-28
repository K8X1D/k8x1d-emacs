

;; Better buffer management
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :hook (ibuffer-mode . ibuffer-auto-mode)
  )

;; Group buffer per project
(use-package ibuffer-project
  :hook (ibuffer .  (lambda ()
		      (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
		      (unless (eq ibuffer-sorting-mode 'project-file-relative)
			(ibuffer-do-sort-by-project-file-relative))))
  )


(provide 'buffer-module)
