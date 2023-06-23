;; Treesitter support
(use-package julia-ts-mode
  :defer t
  :mode "\\.jl$")

;; REPL
(use-package julia-vterm
  :defer t
  :hook ((julia-mode . julia-vterm-mode)
	 (julia-ts-mode . julia-vterm-mode))
  :bind 
  (("C-c o r j" . julia-vterm-repl)
   :map julia-vterm-mode-map
   ("C-c i" . julia-vterm-send-include-buffer-file))
  :config
  (setq vterm-kill-buffer-on-exit nil))

;;;; LSP
;; FIXME: startup time of (eglot-jl-init) is too high
(use-package eglot-jl
  :defer t
  :init
  (setq eglot-connect-timeout 60) ;; prevent eglot timeout
  :hook ((julia-ts-mode . eglot-jl-init)
	 (julia-ts-mode . eglot-ensure))
  )



(provide 'k8x1d-julia)
