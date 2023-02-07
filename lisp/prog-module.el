
;;
;; General mode caracteristics
;;
(use-package emacs
  :defer t
  :hook
  (prog-mode . display-line-numbers-mode)) ;; Automatic display line-numbers in prog mode


;;
;; Julia support
;;

;; Syntax highlighting
(use-package julia-mode
  :defer t)


;; REPL
(use-package julia-vterm
:defer t
  :hook
  (julia-mode . julia-vterm-mode)
  )

(use-package ob-julia-vterm
:defer t
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



(use-package plantuml-mode
  :config
    ;;(setq plantuml-executable-path "/path/to/your/copy/of/plantuml.bin")
    (setq plantuml-default-exec-mode 'executable)
  )
 ;; :config
 ;; (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))



;;
;; R support
;;

;; Syntax highlighting and REPL
(use-package ess
  :defer t
  :hook
  (ess-r-mode . eglot-ensure)
  :config
  (setq ess-nuke-trailing-whitespace-p t
 	ess-style 'DEFAULT)
)

;;;; Data viewer
;; TODO: Result in bug, repair
;;(use-package ess-R-data-view
;;  :defer t)


;;
;; Guile Scheme support
;;

;; Syntax highlighting + REPL
(use-package geiser-guile
  :defer t)





(provide 'prog-module)
