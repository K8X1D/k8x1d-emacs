;;;; Lsp
;;(use-package eglot

;;  :defer t
;;  :init
;;  (setq eglot-connect-timeout 180) ;; prevent eglot timeout
;;  )


;; FIXME: remplace by guix package
(add-to-list 'load-path (concat user-emacs-directory "/lsp-bridge"))


;; (use-package yasnippet
;;   :hook (after-init . yas-global-mode)) 

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)) 

(use-package lsp-bridge
  ;;:hook (after-init . global-lsp-bridge-mode)
  :hook (prog-mode . lsp-bridge-mode)
  :config
  ;;(setq lsp-bridge-tex-lsp-server "texlab")
  (setq lsp-bridge-tex-lsp-server "digestif")
  (setq lsp-bridge-python-lsp-server "pylsp")

  ;; Modeline
  (defun lsp-bridge--mode-line-format ()
    "Compose the LSP-bridge's mode-line."
    (setq-local mode-face
		(if (lsp-bridge-epc-live-p lsp-bridge-epc-process)
		    'lsp-bridge-alive-mode-line
		  'lsp-bridge-kill-mode-line))

    (when lsp-bridge-server
      (propertize "lsp"'face mode-face)))

  ;; Add auctex support (not initially in)
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(LaTeX-mode-hook)))

  ;; Add support to julia-ts-mode
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(julia-ts-mode . "julials"))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(julia-ts-mode)))

  ;; Add support for guile
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(scheme-mode . "guile-scheme"))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(scheme-mode-mode)))



  ;; ;; Add ltex support;; Don't work
  ;; (add-to-list 'lsp-bridge-single-lang-server-mode-list '(text-mode . "ltex"))
  ;; (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(text-mode-hook)))

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
