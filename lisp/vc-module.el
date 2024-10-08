
(use-package vc-hooks
  :ensure nil
  :init
  (setq vc-follow-symlinks t)
  )

(use-package files
  :ensure nil
  :init
  (setq view-read-only t)
  )

(use-package magit
  :general
  (k8x1d/leader-keys
    "g" '(:ignore t :which-key "Git")
    "gg" '(magit-status :which-key "Status")
    )
  :bind
  (([remap magit-jump-to-tracked] . tab-bar-switch-to-next-tab)
   ("C-c g g" . magit-status)))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package forge
  :bind
  ("C-c g c i" . forge-create-issue)
  ("C-c g l i" . forge-list-issues)
  (:map forge-issue-mode-map
	("g t" . tab-bar-switch-to-next-tab)
	)
  )

(provide 'vc-module)
