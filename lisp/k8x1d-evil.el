;; Baseline evil support
(use-package evil
  :general
  (k8x1d/leader-keys
    "w" '(:ignore t :which-key "Window")
    "wc" '(evil-window-delete :which-key "Delete")
    "ws" '(evil-window-split :which-key "Split")
    "wv" '(evil-window-vsplit :which-key "Vsplit")
    "wh" '(evil-window-left :which-key "Left")
    "wj" '(evil-window-down :which-key "Down")
    "wk" '(evil-window-up :which-key "Up")
    "wl" '(evil-window-right :which-key "Right")
    "wH" '(evil-window-move-far-left :which-key "Move Left")
    "wJ" '(evil-window-move-very-bottom :which-key "Move Down")
    "wK" '(evil-window-move-very-top :which-key "Move Up")
    "wL" '(evil-window-move-far-right :which-key "Move Right")
    )
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-fu)
  :hook (after-init . evil-mode)
  :config
  (setq evil-normal-state-tag "NORMAL")
  (setq evil-insert-state-tag "INSERT")
  (setq evil-visual-state-tag "VISUAL")
  (setq evil-emacs-state-tag "EMACS")
  (setq evil-echo-state nil))

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
