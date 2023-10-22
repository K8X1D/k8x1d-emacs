;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package eglot-ltex
  
  :if (equal lsp-framework "eglot")
  :vc (:fetcher "github"  :repo "emacs-languagetool/eglot-ltex")
  :hook ((org-mode . (lambda ()
		       (require 'eglot-ltex)
		       (eglot-ensure)))
	 (LaTeX-mode . (lambda ()
			 (require 'eglot-ltex)
			 (eglot-ensure))))
  :init
  ;; (setq eglot-languagetool-server-path "/home/k8x1d/.nix-profile/") ;; don't work properly, slow to start if it start
  (setq eglot-languagetool-server-path "/home/k8x1d/.cache/emacs/ltex-ls-15.2.0/")
  )

;; Lsp-mode support
(use-package lsp-ltex
  
  :if (equal lsp-framework "lsp-mode")
  :hook ((org-mode . (lambda ()
		       (require 'lsp-ltex)
		       (lsp-deferred)))
	 (LaTeX-mode . (lambda ()
			 (require 'lsp-ltex)
			 (lsp-deferred))))
  :init
  (setq lsp-ltex-version "16.0.0")
  :config
  (setq lsp-ltex-languagetool-http-server-uri "http://localhost:8081")
  )



(provide 'corrector-module)
;;; corrector-module.el ends here
