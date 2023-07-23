;;;; Lsp
;;(use-package eglot
;;  :defer t
;;  :init
;;  (setq eglot-connect-timeout 180) ;; prevent eglot timeout
;;  )


;; FIXME: remplace by guix package
(add-to-list 'load-path (concat user-emacs-directory "/lsp-bridge"))


(use-package yasnippet
  :hook (after-init . yas-global-mode)) 

(use-package lsp-bridge
  :hook (after-init . global-lsp-bridge-mode)
  ;;:config (setq acm-enable-icon t)
  ;; Don't work, stick with original
  ;; :config
  ;;:bind
  ;;(:map lsp-bridge-mode-map
  ;;	(("TAB" . acm-select-next)
  ;;	 ("<backtab>" . acm-select-prev)))
  ;; :bind (("TAB" . acm-select-next)
  ;; 	 ("<backtab>" . acm-select-prev)
  ;; 	 ("RET" . acm-complete))
  ;;:init
  ;;(require 'bind-key)
  ;;(unbind-key "TAB" lsp-bridge-mode-map)
)
 

;; Diagnostics
(use-package flymake
  :defer t
  :general
  (k8x1d/leader-keys
    "d" '(:ignore t :which-key "Diagnostic")
    "db" '(flymake-show-buffer-diagnostics :which-key "List")
    "dn" '(flymake-goto-next-error :which-key "Next")
    "dp" '(flymake-goto-prev-error :which-key "Previous")
    "ds" '(consult-flymake :which-key "Search")
    )
  )


(provide 'k8x1d-lsp)
