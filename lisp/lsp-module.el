;; -*- lexical-binding: t; -*-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; Eglot    ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package eglot
  :if (string= k8x1d/lsp "eglot")
  :general
  (k8x1d/local-leader-keys
    :keymaps 'eglot-mode-map
   "a" '(eglot-code-actions :which-key "Code action")
    )
  :commands (eglot
	     eglot-rename
	     eglot-ensure
	     eglot-rename
	     eglot-format
	     eglot-format-buffer)
  :custom
  (eglot-report-progress nil)  ; Prevent minibuffer spam
  :bind
  ("C-c l a" . eglot-code-actions)
  ("C-c l s" . eglot-shutdown)
  ("C-c l S" . eglot-shutdown-all)
  ("C-c l r" . eglot-reconnect)
  ("C-c l f" . eglot-format)
  ("C-c l F" . eglot-format-buffer)
  :config
  ;; Optimizations
  (fset #'jsonrpc--log-event #'ignore)
  (setq jsonrpc-event-hook nil))

;; Better performance for eglot
(use-package eglot-booster
  :if (string= k8x1d/lsp "eglot")
  :hook
  (prog-mode . eglot-booster-mode)
  :config
  (setq eglot-booster-no-remote-boost t)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; Lsp-bridge ;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-bridge
  :ensure nil
  :load-path "code/lsp-bridge"
  :if (string= k8x1d/lsp "lsp-bridge")
  :hook
  (prog-mode . lsp-bridge-mode)
  :bind
  (:map acm-mode-map
	("C-k" . acm-select-prev)
	([remap evil-insert-digraph] . acm-select-prev)
	("C-j" . acm-select-next)
	)
  :config
  (setq lsp-bridge-mode-lighter " lsp")
  (setq lsp-bridge-tex-lsp-server "ltex-ls")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; Lsp-mode ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :if (string= k8x1d/lsp "lsp-mode")
  :general
  (k8x1d/local-leader-keys
   :keymaps 'lsp-mode-map
   "a" '(lsp-execute-code-action :which-key "Code action")
    )
  :diminish
  :custom
  (lsp-ui-sideline-enable nil)
  :bind
  (:map evil-motion-state-map
	([remap evil-lookup] . lsp-ui-doc-toggle))
  :init
  (setenv "LSP_USE_PLISTS" "true") ;; Use plists for deserialization
  (setq lsp-use-plists t) ;; Use plists for deserialization
  (setq lsp-keymap-prefix "C-c l")
  ;; (setq lsp-keymap-prefix "SPC m l")
  :config
  ;; Clean-up ui
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-ui-sideline-enable nil)
  ;; Checker compatibility 
  ;; (setq lsp-diagnostics-provider :none)

  ;; Optimizations,
  ;; - see https://emacs-lsp.github.io/lsp-mode/page/performance/#performance
  ;; - see https://github.com/yyoncho/lsp-mode/tree/perf-docs#performance
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; Increase the amount of data which Emacs reads from the process to 1mb 
  (setq lsp-log-io nil) ; if set to true can cause a performance hit

  ;; Turn off clients 
  (setq lsp-disabled-clients '(semgrep-ls))

  ;; others
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
        lsp-pyls-plugins-flake8-enabled t)
  :hook
  (python-mode . lsp)
  (ess-r-mode . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  )

(use-package lsp-ui
  :custom
  (lsp-ui-sideline-enable nil)
  :init
  (setq lsp-ui-sideline-enable nil) ;; manually set through lsp-ui-sideline-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-show-hover t
	lsp-ui-sideline-delay 0.5
	lsp-ui-doc-delay 5
	lsp-ui-sideline-ignore-duplicates t
	lsp-ui-doc-position 'bottom
	lsp-ui-doc-alignment 'frame
	lsp-ui-doc-header nil
	lsp-ui-doc-include-signature t
	lsp-ui-doc-use-childframe t)
  )


;; Better performance for lsp-mode via lsp-booster
(use-package lsp-mode
  :if (string= k8x1d/lsp "lsp-mode")
  :init
  ;; Set-up lsp-booster
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
	 (when (byte-code-function-p bytecode)
	   (funcall bytecode))))
     (apply old-fn args)))
  (advice-add (if (progn (require 'json)
			 (fboundp 'json-parse-buffer))
		  'json-parse-buffer
		'json-read)
	      :around
	      #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
              (setcar orig-result command-from-exec-path))
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
	orig-result)))
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
  )

(provide 'lsp-module)
