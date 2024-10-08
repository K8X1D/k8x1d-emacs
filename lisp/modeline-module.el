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
		 
		mode-line-frame-identification
		mode-line-buffer-identification
		"   "
		mode-line-position

		;; Right modules
		mode-line-format-right-align
		(project-mode-line project-mode-line-format)
		(vc-mode vc-mode)
		"  "
		mode-line-modes
		;; mode-line-misc-info ;; superflous
		mode-line-end-spaces)
	      )

(provide 'modeline-module)
