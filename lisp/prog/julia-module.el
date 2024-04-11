;; Syntax highlight
(use-package julia-ts-mode
  :mode "\\.jl$")

;; REPL
(use-package julia-repl
  :if (and (string= k8x1d/ide "minimal") (string= k8x1d/terminal "eat")) 
  :hook (julia-ts-mode . julia-repl-mode)
  :config
  ;; Term
  (julia-repl-set-terminal-backend 'eat)
  ;; Remote
  (setq julia-repl-executable-records
	'((default "julia")                  ; in the executable path
	  (remote "ssh -t kkaiser@130.104.60.82 /usr/bin/julia")))
  (defun remotejl ()
    (interactive)
    (make-term "julia-ssh" "ssh" nil "-t" "kkaiser@130.104.60.82" "/bin/julia")
    (funcall-interactively 'julia-repl-prompt-set-inferior-buffer-name-suffix '(ssh))
    )
  )


;; REPL
(use-package julia-vterm
  :if (and (string= k8x1d/ide "minimal") (string= k8x1d/terminal "vterm")) 
  :init
  (defun k8x1d/julia ()
    (interactive)
    (require 'julia-vterm)
    (julia-vterm-repl)
    )
  :bind ("C-c o r j" . k8x1d/julia)
  :hook (julia-ts-mode . julia-vterm-mode)
  :config
  ;; Clean keybindings
  (require 'bind-key)
  (unbind-key "C-c C-i" julia-vterm-mode-map) 
  )

;; Notebook support
(use-package ob-julia-vterm
  :if (and (string= k8x1d/ide "minimal") (string= k8x1d/terminal "vterm")) 
  :init
  (with-eval-after-load 'org
    (add-to-list 'org-babel-load-languages '(julia-vterm . t))
    (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
    (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
    (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm))
  )



;; SLIME-like dev environment
(use-package julia-snail
  :if (string= k8x1d/ide "full") 
  :bind(
	("K" . julia-snail-doc-lookup) 
	([remap evil-jump-out-args]  . julia-snail-doc-lookup) 
	:map julia-snail-mode-map
	("C-c C-," . julia-snail)
	("C-c C-l" . julia-snail-send-line)
	("C-c C-r" . julia-snail-send-region)
	("C-c C-b" . julia-snail-send-buffer-file)
	)
  :hook
  (julia-ts-mode . julia-snail-mode)
  :custom 
  (julia-snail-terminal-type :eat)
  (julia-snail-extensions '(ob-julia))

  :config
  (customize-set-variable 'split-height-threshold 15)
  (add-to-list 'display-buffer-alist
	       '("\\*julia" (display-buffer-reuse-window display-buffer-same-window)))
  (setq julia-snail-repl-display-eval-results t) ;; print the result in REPL
  (setq julia-snail-popup-display-eval-results :command) ;; only show result in REPL
  ;; Multimedia
  (setq julia-snail-multimedia-enable t)
  (setq julia-snail-multimedia-buffer-autoswitch t)
  )

;;;; LSP
;;;; Remote support not working
;;(use-package eglot-jl
;;  :if (string= k8x1d/lsp-backend "eglot")
;;  :ensure t
;;  :init (setq eglot-connect-timeout 180) ;; prevent eglot timeout
;;  :hook ((julia-ts-mode . eglot-jl-init)
;;         (julia-ts-mode . eglot-ensure))
;;  :config
;;;; Remote support
;;  (connection-local-set-profile-variables
;;   'remote-machine-name-eglot-variables
;;   '((eglot-jl-base . "/home/kkaiser/eglot-jl/")
;;     (eglot-jl-julia-command . "/usr/bin/julia")
;;     (eglot-jl-language-server-project . "/home/kkaiser/eglot-jl/")))
;;
;;  (connection-local-set-profiles
;;   '(:application tramp :machine "kkaiser@130.104.60.82")
;;   'remote-machine-name-eglot-variables)
;;  )

(use-package eglot
  :hook (julia-ts-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
	       ;; From nvim-lspconfig, https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#julials
    ;; 	       '(julia-ts-mode . (
    ;; 				  "julia"
    ;; 				  "--startup-file=no"
    ;; 				  "--history-file=no"
    ;; 				  "-e"
    ;; 				  "# Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
    ;; # with the regular load path as a fallback
    ;;   ls_install_path = joinpath(
    ;; 				 get(DEPOT_PATH, 1, joinpath(homedir(), \".julia\")),
    ;; 				 \"environments\", \"nvim-lspconfig\"
    ;; 				 )
    ;; 				  pushfirst!(LOAD_PATH, ls_install_path)
    ;; 				  using LanguageServer
    ;; 				  popfirst!(LOAD_PATH)
    ;; 				  depot_path = get(ENV, \"JULIA_DEPOT_PATH\", \"\")
    ;; 				  project_path = let
    ;; 				  dirname(something(
    ;; 						    ## 1. Finds an explicitly set project (JULIA_PROJECT)
    ;; 						    Base.load_path_expand((
    ;; 									   p = get(ENV, \"JULIA_PROJECT\", nothing);
    ;; 									   p === nothing ? nothing : isempty(p) ? nothing : p
    ;;         )),
    ;;         ## 2. Look for a Project.toml file in the current working directory,
    ;;         ##    or parent directories, with $HOME as an upper boundary
    ;;         Base.current_project(),
    ;;         ## 3. First entry in the load path
    ;;         get(Base.load_path(), 1, nothing),
    ;;         ## 4. Fallback to default global environment,
    ;;         ##    this is more or less unreachable
    ;;         Base.load_path_expand(\"@v#.#\"),
    ;;     ))
    ;; end
    ;; @info \"Running language server\" VERSION pwd() project_path depot_path
    ;; server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    ;; server.runlinter = true
    ;; run(server)"
    ;; 				  ))

	       '(julia-ts-mode . (
				  "julia"
				  "--startup-file=no"
				  "--history-file=no"
				  ;; "--project=/home/k8x1d/.julia/environments/emacs"
				  "--project=/home/k8x1d/.julia/environments/nvim-lspconfig"
				  "-e"
				  "using LanguageServer; runserver()"
	       ))
	       )
  )
  
;; Documentation
(use-package eldoc
  :if (not (string=  k8x1d/lsp-backend "lsp-bridge"))
  :hook (julia-ts-mode . eldoc-mode))

(provide 'julia-module)
