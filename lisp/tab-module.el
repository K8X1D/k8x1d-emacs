;; -*- lexical-binding: t -*-


(use-package tab-bar
  :general
  (k8x1d/leader-keys
    "t" '(:keymap tab-prefix-map
		  :package evil
		  :which-key "Tabs")
   )
  :init
  ;; TODO: implement string triming
  (defvar k8x1d/org-clock-module-max-length 60)
(defun k8x1d/org-clock-get-clock-string ()
  "Form a clock-string, that will be shown in the mode line.
If an effort estimate was defined for the current item, use
01:30/01:50 format (clocked/estimated).
If not, show simply the clocked time like 01:50."
  (let ((clocked-time (org-clock-get-clocked-time)))
    (if org-clock-effort
	(let* ((effort-in-minutes (org-duration-to-minutes org-clock-effort))
	       (work-done-str
		(propertize (org-duration-from-minutes clocked-time)
			    'face
			    (if (and org-clock-task-overrun
				     (not org-clock-task-overrun-text))
				'org-mode-line-clock-overrun
			      'org-mode-line-clock)))
	       (effort-str (org-duration-from-minutes effort-in-minutes)))
	  (format (propertize "%s [%s/%s]" 'face 'tab-bar)
		  org-clock-heading work-done-str effort-str))
      (format (propertize "%s [%s]" 'face 'tab-bar)
	      org-clock-heading
	      (org-duration-from-minutes clocked-time)
	      ))))

(defun tab-bar-org-clock-module ()
  (require 'org-clock)
  (when (org-clocking-p)
    (let* ((prefix "Task:")
	   (clocked-task (k8x1d/org-clock-get-clock-string)))
      (if (> (string-width clocked-task) k8x1d/org-clock-module-max-length)
	  (format "%s %s)... " prefix (string-limit clocked-task k8x1d/org-clock-module-max-length))
	(format "%s %s" prefix clocked-task)
	)
      )
    ))

  :hook
  (after-init . tab-bar-mode)
  :config
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-format-align-right tab-bar-org-clock-module))
  (setq tab-bar-select-tab-modifiers '(meta))

  ;; Name adjustment
  (setq tab-bar-auto-width t)
  (setq tab-bar-auto-width-max '((150) 50))
  )








(provide 'tab-module)
