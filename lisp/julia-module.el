;; Syntax highlight
(use-package julia-mode)
;; Fix https://github.com/JuliaEditorSupport/julia-ts-mode/issues/25
;; (use-package julia-ts-mode
  ;; :vc (:url "https://github.com/dhanak/julia-ts-mode" :branch "main")
  ;; :mode "\\.jl$")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REPL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ess
  :if (string= k8x1d/terminal "shell")
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "or"  '(:ignore t :which-key "REPL")
   "orj"  '(run-ess-julia :which-key "REPL")
    )
  :mode
  ("\\.jl\\'" . ess-julia-mode)
  ;; :hook
  ;; (julia-mode . ess-julia-mode)
  ;; (julia-mode . ess-mode)
  :config
  (setq ess-use-company nil)
  (setq ess-history-file nil)
  )


(use-package julia-vterm
  :if (string= k8x1d/terminal "vterm")
  :diminish
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "or"  '(:ignore t :which-key "REPL")
   "orj"  '(julia-vterm-repl :which-key "REPL")
    )
  (k8x1d/local-leader-keys
    :keymaps 'julia-vterm-mode-map
    "'" '(julia-vterm-switch-to-repl-buffer :which-key "REPL")
    "b" '(julia-vterm-send-buffer :which-key "Send buffer")
    "RET" '(julia-vterm-send-region-or-current-line :which-key "Send line or region")
    "i" '(julia-vterm-send-include-buffer-file :which-key "Send script")
    )
  :hook
  (julia-mode . julia-vterm-mode)
  )

;; LSP
(use-package lsp-julia
  :if (and (string= k8x1d/lsp "lsp-mode") 
	   (string= k8x1d/terminal "vterm"))
  :init
  (setq lsp-julia-package-dir "~/.julia/environments/v1.8")
  :hook
  (julia-mode . (lambda ()
                        (require 'lsp-julia)
                        (lsp-deferred)
			;; (lsp-ui-sideline-mode)
			))
  :config
  (setq lsp-julia-default-environment "~/.julia/environments/v1.8")
  ;; julia-ts-mode configuration
  (add-to-list 'lsp-language-id-configuration '(julia-ts-mode . "julia"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection 'lsp-julia--rls-command)
                    :major-modes '(julia-mode ess-julia-mode julia-ts-mode)
                    :server-id 'julia-ls
                    :multi-root t))
  )
(use-package eglot
  :if (string= k8x1d/lsp "eglot")
  :init
  (setq eglot-connect-timeout 180)
  :hook
  (julia-mode . eglot-ensure) ;; lsp
  :config
  ;; set lsp program
  (add-to-list 'eglot-server-programs
	       '(julia-mode . (
			       "julia"
			       "--startup-file=no"
			       "--history-file=no"
			       ;; "--project=/home/k8x1d/.julia/environments/emacs"
			       "--project=/home/k8x1d/.julia/environments/nvim-lspconfig"
			       "-e"
			       "using LanguageServer; runserver()"
			       ))
	       )
  )

;; Diagnostic
(use-package flycheck
  :if (string= k8x1d/checker "flycheck")
  :hook
  (julia-mode . flycheck-mode))
(use-package flymake
  :if (string= k8x1d/checker "flymake")
  :hook
  (julia-mode . flymake-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Notebook
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :if (string= k8x1d/terminal "shell")
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((julia . t)))
  )

(use-package ob-julia-vterm
  :if (string= k8x1d/terminal "vterm")
  )
(use-package org
  :if (string= k8x1d/terminal "vterm")
  :config
  (require 'ob-julia-vterm)
  (add-to-list 'org-babel-load-languages '(julia-vterm . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  )


(provide 'julia-module)
