;;; package --- Summary

;;; Commentary:

;;; Code:

;; LSP
(use-package eglot
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





(provide 'lsp-module)
;;; lsp-module.el ends here
