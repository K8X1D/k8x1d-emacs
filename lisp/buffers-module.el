;; -*- lexical-binding: t; -*-

;; Keybindings
(use-package window
  :ensure nil
  :general
  (k8x1d/leader-keys
    "b" '(:ignore t :which-key "Buffers")
    "bn" '(next-buffer :which-key "Next")
    "bp" '(previous-buffer :which-key "Previous")
    "bb" '(ibuffer :which-key "Manager")
    "bk" '(kill-buffer :which-key "Kill")
    "bs" '(switch-to-buffer :which-key "Switch")
    )
  )

;; Buffer managements
(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer)
  :hook
  (ibuffer-mode . ibuffer-auto-mode)
  )
;; see https://cestlaz.github.io/posts/using-emacs-34-ibuffer-emmet/


;; Buffer grouping
(use-package ibuffer-project
  :hook
  (ibuffer . (lambda ()
	       (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
	       (unless (eq ibuffer-sorting-mode 'project-file-relative)
		 (ibuffer-do-sort-by-project-file-relative))))
  :config
  (setq ibuffer-project-use-cache t)
  )

;; Keep buffers updated with corresponding files
(use-package autorevert
  :diminish
  :hook
  (after-init . global-auto-revert-mode)
  :config
  (setq auto-revert-use-notify nil)
  (setq auto-revert-remote-files t)
  (setq auto-revert-verbose nil)
  (setq global-auto-revert-non-file-buffers t) ;; Revert other buffers (e.g, Dired)
  )


(provide 'buffers-module)
