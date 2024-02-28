

(setq mode-line-format
	      '(
		"%e"
		;; Left module
		evil-mode-line-tag 
		mode-line-front-space
		(:propertize
		 ("" mode-line-mule-info mode-line-client mode-line-modified
		  mode-line-remote)
		 display (min-width (5.0)))
		mode-line-frame-identification mode-line-buffer-identification "   "
		mode-line-position  "  "
		mode-line-end-spaces
		;; Right modules
		mode-line-format-right-align
		minions-mode-line-modes
		mode-line-misc-info 
		(vc-mode vc-mode)
	      )
	      )




;; hide minor modes
(use-package minions
  :hook (after-init . minions-mode)
  :init
  (setq minions-mode-line-lighter "...")
  )

(provide 'modeline-module)
