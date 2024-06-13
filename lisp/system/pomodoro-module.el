(use-package pomm
  :general
  (k8x1d/leader-keys
    "oP" '(pomm :which-key "Pommodoro")
    )
  :hook (after-init . pomm-mode-line-mode)
  :config
  (setq pomm-work-period 50)
  (setq pomm-short-break-period 10)
  (require 'nerd-icons)
  (defun pomm-format-mode-line ()
    "Format a string for the mode line."
    (let ((current-status (alist-get 'status pomm--state)))
      (if (or (eq current-status 'stopped) (not (alist-get 'current pomm--state)))
	  ""
	(let* ((current-kind (alist-get 'kind (alist-get 'current pomm--state)))
	       (time-remaining (pomm--get-time-remaning)))
	  (format "%s : %s (%s) "
		  (concat
		  (cond
		   ((string= current-kind "work") "")
		   ((string= current-kind "short-break") "")
		   (t ""))
		   (if (eq current-status 'paused)
		       ":paused"
		     ""))
		  (format-seconds pomm-remaining-time-format time-remaining)
		  (symbol-name current-kind)
		  )))))
  :commands (pomm pomm-third-time))

(provide 'pomodoro-module)
