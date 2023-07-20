;; Lsp
(use-package eglot
  :defer t
  :init
  (setq eglot-connect-timeout 60) ;; prevent eglot timeout
  )

;; Diagnostics
(use-package flymake
  :defer t
  :general
  (k8x1d/leader-keys
    "d" '(:ignore t :which-key "Diagnostic")
    "db" '(flymake-show-buffer-diagnostics :which-key "List")
    "dn" '(flymake-goto-next-error :which-key "Next")
    "dp" '(flymake-goto-prev-error :which-key "Previous")
    "ds" '(consult-flymake :which-key "Search")
    )
  )


(provide 'k8x1d-lsp)
