;; -*- lexical-binding: t -*-



(setq-default mode-line-format
	      '(
		;; Left modules
		(:eval evil-mode-line-tag)
		"%e"
		;; mode-line-front-space
		""
		mode-line-mule-info
		mode-line-client
		mode-line-modified
		mode-line-remote
		mode-line-window-dedicated
		 
		project-mode-line-format
		mode-line-frame-identification
		mode-line-buffer-identification
		"   "
		mode-line-position

		;; Right modules
		mode-line-format-right-align
		(vc-mode vc-mode)
		"  "
		;; mode-line-modes
		;; (:eval (format "%s %s" (nerd-icons-icon-for-buffer) (format-mode-line mode-name)))
		(:eval (format "%s" (format-mode-line mode-name)))
		"  "
		;; mode-line-misc-info ;; superflous
		mode-line-end-spaces)
	      )

(provide 'modeline-module)
