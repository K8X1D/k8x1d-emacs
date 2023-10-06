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
  ;; (add-to-list 'eglot-server-programs '(lua-mode . ("lua-language-server")))
  ;; (add-to-list 'eglot-server-programs '(scheme-mode . ("guile-lsp-server")))
  )

;; Documentation
(use-package eldoc
  :if (equal lsp-framework "eglot")
  :config
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (setq eldoc-echo-area-use-multiline-p nil)
  )



(use-package consult-eglot
  :if (equal lsp-framework "eglot")
  )


;;; LSP bridge
(use-package lsp-bridge
  :if (equal lsp-framework "lsp-bridge")
  :ensure nil
  :bind (:map evil-normal-state-map
	      ("K" . lsp-bridge-popup-documentation)
	      :map acm-mode-map
	      ("C-j" . acm-select-next)
	      ("M-j" . acm-select-next)
	      ("C-k" . acm-select-prev)
	      ("M-k" . acm-select-prev)
	      ("C-h" . acm-doc-toggle)
	      ("M-h" . acm-doc-toggle)
	      )
  ;; :vc (:fetcher "github"  :repo "manateelazycat/lsp-bridge")
  :load-path "external/lsp-bridge"
  :hook ((prog-mode . lsp-bridge-mode)
	 (org-mode. lsp-bridge-mode))
  :config
  (setq lsp-bridge-enable-hover-diagnostic t) ;; diagnostics
  (setq lsp-bridge-enable-org-babel t) ;; Org-babel support
  ;; (setq lsp-bridge-enable-auto-format-code t) ;; Formatting, testing auto-format instead

  (setq acm-enable-doc-markdown-render nil)
  (setq acm-enable-search-file-words nil) ;; Do not clutter completion options with words
  ;; (setq lsp-bridge-enable-search-words nil) ;; kiss
  ;; (add-to-list 'lsp-bridge-search-words-prohibit-file-extensions "org")

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


  (require 'bind-key)
  ;; (unbind-key "C-k" global-map) ;; Clean keys for lsp-bridge in latex
  (unbind-key "C-k" evil-insert-state-map) ;; Clean keys for lsp-bridge in latex

  )



(provide 'lsp-module)
;;; lsp-module.el ends here
