(use-package lsp-mode
  :diminish
  :init
  (setenv "LSP_USE_PLISTS" "true") ;; Use plists for deserialization
  (setq lsp-use-plists t) ;; Use plists for deserialization
  (setq lsp-keymap-prefix "C-c l")
  :config
  ;; Clean-up ui
  (setq lsp-headerline-breadcrumb-enable nil)
  ;; Checker compatibility 
  ;; (setq lsp-diagnostics-provider :none)

  ;; Optimizations, see https://emacs-lsp.github.io/lsp-mode/page/performance/#performance
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
  :commands lsp-ui-mode
  )


;; Better performance for lsp-mode via lsp-booster
(use-package lsp-mode
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
