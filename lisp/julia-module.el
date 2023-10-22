;;; package --- Summary

;;; Commentary:

;;; Code:

;; Julia
;; Syntax highlight
(use-package julia-mode
  )

;; REPL
(use-package julia-vterm
  
  :init
  (defun k8x1d/open-julia-repl-at-bottom ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (julia-vterm-repl)
    (evil-insert-state)
    )
  :bind ("C-c o r j" . k8x1d/open-julia-repl-at-bottom)
  :hook (julia-mode . julia-vterm-mode)
  :config
  (setq vterm-kill-buffer-on-exit nil))

;; Formater
(use-package julia-formatter
  
  :init (require 'julia-formatter)
  :hook (julia-mode . julia-formatter-mode)
  :vc (:fetcher "codeberg"  :repo "FelipeLema/julia-formatter.el"))

;; Babel support
(use-package ob-julia-vterm
  
  :init
  (with-eval-after-load 'org
    (add-to-list 'org-babel-load-languages '(julia-vterm . t))
    (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
    (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
    (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm))
  )

;; LSP
(use-package eglot-jl
  
  :if (equal lsp-framework "eglot")
  :init (setq eglot-connect-timeout 180) ;; prevent eglot timeout
  :hook ((julia-mode . eglot-jl-init)
	 (julia-mode . eglot-ensure))
  )
(use-package lsp-julia
  
  :if (equal lsp-framework "lsp-mode")
  :hook ((julia-ts-mode . (lambda ()
			    (require 'lsp-julia)
			    (lsp-deferred)))
	 (julia-mode . (lambda ()
			 (require 'lsp-julia)
			 (lsp-deferred)))
	 )
  :config
  (setq lsp-julia-default-environment "~/.julia/environments/v1.8")
  ;;(setq lsp-julia-package-dir nil)
  (setq lsp-julia-command "julia")
  (add-to-list 'lsp-language-id-configuration
	       '(julia-ts-mode . "julia"))
  ;;  ;; AOT config
  ;; (setq lsp-julia-package-dir nil)
  ;; (setq lsp-julia-flags `("-J/home/k8x1d/.cache/emacs/languageserver.so"))

  ;; Add support over TRAMP
  ;; Adapted from https://github.com/gdkrmr/lsp-julia/issues/49
  ;; Don't work for now, but is a step in the right direction
  (defun lsp-julia--rls-command-remote ()
    "The command to lauch the Julia Language Server."
    `(,lsp-julia-command
      ,@lsp-julia-flags
      ,(concat "-e "
               "'"
               "import Pkg; Pkg.instantiate(); "
               "using InteractiveUtils, Sockets, SymbolServer, LanguageServer; "
               "Union{Int64, String}(x::String) = x; "
               "server = LanguageServer.LanguageServerInstance("
               "stdin, stdout, "
               (lsp-julia--get-root-remote) ", "
               (lsp-julia--get-depot-path) ", "
               "nothing, "
               (lsp-julia--symbol-server-store-path-to-jl-no-expand) "); "
               "run(server);"
               "'")))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection 'lsp-julia--rls-command-remote)
                    :major-modes '(julia-ts-mode julia-mode)
                    :server-id 'julia-ls-remote
                    :remote? t))
  )

;; Checker
;; Don't work anymore
;; (use-package flycheck-julia
;;   :hook ((julia-mode . flycheck-julia-setup)
;; 	 (julia-mode . flycheck-mode))
;;   )

(provide 'julia-module)
;;; julia-module.el ends here
