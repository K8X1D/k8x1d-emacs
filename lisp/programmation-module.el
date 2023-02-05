
;;
;; Julia support
;;

;; Syntax highlighting
(use-package julia-mode
  :defer t)


;; REPL
(use-package julia-vterm
  :hook
  (julia-mode . julia-vterm-mode)
  )

(use-package ob-julia-vterm
  :config
 ;; (add-to-list 'org-babel-load-languages '(julia-vterm . t))
 ;; (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  )

(use-package eglot-jl
  :after (eglot julia-mode)
  :init
  (add-hook 'julia-mode-hook (lambda()
			       (setq eglot-connect-timeout 60))) ;; prevent eglot timeout 
  :config
  (setq eglot-jl-language-server-project "~/.julia/environments/v1.8")
  (eglot-jl-init))







(provide 'programmation-module)
