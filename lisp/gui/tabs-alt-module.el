
(use-package tab-bar
  :hook (after-init . tab-bar-mode)
  :config
  (setq tab-bar-close-button-show t)
  (setq tab-bar-show 1)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-select-tab-modifiers '(meta))
  )

(use-package tab-line
  :hook (after-init . global-tab-line-mode)
  :config
  (setq tab-line-new-button-show t)
  (setq tab-line-close-button-show t)
  (setq tab-line-switch-cycling t)
  :custom-face  (tab-line-tab-current ((t (:foreground ,(doom-color 'fg) :background ,(doom-color 'bg) :height 0.7))))
(tab-line-tab-inactive ((t (:foreground ,(doom-color 'fg-alt) :background ,(doom-color 'bg-alt) :height 0.7))))
  )

(provide 'tabs-alt-module)
