(use-package proced 
  :bind
  ("C-c s p" . proced)
  :config
  (setq proced-enable-color-flag t))

(use-package proced-narrow
  :after proced
  :bind (:map proced-mode-map
              ("/" . proced-narrow)))

(provide 'process-management-module)
