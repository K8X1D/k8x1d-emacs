(use-package tab-bar
  :hook (after-init . tab-bar-mode)
  :config
  (setq tab-bar-show 'never)
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-auto-width-max '(100 10))
  (setq tab-bar-new-tab-to 'leftmost)
  (setq tab-bar-select-modifier '(meta))
  )


(provide 'workspaces-module)
