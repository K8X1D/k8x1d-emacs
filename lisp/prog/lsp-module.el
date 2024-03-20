;; Native lsp support
(use-package eglot
  :if (string= k8x1d/lsp-backend "eglot")
  :bind
  (("C-c L a" . eglot-code-actions)
   ("C-c L c" . eglot-show-workspace-configuration)
   ("C-c L f" . eglot-format)
   ("C-c L F" . eglot-format-buffer)
   ("C-c L d" . eglot-shutdown)
   ("C-c L D" . eglot-shutdown-all))
  :config
  (setq mode-line-misc-info (delete '(eglot--managed-mode (" [" eglot--mode-line-format "] ")) mode-line-misc-info)) ;; Clean modeline info
  )


(use-package lsp-bridge
  :if (string= k8x1d/lsp-backend "lsp-bridge")
  :load-path "lisp/test/lsp-bridge/"
  ;; :vc (:url "https://github.com/manateelazycat/lsp-bridge"
  ;; :branch "master")
  :bind (
	 :map lsp-bridge-mode-map
	 ("K" . lsp-bridge-popup-documentation)
	 ("<tab>" . lsp-bridge-popup-complete-menu)
	 ("C-j" . lsp-bridge-popup-documentation-scroll-up)
	 ("C-k" . lsp-bridge-popup-documentation-scroll-down)
	 :map acm-mode-map
	 ("C-j" . acm-select-next)
	 ("C-k" . acm-select-prev)
	 )
  :hook (prog-mode . global-lsp-bridge-mode)
  :custom
  (lsp-bridge-enable-mode-line nil)
  (lsp-bridge-enable-log t) 
  :config
  ;; Python
  (setq lsp-bridge-python-lsp-server "pylsp")
  ;; Julia
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '((julia-ts-mode) . "julials"))
  ;; Latex
  (setq lsp-bridge-tex-lsp-server "digestif")
  ;; General configuration
  (setq lsp-bridge-complete-manually t)
  (setq lsp-bridge-enable-org-babel t)
  (setq acm-enable-doc nil)
  (setq acm-enable-icon t)
  (setq lsp-bridge-enable-completion-in-string t)
  ;; Remote configuration
  (setq lsp-bridge-enable-with-tramp t)
  (setq lsp-bridge-remote-start-automatically t)

  ;; Clean keybindings
  (require 'bind-key)
  (unbind-key "C-k" evil-insert-state-map) 
  (unbind-key "K" evil-motion-state-map) 
  )


(provide 'lsp-module)
