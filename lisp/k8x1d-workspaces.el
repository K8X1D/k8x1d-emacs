(use-package tabspaces
  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup. 
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  ;; sessions
  ;;(tabspaces-session t)
  ;;(tabspaces-session-auto-restore t))
  ;;:config
  ;;(setq tabspaces-keymap-prefix "SPC TAB")
  )

(provide 'k8x1d-workspaces)
