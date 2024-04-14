

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


;; Buffer navigation
(use-package imenu
  :config
  (setq org-imenu-depth 3)
  (setq imenu-auto-rescan t) 
  (setq imenu-max-items 50) 
  (setq use-package-enable-imenu-support t) 
  )

;; Buffer update
(use-package emacs
  :hook (after-init . global-auto-revert-mode)
  :config
  (setq auto-revert-remote-files t)
  (setq auto-revert-verbose nil)
  )

;; prevent minibuffer lock
(setq enable-recursive-minibuffers t)

;; General Keybindings
(use-package emacs
  :if k8x1d/use-general-keybindings
  :general
  ;; Buffers
  (k8x1d/leader-keys
   "b"  '(:ignore t :which-key "Buffers")
   "bn" '(next-buffer :which-key "Next")
   "bp"  '(previous-buffer :which-key "Previous")
   "bs"  '(consult-buffer :which-key "Search")
   "bk"  '(k8x1d/kill-buffer-and-window :which-key "Kill")
   "bi"  '(ibuffer :which-key "List")
   )
  )

(provide 'buffer-module)
