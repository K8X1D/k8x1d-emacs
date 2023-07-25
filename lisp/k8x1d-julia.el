

;;(use-package julia-mode
;;  :defer t)

 ;; Treesitter support
 ;; FIXME: no syntax highlighting... test other version of package
 (use-package julia-ts-mode
   :defer t
   :mode "\\.jl$")


;; REPL
(use-package julia-vterm
  :defer t
  :general
  (k8x1d/local-leader-keys
    :keymaps 'julia-ts-mode-map
    "'" '(julia-vterm-switch-to-repl-buffer :which-key "Open REPL")
    "l" '(julia-vterm-send-region-or-current-line :which-key "Send line")
    "b" '(julia-vterm-send-buffer :which-key "Send buffer")
    "f" '(julia-vterm-send-include-buffer-file :which-key "Send file")
    "r" '(julia-vterm-send-region-or-current-line :which-key "Send region")
    )
  :hook ((julia-mode . julia-vterm-mode)
	 (julia-ts-mode . julia-vterm-mode))
  :bind 
  (("C-c o r j" . julia-vterm-repl)
   :map julia-vterm-mode-map
   ("C-c i" . julia-vterm-send-include-buffer-file))
  :config
  (setq vterm-kill-buffer-on-exit nil))

;;;;;; LSP
;;;; FIXME: startup time of (eglot-jl-init) is too high
;;(use-package eglot-jl
;;  :defer t
;;  :hook ((julia-ts-mode . eglot-jl-init)
;;	 (julia-ts-mode . eglot-ensure))
;;  )



(provide 'k8x1d-julia)
