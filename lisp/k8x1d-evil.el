;; Baseline evil support
(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-fu)
  :config

  (setq evil-normal-state-tag "NORMAL")
  (setq evil-insert-state-tag "INSERT")
  (setq evil-visual-state-tag "VISUAL")
  (setq evil-emacs-state-tag "EMACS")

  (setq evil-echo-state nil)
  (evil-mode 1))

;; Extend evil support
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Redo system
(use-package undo-fu
  :after evil)

;; Org interaction
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
  (evil-org-agenda-set-keys))


(provide 'k8x1d-evil)
