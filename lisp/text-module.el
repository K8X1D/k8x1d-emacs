
;; General mode caracteristics
(use-package emacs
  :defer t
  :hook
  (text-mode . visual-line-mode)) ;; Automatic wrap text in text mode



(unless (package-installed-p 'eglot-ltex)
  (package-vc-install "https://github.com/emacs-languagetool/eglot-ltex"))

(use-package eglot-ltex
  :defer t
  :ensure nil
  :hook (LaTeX-mode . (lambda ()
			(require 'eglot-ltex)
			(call-interactively #'eglot)))
  :init
  (setq eglot-languagetool-server-path "~/Documents/Developpement/Logiciels/Editeurs/2022/A/ltex-ls-15.2.0/")
  ;;(setq eglot-languagetool-server-path "~/Documents/Developpement/Logiciels/Editeurs/2022/A/k8x1d-emacs/ltex-ls/"))
  :config
  (defun k8x1d/start-ltex ()
    (interactive)
    (require 'eglot-ltex)
    (call-interactively #'eglot))
  )


;;
;; Bibliography interaction
;;

(use-package citar
  :defer t
  :bind (("C-c b" . citar-insert-citation)
	 :map minibuffer-local-map
	 ("M-b" . citar-insert-preset))
  :config
  (setq org-cite-global-bibliography '("~/Zotero/k8x1d.bib"))
  (setq org-cite-insert-processor 'citar)
  (setq org-cite-follow-processor 'citar)
  (setq org-cite-activate-processor 'citar)
  (setq citar-bibliography org-cite-global-bibliography)
  )

;;
;; Latex better support
;;

(use-package reftex
  :hook
  (reftex-mode . visual-line-mode)
  :config
  (setq reftex-toc-split-windows-horizontally t)
  (setq reftex-toc-max-level 3)
  )


(use-package auctex
  :defer t
  :hook
  ((LaTeX-mode . eglot-ensure)
   (LaTeX-mode . LaTeX-math-mode)
   (LaTeX-mode . turn-on-reftex))
  :config
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

	TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-source-correlate-start-server t
	TeX-PDF-mode t
	reftex-plug-into-AUCTeX t)
  (add-hook 'TeX-after-compilation-finished-functions
	    #'TeX-revert-document-buffer)
  ;;(add-hook 'LaTeX-mode-hook 'eglot-ensure)
  ;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  ;;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

  )

(use-package auctex-latexmk
  :defer t
  :after auctex
  :init
  ;; Pass the -pdf flag when TeX-PDF-mode is active.
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  ;; Set LatexMk as the default.
  :config
  (setq TeX-command-default "LatexMk")
  ;; Add LatexMk as a TeX target.
  (auctex-latexmk-setup))




(provide 'text-module)
