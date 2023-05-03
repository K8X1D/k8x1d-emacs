;; Syntax highlght
(use-package julia-mode
  :defer t)

;; REPL
(use-package julia-vterm
  :defer t
  :hook (julia-mode . julia-vterm-mode)
  :bind 
  (("C-c o r j" . julia-vterm-repl)
   :map julia-vterm-mode-map
   ("C-c i" . julia-vterm-send-include-buffer-file))
  :config
  (setq vterm-kill-buffer-on-exit nil))

;; LSP
(use-package eglot-jl
  :after julia-mode
  :straight t
  :ensure t
  :hook ((julia-mode . eglot-ensure)
	 (julia-ts-mode . eglot-ensure))
  :init
  (setq eglot-connect-timeout 60) ;; prevent eglot timeout
  (eglot-jl-init)
  )
;;
;;;; Treesitter support
;;(use-package julia-ts-mode
;;  :straight t
;;  :ensure t
;; ;; ;; tmp
;; ;; (unless (package-installed-p 'julia-ts-mode)
;; ;;   (package-vc-install "https://github.com/ronisbr/julia-ts-mode")
;; ;;   )
;;  :mode "\\.jl$")





(provide 'k8x1d-julia)
