;; -*- lexical-binding: t; -*-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; eglot ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package eglot-ltex
  :if (string= k8x1d/lsp "eglot")
  ;; :hook ((LaTeX-mode message-mode org-src-mode) . (lambda ()
			;; (require 'eglot-ltex)
			;; (eglot-ensure)))
  :hook (text-mode . (lambda ()
			(require 'eglot-ltex)
			(eglot-ensure)))
  :init
  ;; (setq eglot-ltex-server-path "/home/k8x1d/.config/k8x1d-emacs/.cache/lsp/ltex-ls/ltex-ls-15.2.0/") ;; don't work...
  (setq eglot-ltex-server-path (concat user-emacs-directory ".cache/lsp/ltex-ls/latest/"))
  ;; (setq eglot-ltex-server-path "/home/k8x1d/.config/k8x1d-emacs/.cache/ltex-ls-15.2.0")
  ;; Fix me, don't work, see https://github.com/valentjn/ltex-ls/issues/262
  (setq eglot-connect-timeout 180)
  (setq eglot-ltex-communication-channel 'stdio)
  (defun k8x1d/launch-corrector ()
    (interactive)
    (require 'eglot-ltex)
    (eglot-ensure))

  ;; Set general config for ltex
(setq-default eglot-workspace-configuration
              ;; '(:ltex (:language "auto")) ;; don't work
              '(:ltex (:language "fr"))
  )
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; Lsp-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-ltex
  :if (string= k8x1d/lsp "lsp-mode")
  :hook (text-mode . (lambda ()
		       (require 'lsp-ltex)
		       (lsp-deferred)))
  :init
  (setq lsp-ltex-version "15.2.0")
  (setq lsp-ltex-language "fr")
  (setq lsp-ltex-ls-path (concat user-emacs-directory ".cache/lsp/ltex-ls/latest/bin/ltex-ls"))
  :config
  (add-to-list 'lsp-language-id-configuration '(csv-mode . "plaintext"))
  )




(provide 'corrector-module)
