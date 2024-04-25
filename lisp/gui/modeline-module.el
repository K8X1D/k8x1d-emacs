;; Modeline definition
(use-package emacs
  :init
  (defun get-workspace-name ()
    (let* ((explicit-name (alist-get 'explicit-name (tab-bar--current-tab)))
	   (tab-name (alist-get 'name (tab-bar--current-tab))))
      (if explicit-name tab-name ""))
    )
  ;; :after evil
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

(use-package memento-mori
  :config
  (defun memento-mori--assert-death-date ()
    "Ensure that `memento-mori-death-date' has been set."
    (when (or (null memento-mori-death-date)
	      (equal "" memento-mori-death-date))
      (error "Death date not set.  Try M-x customize-group memento-mori")))
  (defun memento-mori--death-time ()
    "Return your death time in `encode-time' format.
The death time is parsed from `memento-mori-death-date' using
`parse-time-string'.  An error is signaled if it is not valid."
    (memento-mori--assert-death-date)
    (let* ((decoded (parse-time-string
		     (if (stringp memento-mori-death-date)
			 memento-mori-death-date
		       "")))
	   (day (elt decoded 3))
	   (month (elt decoded 4))
	   (year (elt decoded 5)))
      (unless (and day month year)
	(error "Cannot parse death date %S" memento-mori-death-date))
      (encode-time 0 0 0 day month year)))
  (defun memento-mori--life-expectency ()
    "Return your age in years.
This is a floating point number based on `memento-mori-death-date'."
    (/ (truncate (float-time
		     (time-subtract (memento-mori--death-time) (current-time))))
	  (* 60 60 24 365.2425)))
  (defun memento-mori--update ()
    "Update `memento-mori-string' based on the current time."
    (setq memento-mori-string
	  (format "[Time left: %.2f years]" (memento-mori--life-expectency))))
	  ;; (format "[󰯈 : %.2f years]" (memento-mori--life-expectency))))
  (setq memento-mori-death-date "2067-06-22")
  :hook (after-init . memento-mori-mode)
  )

(provide 'modeline-module)
