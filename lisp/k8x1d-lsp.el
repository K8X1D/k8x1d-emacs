;;
;; Eglot configuration 
;;

(use-package eglot
  :if (equal k8x1d-lsp-module "eglot")
  :init
  (setq eglot-connect-timeout 90) ;; prevent eglot timeout
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
   (lua-mode . eglot-ensure)
   (scheme-mode . eglot-ensure)
   (LaTeX-mode . eglot-ensure)
   ;; (text-mode . eglot-ensure) ;; ltex-ls is not working properly...
   )
  :config
  ;; eldoc
  ;;(setq eldoc-idle-delay nil)

  ;; Extra language support
  (add-to-list 'eglot-server-programs '(r-ts-mode . ("R" "--slave" "-e" "languageserver::run()")))
  (add-to-list 'eglot-server-programs '(ess-r-mode . ("R" "--slave" "-e" "languageserver::run()")))
  (add-to-list 'eglot-server-programs '(julia-ts-mode . ("julia" "--project=~/.julia/packages/LanguageServer/0vsx2/src" "-e" "using LanguageServer; runserver()")))
  (add-to-list 'eglot-server-programs '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs '(scheme-mode . ("guile-lsp-server")))
  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("texlab")))
  ;; FIXME: ltex don't start properly
  ;; FIXME: ltex don't ignore latex env
  ;; FIXME: ltex don't ignore org markup
  ;; (add-to-list 'eglot-server-programs '(text-mode . ("ltex-ls")))
  )

;; (use-package eglot-ltex
;;   :if (equal k8x1d-lsp-module "eglot")
;;   :hook (text-mode . (lambda ()
;;                        (require 'eglot-ltex)
;;                        (eglot-ensure)))
;;   :init
;;  ;; (setq eglot-languagetool-server-path "/home/k8x1d/.nix-profile/") ;; don't work properly, slow to start if it start
;;  (setq eglot-languagetool-server-path "/home/k8x1d/.cache/emacs/ltex-ls-15.2.0/")
;;   )


;;
;; LSP-bridge configuration
;;
(use-package yasnippet
  :if (equal k8x1d-lsp-module "lsp-bridge")
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)) 

(use-package lsp-bridge
  :if (equal k8x1d-lsp-module "lsp-bridge")
  ;;:load-path (concat user-emacs-directory "/lsp-bridge")
  :load-path "~/.k8x1d-emacs.d/lsp-bridge"
  ;;:hook (after-init . global-lsp-bridge-mode)
  :hook (
	 (prog-mode . lsp-bridge-mode)
	 ;; (text-mode. lsp-bridge-mode) ;; does nothing for now...
	 )
  :config
  ;;(setq lsp-bridge-tex-lsp-server "texlab")
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
      (propertize "lsp"'face mode-face)))

  ;; Add auctex support (not initially in)
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(LaTeX-mode-hook)))

  ;; Add support to julia-ts-mode
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(julia-ts-mode . "julials"))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(julia-ts-mode)))

  ;; Add support ltex 
  ;; FIXME: repair
;;; [LSP-Bridge] Message could not be parsed.
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(org-mode . "ltex-ls"))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(org-mode)))

  ;; Add support for guile
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(scheme-mode . "guile-scheme"))
  (setq lsp-bridge-default-mode-hooks (append lsp-bridge-default-mode-hooks '(scheme-mode-mode)))

  )

;;
;; Diagnostics
;;
(use-package flymake
  :general
  (k8x1d/local-leader-keysVous avez envoyé
			       Salut Léa-Raphaëlle, pour suivi, je confirme avoir reçu ton troisième virement! 
			       Donc, ça fait 609$ reçu en date du 10 août 2023
			       Reste: 1015-609 = 406$
			       À plus!
			       :keymaps 'flymake-mode-map
			       "d" '(:ignore t :which-key "Diagnostic")
			       "db" '(flymake-show-buffer-diagnostics :which-key "List")
			       "dn" '(flymake-goto-next-error :which-key "Next")
			       "dp" '(flymake-goto-prev-error :which-key "Previous")
			       "ds" '(consult-flymake :which-key "Search")
			       )
  )


;;
;; Lsp-mode
;;

(use-package lsp-mode
  :if (equal k8x1d-lsp-module "lsp-mode")
  :init
  ;;(setq lsp-keymap-prefix "SPC m L")
  :hook ((ess-r-mode . lsp-deferred)
	 (python-ts-mode . lsp-deferred)
	 (LaTeX-mode . lsp-deferred)
	 (org-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-headerline-breadcrumb-enable nil);; remove headline
  (setq lsp-modeline-diagnostics-enable nil) ;; superflous

  ;;(setq lsp-enable-folding t)
  (add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
  (add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))
  (add-to-list 'lsp-language-id-configuration '(python-ts-mode . "python"))
  (add-to-list 'lsp-language-id-configuration '(R-mode . "r"))
  (add-to-list 'lsp-language-id-configuration '(org-mode . "org"))
  (add-to-list 'lsp-language-id-configuration '(org-journal-mode . "org"))
  )

;; Corfu support
(use-package lsp-mode
  :if (equal k8x1d-lsp-module "lsp-mode")
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
	  '(orderless))) ;; Configure orderless
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))



;; optionally
(use-package lsp-ui
  :if (equal k8x1d-lsp-module "lsp-mode")
  :commands lsp-ui-mode)

;; optionally if you want to use debugger
(use-package dap-mode
  :if (equal k8x1d-lsp-module "lsp-mode")
  )
;; (use-package dap-LANGUAGE) to load the dap adapter for your language


(use-package lsp-julia
  :load-path "~/.k8x1d-emacs.d/lsp-julia" ;; guix version is read-only...
  :if (equal k8x1d-lsp-module "lsp-mode")
  :hook ((julia-ts-mode . (lambda ()
			    (require 'lsp-julia)
			    (lsp-deferred)))
	 (julia-mode . (lambda ()
			 (require 'lsp-julia)
			 (lsp-deferred)))
	 )
  :config
  (setq lsp-julia-default-environment "~/.julia/environments/v1.8")
  ;;(setq lsp-julia-package-dir nil)
  (setq lsp-julia-command "/home/k8x1d/.guix-extra-profiles/k8x1d-emacs/k8x1d-emacs/bin/julia")
  (add-to-list 'lsp-language-id-configuration
	       '(julia-ts-mode . "julia"))

  ;;  ;; AOT config
  ;; (setq lsp-julia-package-dir nil)
  ;; (setq lsp-julia-flags `("-J/home/k8x1d/.cache/emacs/languageserver.so"))
    )



  ;; Strange error: 
  ;; WARNING: Unsupported code language ID 'true', treating text as plaintext
  ;; FIXME: ltex don't ignore latex env
  ;; FIXME: ltex don't ignore org markup
  (use-package lsp-ltex
    :if (equal k8x1d-lsp-module "lsp-mode")
    :hook (text-mode . (lambda ()
			 (require 'lsp-ltex)
			 (lsp-deferred)))  
    :init
    ;;(setq lsp-ltex-version "15.2.0")
    (setq lsp-ltex-version "16.0.0")
    :config
    ;;(setq lsp-ltex-ls-path "~/.cache/emacs/ltex-ls-15.2.0")
    (setq lsp-ltex-languagetool-http-server-uri "http://localhost:8081/")
    (setq lsp-ltex-language "auto")
    (setq lsp-ltex-enabled t)

    ;; Litterate programming support
    ;; in test
    ;; (defalias 'org-babel-execute:ess-r 'org-babel-execute:R)
    ;; (defalias 'org-babel-variable-assignments:ess-r 'org-babel-variable-assignments:R)

    )



  ;; FIXME: don't work
  (use-package lsp-scheme
    :if (equal k8x1d-lsp-module "lsp-mode")
    :hook (scheme-mode . (lambda ()
			   (require 'lsp-scheme)
			   (lsp-deferred)))  
    :config
    (setq lsp-scheme-implementation "guile") ;;; also customizable
    )
  



  (provide 'k8x1d-lsp)
