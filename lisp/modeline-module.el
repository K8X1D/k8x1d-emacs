;;; package --- Summary  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code: 



(if (string= k8x1d/checker "flycheck")
    (defun k8x1d/checker-mode-line-module () 
      (require 'flycheck)
      (when flycheck-mode
	(format "[%s] " (substring (flycheck-mode-line-status-text) (+ (string-width flycheck-mode-line-prefix) 2)))
	)
      )
  )

(if (string= k8x1d/checker "flymake")
    (defun k8x1d/checker-mode-line-module () 
      (require 'flymake)
      (when (flymake-running-backends)
	'("["
	  flymake-mode-line-error-counter
	  flymake-mode-line-warning-counter
	  flymake-mode-line-note-counter "] ")	)
      )
  )

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
		(vc-mode vc-mode)
		mode-line-buffer-identification
		"   "
		mode-line-position

		;; Right modules
		mode-line-format-right-align
		"  "
		;; mode-line-modes
		;; (:eval (format "%s %s" (nerd-icons-icon-for-buffer) (format-mode-line mode-name)))

		;; flycheck-mode-line
		;; flymake-mode-line-counter-format
		;; flymake-mode-line-error-counter
		;; flymake-mode-line-warning-counter
		;; flymake-mode-line-note-counter
		;; (k8x1d/checker-mode-line-module)
		(:eval (k8x1d/checker-mode-line-module))
		(:eval (format "%s" (format-mode-line mode-name)))
		"  "
		;; mode-line-misc-info ;; superflous
		mode-line-end-spaces)
	      )

(provide 'modeline-module)
;;; modeline-module.el ends here
