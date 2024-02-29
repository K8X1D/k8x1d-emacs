
;; Modeline definition
(use-package emacs
  :after evil
  :config
  (setq evil-mode-line-format '(after . mode-line-front-space))
  (setq-default mode-line-format
		'(
		  ;; Left module
		  " "
		  mode-line-front-space
		  evil-mode-line-tag 
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
		  minions-mode-line-modes
		  mode-line-misc-info 
		  (vc-mode vc-mode)
		  )
		)
  )

;; hide minor modes
(use-package minions
  :hook (after-init . minions-mode)
  :init
  (setq minions-mode-line-lighter "...")
  )


(use-package hide-mode-line
  :hook ((eat-mode . hide-mode-line-mode)
	 (special-mode . hide-mode-line-mode)))

(provide 'modeline-module)
