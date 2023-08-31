;;; package --- Summary



;;; Commentary:

;;; Code:

;;(use-package julia-mode
;;  :defer t)

;; Treesitter support
;; (use-package julia-ts-mode
;;   :defer t
;;   :mode "\\.jl$")


;; Syntax hightligh
(use-package julia-ts-mode
  :mode "\\.jl$")

;; REPL
(use-package julia-vterm
  :init
  (defun k8x1d/open-julia-repl-at-bottom ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (julia-vterm-repl)
    (evil-insert-state)
    )
  :general
  (k8x1d/leader-keys
    "orj" '(julia-vterm-repl :which-key "Julia")
    )
  (k8x1d/local-leader-keys
    :keymaps 'julia-ts-mode-map
    ;;"'" '(julia-vterm-switch-to-repl-buffer :which-key "Open REPL")
    "'" '(k8x1d/open-julia-repl-at-bottom :which-key "Open REPL")
    "l" '(julia-vterm-send-region-or-current-line :which-key "Send line")
    "b" '(julia-vterm-send-buffer :which-key "Send buffer")
    "f" '(julia-vterm-send-include-buffer-file :which-key "Send file")
    "r" '(julia-vterm-send-region-or-current-line :which-key "Send region")
    )
  :hook ((julia-mode . julia-vterm-mode)
	 (julia-ts-mode . julia-vterm-mode))
  :config
  (setq vterm-kill-buffer-on-exit nil))

;; FIXME: create idle...
(use-package julia-formatter
  :init (require 'julia-formatter)
  :straight (julia-formatter :host codeberg :repo "FelipeLema/julia-formatter.el"
			     :files ( "julia-formatter.el" ;; main script executed by Emacs
				      "formatter_service.jl" ;; script executed by Julia
				      "Manifest.toml" "Project.toml" ;; project files
				      ))
  :hook ((julia-mode . julia-formatter-mode)
	 (julia-ts-mode . julia-formatter-mode)))

;;(use-package flycheck-julia
;;  :if (equal k8x1d-lsp-module "lsp-mode")
;;  :hook (julia-mode . flycheck-julia-setup))


;;;; LSP
;; FIXME: startup time of (eglot-jl-init) is too high
;; TODO: compare manual setup via eglot
;;(use-package eglot-jl
;;  :defer t
;;  :hook ((julia-ts-mode . eglot-jl-init)
;;	 (julia-ts-mode . eglot-ensure))
;;  )


(use-package lsp-julia
  :ensure t
  ;;:load-path "~/.k8x1d-emacs.d/manual/lsp-julia" ;; guix version is read-only...
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
  (setq lsp-julia-command "julia")
  (add-to-list 'lsp-language-id-configuration
	       '(julia-ts-mode . "julia"))

  ;;  ;; AOT config
  ;; (setq lsp-julia-package-dir nil)
  ;; (setq lsp-julia-flags `("-J/home/k8x1d/.cache/emacs/languageserver.so"))

  ;; Add support over TRAMP
  ;; Adapted from https://github.com/gdkrmr/lsp-julia/issues/49
  ;; Don't work for now, but is a step in the right direction
  (defun lsp-julia--rls-command-remote ()
    "The command to lauch the Julia Language Server."
    `(,lsp-julia-command
      ,@lsp-julia-flags
      ,(concat "-e "
               "'"
               "import Pkg; Pkg.instantiate(); "
               "using InteractiveUtils, Sockets, SymbolServer, LanguageServer; "
               "Union{Int64, String}(x::String) = x; "
               "server = LanguageServer.LanguageServerInstance("
               "stdin, stdout, "
               (lsp-julia--get-root-remote) ", "
               (lsp-julia--get-depot-path) ", "
               "nothing, "
               (lsp-julia--symbol-server-store-path-to-jl-no-expand) "); "
               "run(server);"
               "'")))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection 'lsp-julia--rls-command-remote)
                    :major-modes '(julia-ts-mode julia-mode)
                    :server-id 'julia-ls-remote
                    :remote? t))

  )



(provide 'k8x1d-julia)
;;; k8x1d-julia.el ends here
