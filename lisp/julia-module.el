
;; Syntax highlight
  :ensure t
(use-package julia-ts-mode
  :mode "\\.jl$")

;; SLIME-like dev environment
(use-package julia-snail
  :after eat
  :hook
  (julia-ts-mode . julia-snail-mode)
  :custom 
  (julia-snail-terminal-type :eat)
  (julia-snail-extensions '(ob-julia))
  )

(provide 'julia-module)
