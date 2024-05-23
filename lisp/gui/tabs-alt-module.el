
(use-package tab-bar
  :hook (after-init . tab-bar-mode)
  :config
  (setq tab-bar-close-button-show t)
  (setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-select-tab-modifiers '(meta))
  )

;; (use-package tab-line
;;   :hook (after-init . global-tab-line-mode)
;;   :config
;;   (setq tab-line-new-button-show t)
;;   (setq tab-line-close-button-show t)
;;   (setq tab-line-switch-cycling t)
;;   :custom-face  (tab-line-tab-current ((t (:foreground ,(doom-color 'fg) :background ,(doom-color 'bg) :height 0.7))))
;; (tab-line-tab-inactive ((t (:foreground ,(doom-color 'fg-alt) :background ,(doom-color 'bg-alt) :height 0.7))))
;;   )



;; Keybindings
(use-package tab-bar
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "t" '(:keymap tab-prefix-map
		  :which-key "Tabs")
    )
  )



(provide 'tabs-alt-module)
