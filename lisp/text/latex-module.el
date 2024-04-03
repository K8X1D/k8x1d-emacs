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

;; Navigation
(use-package reftex
  :hook
  ((LaTeX-mode . 'turn-on-reftex)
   (reftex-mode . visual-line-mode))
  :config
  (setq reftex-toc-split-windows-horizontally t)
  (setq reftex-toc-max-level 3)
  ;; (setq reftex-plug-into-AUCTeX t)
  (setq reftex-default-bibliography k8x1d/bibliography)
  (setq reftex-toc-split-windows-fraction 0.2))


(provide 'latex-module)
