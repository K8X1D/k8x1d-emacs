;; Syntax highlight + functionality
(use-package auctex
  ;; :ensure auctex
  :hook
  (LaTeX-mode . visual-line-mode)
  (LaTeX-mode . display-line-numbers-mode)
  (LaTeX-mode . flyspell-mode)
  (LaTeX-mode . LaTeX-math-mode)
  ;; FIXME: don't work
  ;; (LaTeX-mode . TeX-source-correlate-mode)        ; activate forward/reverse search
  (LaTeX-mode . TeX-PDF-mode)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq LaTeX-item-indent 2)
  (setq LaTeX-indent-level 4)
  (setq font-latex-fontify-script nil)
  )

;; LSP
(use-package lsp-mode
  :if (string= k8x1d/lsp "lsp-mode")
  :hook
  (LaTeX-mode . lsp-deferred)
  (LaTeX-mode . lsp-ui-sideline-mode)
  )

;; Diagnostic
(use-package flycheck
  :if (string= k8x1d/checker "flycheck")
  :hook
  (LaTeX-mode . flycheck-mode)
  :config
  (setq-default flycheck-enabled-checkers '(tex-lacheck)) ;; tex-chktex don't work
  (setq-default flycheck-disabled-checkers '(tex-chktex textlint)) ;; tex-chktex don't work
  )


;; ;; PDF viewing configuration
(use-package tex
  :ensure auctex
  :hook
  (TeX-after-compilation-finished-functions . TeX-revert-document-buffer)
  :config
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-source-correlate-start-server t)
  )


;;;; Navigation
(use-package reftex
  :diminish
 :hook
 ((latex-mode . turn-on-reftex)
  (LaTeX-mode . turn-on-reftex)
  (reftex-mode . visual-line-mode))
 :config
 (setq reftex-plug-into-AUCTeX t)
 (setq reftex-toc-split-windows-horizontally t)
 (setq reftex-toc-max-level 4)
 (setq reftex-level-indent 0)
 (setq reftex-default-bibliography k8x1d/bibliography)
 (setq reftex-toc-split-windows-fraction 0.2)
 )

(provide 'latex-module)
