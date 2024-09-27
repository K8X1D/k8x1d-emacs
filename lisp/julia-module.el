;; Syntax highlight
(use-package julia-mode)
;; Fix https://github.com/JuliaEditorSupport/julia-ts-mode/issues/25
;; (use-package julia-ts-mode
  ;; :vc (:url "https://github.com/dhanak/julia-ts-mode" :branch "main")
  ;; :mode "\\.jl$")

;; REPL
(use-package julia-vterm
  :diminish
  :hook
  (julia-mode . julia-vterm-mode))
;; alt with ess
;; Don't support evil in doc
;; Partial functionality for repl
;; (use-package ess-julia-mode
;;   :ensure ess
;;   :mode "\\.jl\\'"
;;   )

;; LSP
(use-package lsp-julia
  :hook (julia-mode . (lambda ()
                        (require 'lsp-julia)
                        (lsp-deferred)))
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

;; Diagnostic
(use-package flycheck
  :hook
  (julia-mode . flycheck-mode))


;; Notebook
(use-package ob-julia-vterm)
(use-package org
  :config
  (require 'ob-julia-vterm)
  (add-to-list 'org-babel-load-languages '(julia-vterm . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  )


(provide 'julia-module)
