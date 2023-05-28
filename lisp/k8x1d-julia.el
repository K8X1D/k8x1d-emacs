;; Syntax highlght
;;(use-package julia-mode
;;  :defer t)

;; Treesitter support
(use-package julia-ts-mode
  :ensure t
  :straight t
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
(use-package eglot-jl
  :straight t
  :init
  (eglot-jl-init)
  :hook ((julia-mode . eglot-ensure)
	 (julia-ts-mode . eglot-ensure))
  :config
  (setq eglot-connect-timeout 60) ;; prevent eglot timeout
  )



(provide 'k8x1d-julia)
