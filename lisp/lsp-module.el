;;; package --- Summary

;;; Commentary:

;;; Code:

;; LSP
(use-package eglot
  :if (equal lsp-framework "eglot")
  :bind
  (("C-c L a" . eglot-code-actions)
   ("C-c L c" . eglot-show-workspace-configuration)
   ("C-c L f" . eglot-format)
   ("C-c L F" . eglot-format-buffer)
   ("C-c L d" . eglot-shutdown)
   ("C-c L D" . eglot-shutdown-all))
  :config
  ;; Clean modeline info
  (setq mode-line-misc-info (delete '(eglot--managed-mode (" [" eglot--mode-line-format "] ")) mode-line-misc-info))
  (add-to-list 'mode-line-misc-info
	       `(eglot--managed-mode ("[" eglot--mode-line-format "]")))


  ;; Extra language support
  ;; (add-to-list 'eglot-server-programs '(ess-r-mode . ("R" "--slave" "-e" "languageserver::run()")))
  ;; (add-to-list 'eglot-server-programs '(lua-mode . ("lua-language-server")))
  ;; (add-to-list 'eglot-server-programs '(scheme-mode . ("guile-lsp-server")))
  )

(use-package consult-eglot
  :if (equal lsp-framework "eglot")
  )


;;; LSP bridge

(use-package markdown-mode)
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  )
(use-package yasnippet-snippets)
(use-package lsp-bridge
  :ensure nil
  :bind
  (("K" . lsp-bridge-popup-documentation)
  (:map acm-mode-map
	      ("M-j" . acm-select-next)
	      ("M-k" . acm-select-prev)
	      ("M-h" . acm-doc-toggle)
	      ))
  :if (equal lsp-framework "lsp-bridge")
  ;; :vc (:fetcher "github"  :repo "manateelazycat/lsp-bridge")
  :load-path "external/lsp-bridge"
  :hook (after-init . global-lsp-bridge-mode)
  :config
  (setq lsp-bridge-enable-hover-diagnostic t) ;; diagnostics
  (setq lsp-bridge-enable-org-babel t) ;; Org-babel support
  (setq lsp-bridge-enable-auto-format-code t) ;; Formatting

  ;; Default lsp server
  (setq lsp-bridge-tex-lsp-server "digestif")
  (setq lsp-bridge-python-lsp-server "pylsp")
  (setq lsp-bridge-c-lsp-server "ccls")

  ;; Modeline
  (defun lsp-bridge--mode-line-format ()
    "Compose the LSP-bridge's mode-line."
    (setq-local mode-face
		(if (lsp-bridge-epc-live-p lsp-bridge-epc-process)
		    'lsp-bridge-alive-mode-line
		  'lsp-bridge-kill-mode-line))

    (when lsp-bridge-server
      (propertize "🚀"'face mode-face)))

  ;; Extend support
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(org-mode . "ltex-ls"))
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(scheme-mode . "scheme-lsp-server"))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(LaTeX-mode-hook)))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(scheme-mode-mode)))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(org-mode)))
  )



(provide 'lsp-module)
;;; lsp-module.el ends here
