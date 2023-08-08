;;
;; Eglot configuration 
;;

(use-package eglot
  :init
  (setq eglot-connect-timeout 180) ;; prevent eglot timeout
  :general
  ;; Set to local instead
  ;; (k8x1d/leader-keys
  ;;   "l" '(:ignore t :which-key "LSP")
  ;;   "la" '(eglot-code-actions :which-key "Action")
  ;;   "lc" '(eglot-show-workspace-configuration :which-key "Show config")
  ;;   "lf" '(:ignore t :which-key "Format")
  ;;   "lfr" '(eglot-format :which-key "Region")
  ;;   "lff" '(eglot-format-buffer :which-key "File")
  ;;   "ld" '(eglot-shutdown :which-key "Disconnect")
  ;;   "lD" '(eglot-shutdown-all :which-key "Disconnect all"))
  (k8x1d/local-leader-keys
    :keymaps 'eglot-mode-map
    "L" '(:ignore t :which-key "LSP")
    "La" '(eglot-code-actions :which-key "Action")
    "Lc" '(eglot-show-workspace-configuration :which-key "Show config")
    "K" '(eldoc :which-key "Documentation")
    "Lf" '(:ignore t :which-key "Format")
    "Lfr" '(eglot-format :which-key "Region")
    "Lff" '(eglot-format-buffer :which-key "File")
    "Ld" '(eglot-shutdown :which-key "Disconnect")
    "LD" '(eglot-shutdown-all :which-key "Disconnect all"))
  :hook
  ((ess-r-mode . eglot-ensure)
   (r-ts-mode . eglot-ensure)
   (julia-mode . eglot-ensure)
   (julia-ts-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (python-ts-mode . eglot-ensure)
   (scheme-mode . eglot-ensure)
   (LaTeX-mode . eglot-ensure)
   (text-mode . eglot-ensure))
  :config
  ;; eldoc
  ;;(setq eldoc-idle-delay nil)

  ;; Extra language support
  (add-to-list 'eglot-server-programs '(r-ts-mode . ("R" "--slave" "-e" "languageserver::run()")))
  (add-to-list 'eglot-server-programs '(ess-r-mode . ("R" "--slave" "-e" "languageserver::run()")))
  (add-to-list 'eglot-server-programs '(julia-ts-mode . ("julia" "--project=~/.julia/packages/LanguageServer/0vsx2/src" "-e" "using LanguageServer; runserver()")))
  (add-to-list 'eglot-server-programs '(scheme-mode . ("guile-lsp-server")))
  ;; TODO: update to version 16.0, don't work for now, see https://github.com/valentjn/ltex-ls/issues/262
  (add-to-list 'eglot-server-programs '(text-mode . ("ltex-ls")))
)


;; ;;
;; ;; LSP-bridge configuration
;; ;;
;; (use-package yasnippet
;;   :hook (prog-mode . yas-minor-mode)
;;   :config
;;   (yas-reload-all)) 

;; (use-package lsp-bridge
;;   ;;:load-path (concat user-emacs-directory "/lsp-bridge")
;;   :load-path "~/.k8x1d-emacs.d/lsp-bridge"
;;   ;;:hook (after-init . global-lsp-bridge-mode)
;;   :hook (prog-mode . lsp-bridge-mode)
;;   :config
;;   ;;(setq lsp-bridge-tex-lsp-server "texlab")
;;   (setq lsp-bridge-tex-lsp-server "digestif")
;;   (setq lsp-bridge-python-lsp-server "pylsp")
;;   (setq lsp-bridge-c-lsp-server "ccls")

;;   ;; Modeline
;;   (defun lsp-bridge--mode-line-format ()
;;     "Compose the LSP-bridge's mode-line."
;;     (setq-local mode-face
;; 		(if (lsp-bridge-epc-live-p lsp-bridge-epc-process)
;; 		    'lsp-bridge-alive-mode-line
;; 		  'lsp-bridge-kill-mode-line))

;;     (when lsp-bridge-server
;;       (propertize "lsp"'face mode-face)))

;;   ;; Add auctex support (not initially in)
;;   (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(LaTeX-mode-hook)))

;;   ;; Add support to julia-ts-mode
;;   (add-to-list 'lsp-bridge-single-lang-server-mode-list '(julia-ts-mode . "julials"))
;;   (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(julia-ts-mode)))

;;   ;; Add support for guile
;;   (add-to-list 'lsp-bridge-single-lang-server-mode-list '(scheme-mode . "guile-scheme"))
;;   (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(scheme-mode-mode)))

;;   )


;;
;; Diagnostics
;;
(use-package flymake
  :defer t
  :general
  (k8x1d/local-leader-keys
    :keymaps 'flymake-mode-map
    "d" '(:ignore t :which-key "Diagnostic")
    "db" '(flymake-show-buffer-diagnostics :which-key "List")
    "dn" '(flymake-goto-next-error :which-key "Next")
    "dp" '(flymake-goto-prev-error :which-key "Previous")
    "ds" '(consult-flymake :which-key "Search")
    )
  )


(provide 'k8x1d-lsp)
