;; Syntax highlight
(use-package julia-ts-mode
  :ensure t
  :mode "\\.jl$")

;; SLIME-like dev environment
(use-package julia-snail
  :ensure t
  :bind
  (:map julia-snail-mode-map
	("C-c C-," . julia-snail)
	("C-c C-l" . julia-snail-send-line)
	("C-c C-r" . julia-snail-send-region)
	("C-c C-b" . julia-snail-send-buffer-file)
	)
  :hook
  (julia-ts-mode . julia-snail-mode)
  :custom 
  (julia-snail-terminal-type :eat)
  (julia-snail-extensions '(ob-julia))

  :config
  (customize-set-variable 'split-height-threshold 15)
  (add-to-list 'display-buffer-alist
	       '("\\*julia" (display-buffer-reuse-window display-buffer-same-window)))
  (setq julia-snail-repl-display-eval-results t) ;; print the result in REPL
  (setq julia-snail-popup-display-eval-results t) ;; only show result in REPL
  ;; Multimedia
  (setq julia-snail-multimedia-enable t)
  (setq julia-snail-multimedia-buffer-autoswitch t)
  )

;; LSP
(use-package eglot-jl
  :ensure t
  :init (setq eglot-connect-timeout 180) ;; prevent eglot timeout
  :hook ((julia-ts-mode . eglot-jl-init)
         (julia-ts-mode . eglot-ensure))
  )

;; Documentation
(use-package eldoc
  :hook (julia-ts-mode . eldoc-mode))

(provide 'julia-module)
