;; -*- lexical-binding: t; -*-




;; LSP
;; (use-package lsp-mode
  ;; :hook (emacs-lisp-mode . lsp-deferred))

;; Diagnostic
(use-package flycheck
  :if (string= k8x1d/checker "flycheck")
  :hook
  (emacs-lisp-mode . flycheck-mode))

(use-package flymake
  :if (string= k8x1d/checker "flymake")
  :hook
  (emacs-lisp-mode . flymake-mode)
  )


(provide 'elisp-module)
