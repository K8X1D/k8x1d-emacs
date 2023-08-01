

;;(use-package julia-mode
;;  :defer t)

 ;; Treesitter support
 ;; (use-package julia-ts-mode
 ;;   :defer t
 ;;   :mode "\\.jl$")


;; REPL
(use-package julia-vterm
  :defer t
  :init
  (defun k8x1d/open-julia-repl-at-bottom ()
     (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (julia-vterm-repl)
    (evil-insert-state)
    )
  :general
  (k8x1d/leader-keys
    "orj" '(julia-vterm-repl :which-key "Julia")
    )
  (k8x1d/local-leader-keys
    :keymaps 'julia-ts-mode-map
    ;;"'" '(julia-vterm-switch-to-repl-buffer :which-key "Open REPL")
    "'" '(k8x1d/open-julia-repl-at-bottom :which-key "Open REPL")
    "l" '(julia-vterm-send-region-or-current-line :which-key "Send line")
    "b" '(julia-vterm-send-buffer :which-key "Send buffer")
    "f" '(julia-vterm-send-include-buffer-file :which-key "Send file")
    "r" '(julia-vterm-send-region-or-current-line :which-key "Send region")
    )
  :hook ((julia-mode . julia-vterm-mode)
	 (julia-ts-mode . julia-vterm-mode))
  :config
  (setq vterm-kill-buffer-on-exit nil))

;;;; LSP
;; FIXME: startup time of (eglot-jl-init) is too high
;; TODO: compare manual setup via eglot
;;(use-package eglot-jl
;;  :defer t
;;  :hook ((julia-ts-mode . eglot-jl-init)
;;	 (julia-ts-mode . eglot-ensure))
;;  )



(provide 'k8x1d-julia)
