;; -*- lexical-binding: t -*-

(use-package proced
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "oP"  '(proced :which-key "Process manager")
    )
  :bind
  ("C-c o P" . proced)
  :config
  (setq proced-auto-update-interval 1)
  (setq proced-auto-update-flag t)
  (setq proced-enable-color-flag t)
  )

(use-package proced-narrow
  :after proced
  :bind (:map proced-mode-map
              ("/" . proced-narrow)))

(provide 'process-manager-module)
