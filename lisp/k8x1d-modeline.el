(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  ;; Add wanted information
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-minor-modes t) ;; for minions
  ;; Clean-up modeline
  (setq doom-modeline-buffer-state-icon nil)
  (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
  (setq doom-modeline-buffer-encoding nil)
  )

(use-package minions-mode
  :hook (doom-modeline-mode . minions-mode))

(provide 'k8x1d-modeline)
