;; Native lsp support
(use-package eglot
  :bind
  (("C-c L a" . eglot-code-actions)
   ("C-c L c" . eglot-show-workspace-configuration)
   ("C-c L f" . eglot-format)
   ("C-c L F" . eglot-format-buffer)
   ("C-c L d" . eglot-shutdown)
   ("C-c L D" . eglot-shutdown-all))
  :config
  (setq mode-line-misc-info (delete '(eglot--managed-mode (" [" eglot--mode-line-format "] ")) mode-line-misc-info)) ;; Clean modeline info
  )



(provide 'lsp-module)
