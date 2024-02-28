
 ;; Show line number for programming mode
(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers 'relative)
  )


(provide 'prog-module)
