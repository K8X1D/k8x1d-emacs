;; General
(use-package org
  :bind ("C-c l" . org-store-link)
  :config
  (setq org-enforce-todo-dependencies t)
  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCL(c)")))
)

(use-package org
  :config
  (setq org-clock-sound  (concat user-emacs-directory "clock_sound.wav"))
  )

;; Keybindings
(use-package org
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "t"  '(org-todo :which-key "Todo")
    )
  )


(provide 'org-management-module)
