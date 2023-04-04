;; Syntax highlght
(use-package julia-mode
  :defer t)

;; REPL
(use-package julia-vterm
  :hook (julia-mode . julia-vterm-mode)
  :bind ("C-c i" . julia-vterm-send-include-buffer-file)
  :config
  (setq vterm-kill-buffer-on-exit nil))

;; LSP
(use-package eglot-jl
  :hook (julia-mode . eglot-ensure)
  :config
  (setq eglot-connect-timeout 60) ;; prevent eglot timeout
  (eglot-jl-init)
  )

(provide 'k8x1d-julia)
