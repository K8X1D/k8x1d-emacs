;; Syntax highlight + compilation
(use-package emacs
  :config
  (setq tex-fontify-script nil)
  )

;; Latex support
(use-package evil-tex
  :after evil
  :hook (LaTeX-mode . evil-tex-mode)
  :config
  (require 'bind-key)
  (unbind-key "m-n" evil-tex-mode-map) ;; clean keys for lsp-bridge in latex
  )

(provide 'latex-module)
