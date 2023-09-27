;;; package --- Summary

;;; Commentary:

;;; Code:

;; Julia
;; Syntax highlight
(use-package julia-mode)

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
  :init (setq eglot-connect-timeout 180) ;; prevent eglot timeout
  :hook ((julia-mode . eglot-jl-init)
	 (julia-mode . eglot-ensure))
  )

(provide 'julia-module)
;;; julia-module.el ends here
