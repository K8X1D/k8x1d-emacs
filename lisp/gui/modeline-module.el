
;; Modeline definition
(use-package emacs
  :init
  (defun get-workspace-name ()
    (let* ((explicit-name (alist-get 'explicit-name (tab-bar--current-tab)))
	   (tab-name (alist-get 'name (tab-bar--current-tab))))
      (if explicit-name tab-name ""))
    )
  :after evil
  :config
  (setq evil-mode-line-format '(after . mode-line-front-space))
  (setq evil-mc-mode-line-prefix "󰗧")
  (setq-default mode-line-format
		'(
		  ;; Left module
		  " "
		  mode-line-front-space
		  evil-mode-line-tag 
		  (:eval (get-workspace-name))
		  ;;(:propertize
		  ;; ("" mode-line-mule-info mode-line-client mode-line-modified
		  ;;  mode-line-remote)
		  ;; display (min-width (5.0)))
		  " "
		  mode-line-modified
		  mode-line-frame-identification
		  mode-line-buffer-identification
		  "   "
		  mode-line-position
		  "  "
		  mode-line-end-spaces
		  evil-mc-mode-line
		  "  "
		  (:eval (anzu--update-mode-line))
		  ;; Right modules
		  mode-line-format-right-align
		  mode-line-misc-info 
		  minions-mode-line-modes
		  (eglot--managed-mode ("[" eglot--mode-line-format "]"))
		  (lsp-bridge-mode ("[" lsp-bridge--mode-line-format "]"))
		  (vc-mode ("[" vc-mode " ]")) 
		  ;; (vc-mode ("[" (:eval (string-trim vc-mode)) "]")) 
		  )
		)
  )

;; hide minor modes
(use-package minions
  :hook (after-init . minions-mode)
  :init
  (setq minions-mode-line-lighter "...")
  (setq minions-mode-line-delimiters '("[" . "]"))
  )


(use-package hide-mode-line
  :hook ((eat-mode . hide-mode-line-mode)
	 (dired-sidebar-mode . hide-mode-line-mode)
	 (special-mode . hide-mode-line-mode)))

(provide 'modeline-module)
