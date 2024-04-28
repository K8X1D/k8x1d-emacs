;; Syntax highlight + compilation
(use-package emacs
  :config
  (setq tex-fontify-script nil)
  )

;; Evil support
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
  ((latex-mode . 'turn-on-reftex)
   (LaTeX-mode . 'turn-on-reftex)
   (reftex-mode . visual-line-mode))
  :config
  (setq reftex-toc-split-windows-horizontally t)
  (setq reftex-toc-max-level 3)
  ;; (setq reftex-plug-into-AUCTeX t)
  (setq reftex-default-bibliography k8x1d/bibliography)
  (setq reftex-toc-split-windows-fraction 0.2))

;; Latex support
(use-package latex 
  :init
  ;; TODO: fuse function
  (defun k8x1d/insert-latex-item-below ()
    "Insert a latex item below the current line."
    (interactive)
    (evil-open-below 1)
    (latex-insert-item)
    )
  (defun k8x1d/insert-latex-item-above ()
    "Insert a latex item above the current line."
    (interactive)
    (evil-open-above 1)
    (latex-insert-item)
    )
  :hook (TeX-after-compilation-finished-functions . TeX-revert-document-buffer)
  :bind  (:map LaTeX-mode-map
	       (("C-<return>" . k8x1d/insert-latex-item-below)
		("C-S-<return>" . k8x1d/insert-latex-item-above))
	       )
  :config
  (setq reftex-plug-into-AUCTeX t)
  )

;;;; LSP support
;;(use-package eglot
;;  :if (equal k8x1d/lsp-backend "eglot")
;;  :hook ((LaTeX-mode . eglot-ensure))
;;  :config
;;  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("digestif")))
;;  )


;; Citar integration
(use-package citar-latex
  :after auctex)

(provide 'latex-module)
