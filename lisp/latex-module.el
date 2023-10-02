;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package reftex
  :hook
  ((LaTeX-mode . 'turn-on-reftex)
   (reftex-mode . visual-line-mode))
  :config
  (setq reftex-toc-split-windows-horizontally t)
  (setq reftex-toc-max-level 3)
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-default-bibliography default-bibliography)
  (setq reftex-toc-split-windows-fraction 0.2))

(use-package org-edit-latex
  :hook (org . org-edit-latex-mode)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((latex . t))))

(use-package evil-tex
  :after evil
  :hook (LaTeX-mode . evil-tex-mode)
  :config
  (require 'bind-key)
  (unbind-key "M-n" evil-tex-mode-map) ;; Clean keys for lsp-bridge in latex
  )


(use-package auctex
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
  (setq TeX-parse-self t ; parse on load
	TeX-auto-save t  ; parse on save
	;; Use hidden directories for AUCTeX files.
	TeX-auto-local ".auctex-auto"
	TeX-style-local ".auctex-style"
	TeX-source-correlate-mode t
	TeX-source-correlate-method 'synctex
	;; Don't start the Emacs server when correlating sources.
	TeX-source-correlate-start-server nil
	;; Automatically insert braces after sub/superscript in `LaTeX-math-mode'.
	TeX-electric-sub-and-superscript t
	;; Just save, don't ask before each compilation.
	TeX-save-query nil

	TeX-source-correlate-start-server t
	TeX-PDF-mode t
	;; Set pdf viewer
	TeX-view-program-selection '((output-pdf "PDF Tools"))
	reftex-plug-into-AUCTeX t)
  (add-hook 'TeX-after-compilation-finished-functions
	    #'TeX-revert-document-buffer)
  (custom-set-faces
   `(font-latex-slide-title-face ((t (:inherit (variable-pitch font-lock-type-face) :weight bold :height 0.8))))
   )
  :bind
  (:map LaTeX-mode-map
	(("C-<return>" . k8x1d/insert-latex-item-below)
	 ("C-S-<return>" . k8x1d/insert-latex-item-above))
	)
  :hook
  (LaTeX-mode . LaTeX-math-mode)
  (LaTeX-mode . corfu-mode)
  (LaTeX-mode . visual-line-mode)
  (LaTeX-mode . display-line-numbers-mode)
  (LaTeX-mode . prettify-symbols-mode)
  ;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  ;;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  :config

  (require 'bind-key)
  (unbind-key "C-<return>" LaTeX-mode-map)
  (setq LaTeX-indent-level 4)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  ;; (setq TeX-view-program-selection '((output-pdf "Zathura")))
  (setq TeX-tree-roots '(".git" ".dir-locals.el" ".auctex-auto"))
  )

;; LsP
(use-package eglot
  :if (equal lsp-framework "eglot")
  :hook ((LaTeX-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("digestif"))))


(provide 'latex-module)
;;; latex-module.el ends here