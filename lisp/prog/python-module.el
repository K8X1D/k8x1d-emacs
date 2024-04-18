
;; FIXME: change name keybindings; new version of use-package allows it but at the cost of losing :vc... 
;; Syntax highlight + REPL
(use-package python
  :bind (:map python-ts-mode-map
	      ("C-c C-," . run-python)
	      ("C-c C-b" . python-shell-send-buffer)
	      ("C-c C-r" . python-shell-send-region)
	      ("C-c C-l" . python-shell-send-statement)
	      ("C-c C-'" . python-shell-restart)
	      )
 ;; :bind (:map python-ts-mode-map
 ;;	      ("C-c C-,"  ("Launch REPL" . run-python))
 ;;	      ("C-c C-b" ("Send buffer" . python-shell-send-buffer))
 ;;	      ("C-c C-r" ("Send region" . python-shell-send-region))
 ;;	      ("C-c C-l" ("Send line" . python-shell-send-statement))
 ;;	      ("C-c C-'" ("Restart REPL" . python-shell-restart))
 ;;	      )
  )

;; IDE
(use-package elpy
  :if (string= k8x1d/ide "full") 
  :hook (python-ts-mode . elpy-mode))

;; LSP
(use-package eglot
  :if (string= k8x1d/lsp-backend "eglot")
  :hook (python-ts-mode . eglot-ensure))

;; Documentation
(use-package eldoc
  :if (not (string=  k8x1d/lsp-backend "lsp-bridge"))
  :hook (python-ts-mode . eldoc-mode))

;; Venv compatibility
(use-package pyvenv-auto
  :hook ((python-ts-mode . pyvenv-auto-run)))


;; Data viewer
(use-package python-view-data
  :hook (python-mode . python-view-data-mode)
  :bind
  (:map python-mode-map
	("C-c C-v" . python-view-data-print))
  :config
  ;; Clean keybindings
  (require 'bind-key)
  (unbind-key "C-c C-i" python-view-data-mode-map) 
  )


(provide 'python-module)
