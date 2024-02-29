;; Syntax highlight
(use-package julia-ts-mode
  :mode "\\.jl$")

;; SLIME-like dev environment
(use-package julia-snail
  :hook
  (julia-ts-mode . julia-snail-mode)
  :custom 
  (julia-snail-terminal-type :eat)
  (julia-snail-extensions '(ob-julia))
  )

;; LSP
(use-package eglot-jl
  :init (setq eglot-connect-timeout 180) ;; prevent eglot timeout
  :hook ((julia-ts-mode . eglot-jl-init)
         (julia-ts-mode . eglot-ensure))
  )

;; Documentation
(use-package eldoc
  :hook (julia-ts-mode . eldoc-mode))

(provide 'julia-module)
