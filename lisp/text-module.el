
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
  :bind (("C-c b" . citar-insert-citation)
	 (:map minibuffer-local-map
	 ("M-b" . citar-insert-preset))
	 (:map org-mode-map
	 ("C-c b" . org-cite-insert))
	 )
  :config
  ;; Org cite configuration to use citar
  (setq org-cite-insert-processor 'citar)
  (setq org-cite-follow-processor 'citar)
  (setq org-cite-activate-processor 'citar)
  (setq citar-bibliography org-cite-global-bibliography)
  (setq citar-at-point-function 'embark-act)
  ;; Icons support
  (setq citar-symbols
 	`((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
 	  (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
 	  (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
  (setq citar-symbol-separator "  ")
  ;; Notes
  (setq citar-notes-paths '("~/Zotero/notes"))
  )



(use-package citar-embark
  :after citar embark
  :no-require
  :config (citar-embark-mode))


;;
;; Latex better support
;;

(use-package reftex
  :hook
  (reftex-mode . visual-line-mode)
  :config
  (setq reftex-toc-split-windows-horizontally t)
  (setq reftex-toc-max-level 3)
  (setq reftex-toc-split-windows-fraction 0.2)
  )


(use-package auctex
  :init
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
  :hook
  ((LaTeX-mode . eglot-ensure)
   (LaTeX-mode . LaTeX-math-mode)
   (LaTeX-mode . turn-on-reftex))
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
