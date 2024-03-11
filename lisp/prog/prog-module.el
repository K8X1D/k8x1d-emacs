
 ;; Show line number for programming mode
(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :init
  (setq display-line-numbers 'relative)
  )


(provide 'prog-module)
