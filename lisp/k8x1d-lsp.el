;;; package --- Summary



;;; Commentary:

;;; Code:


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

;; (use-package sideline
;;   :init
;;   (setq sideline-backends-right '(sideline-flycheck)))

;; (use-package sideline-lsp
;;   :hook (lsp-mode . sideline-mode)
;;   :config
;;   (setq sideline-backends-right '(sideline-lsp))
;;   )

;; (use-package sideline-flycheck
;;   :hook (flycheck-mode . sideline-flycheck-setup))


;;
;; Lsp-mode
;;

(use-package lsp-mode
  :if (equal k8x1d-lsp-module "lsp-mode")
  :general
  (k8x1d/local-leader-keys
    "L" '(:keymap lsp-command-map
		  :which-key "LSP")
    )
  :hook ((ess-r-mode . lsp-deferred)
	 (python-ts-mode . lsp-deferred)
	 (sql-mode . lsp-deferred)
	 (scheme-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-headerline-breadcrumb-enable nil);; remove headline
  (setq lsp-modeline-diagnostics-enable nil) ;; superflous
  (setq lsp-modeline-code-actions-enable nil) ;; superflous

  (add-to-list 'lsp-language-id-configuration '(python-ts-mode . "python"))
  (add-to-list 'lsp-language-id-configuration '(R-mode . "r"))
  (add-to-list 'lsp-language-id-configuration '(org-mode . "org"))
  (add-to-list 'lsp-language-id-configuration '(org-journal-mode . "org"))

  ;; Guile scheme support
  ;; Use shopify-cli / theme-check-language-server for Shopify's liquid syntax
  ;;(add-to-list 'lsp-language-id-configuration '(scheme-mode . "guile-scheme"))

  ;; (lsp-register-client
  ;;   (make-lsp-client :new-connection (lsp-stdio-connection "guile-lsp-server")
  ;;                    :activation-fn (lsp-activate-on "guile-scheme")
  ;;                    :server-id 'theme-check))

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


(use-package consult-lsp
  :if k8x1d-consult-integration
  :after lsp-mode
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'consult-lsp-symbols)
  )

;; optionally
;; FIXME: lsp-ui-sideline doesn't work with flymake (need flycheck), evaluate...
(use-package lsp-ui
  :if (equal k8x1d-lsp-module "lsp-mode")
  :init
  ;; Sideline
  ;; Cause some problems, see https://github.com/emacs-lsp/lsp-ui/issues/746, disbling for now
  ;; Replaced by sideline
  (setq lsp-ui-sideline-enable nil)
  :commands lsp-ui-mode
  :config
  ;; Peek feature
  (setq lsp-ui-peek-enable t)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

  ;; (setq lsp-ui-sideline-show-hover t)
  ;; (setq lsp-ui-sideline-show-diagnostics t)
  ;; (setq lsp-ui-sideline-show-symbol t)
  ;;(setq lsp-ui-sideline-show-code-actions nil)
  )

;; optionally if you want to use debugger
(use-package dap-mode
  :if (equal k8x1d-lsp-module "lsp-mode")
  )
;; (use-package dap-LANGUAGE) to load the dap adapter for your language





;;(use-package lsp-latex
;;  :hook ((tex-mode . lsp-deferred)
;;	 (LaTeX-mode . lsp-deferred)
;;	 (yatex-mode . lsp-deferred)
;;	 (bibtex-mode . lsp-deferred)))

;; Strange error:
;; WARNING: Unsupported code language ID 'true', treating text as plaintext
(use-package lsp-ltex
  :if (equal k8x1d-lsp-module "lsp-mode")
  ;; :hook (text-mode . (lambda ()
  ;;    		       (require 'lsp-ltex)
  ;;    		       (lsp-deferred)))
  :init
  (setq lsp-ltex-version "16.0.0")
  :config
  (setq lsp-ltex-languagetool-http-server-uri "http://localhost:8081")
  )


(use-package lsp-scheme
  :if (equal k8x1d-lsp-module "lsp-mode")
  :hook (scheme-mode . lsp-scheme-guile)
  )


(provide 'k8x1d-lsp)
;;; k8x1d-lsp.el ends here
