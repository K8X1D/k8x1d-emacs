(use-package emacs
  :after (nerd-icons anzu doom-themes)
  :init
(require 'doom-themes)
  (require 'nerd-icons)
  (require 'anzu)
  (defun k8x1d-workspace-module ()
    (if (not tab-bar-show)
	(let* ((explicit-name (alist-get 'explicit-name (tab-bar--current-tab)))
	       (tab-index (tab-bar--current-tab-index))
	       (tab-name (alist-get 'name (tab-bar--current-tab))))
	  ;; (if explicit-name tab-name ""))
	  (if explicit-name (propertize  (format " %s " tab-name) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))
	    (propertize  (format " %s " tab-index) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))))
      ""
      )
    )
  ;; from https://emacs.stackexchange.com/questions/10955/customize-vc-mode-appearance-in-mode-line
  (defun k8x1d-git-infos-module ()
    (when (stringp vc-mode)
      (let* ((branch (replace-regexp-in-string "^ Git:" "" vc-mode))
	     (foreground-color (if (string-match "ma\\(in\\|ster\\)" branch) 'green 'orange)))
	;; (text-color 'green))
	(propertize  (format " %s " branch)
		     'face `(:background ,(doom-color 'grey) :foreground ,(doom-color foreground-color))
		     )
	)
      )
    )

  (defsubst k8x1d-evil-module ()
    "The current evil state. Requires `evil-mode' to be enabled."
    (when (bound-and-true-p evil-local-mode)
      (let* ((left-separator " ")
	     (right-separator " ")
	     (default-background-color (doom-color 'grey))
	     (default-foreground-color (doom-color 'green)))
	(cond
	 ;; ((evil-normal-state-p) (propertize  (format "%s" "🅝") 'face `(:foreground ,(doom-color 'green))))
	 ((evil-normal-state-p) (propertize (format "%s%s%s" left-separator "NORMAL" right-separator) 'face `(:foreground ,(doom-color 'green) :background ,default-background-color :weight bold)))
	 ;; ((evil-emacs-state-p) (propertize  (format "%s" "🅔") 'face `(:foreground ,(doom-color 'magenta))))
	 ((evil-emacs-state-p) (propertize (format "%s%s%s" left-separator "EMACS" right-separator) 'face `(:foreground ,(doom-color 'magenta) :background ,default-background-color :weight bold)))
	 ;; ((evil-insert-state-p) (propertize  (format "%s" "🅘") 'face `(:foreground ,(doom-color 'yellow))))
	 ((evil-insert-state-p) (propertize (format "%s%s%s" left-separator "INSERT" right-separator) 'face `(:foreground ,(doom-color 'yellow) :background ,default-background-color :weight bold)))
	 ;; ((evil-motion-state-p) "🅜")
	 ((evil-motion-state-p) (propertize (format "%s%s%s" left-separator "MOTION" right-separator) 'face `(:foreground ,(doom-color 'blue) :background ,default-background-color :weight bold)))
	 ;; ((evil-visual-state-p) (propertize  (format "%s" "🅥") 'face `(:foreground ,(doom-color 'red))))
	 ((evil-visual-state-p) (propertize (format "%s%s%s" left-separator "VISUAL" right-separator) 'face `(:foreground ,(doom-color 'red) :background ,default-background-color :weight bold)))
	 ;; ((evil-operator-state-p) "🅞")
	 ((evil-operator-state-p) (propertize (format "%s%s%s" left-separator "OPERATOR" right-separator) 'face `(:foreground ,(doom-color 'grey) :background ,default-background-color :weight bold)))
	 ;; ((evil-replace-state-p) "🅡")
	 ((evil-replace-state-p) (propertize (format "%s%s%s" left-separator "REPLACE" right-separator) 'face `(:foreground ,(doom-color 'purple) :background ,default-background-color :weight bold)))
	 ;; (t (propertize  (format "%s" "🅝") 'face `(:foreground ,(doom-color 'green))))
	 (t (propertize (format "%s%s%s" left-separator "N" right-separator) 'face `(:foreground ,default-foreground-color :background ,default-background-color :weight bold)))
	 ))
      ))

  (defun k8x1d-modeline-modes-module ()
    (if (display-graphic-p)
	(let ((icon (nerd-icons-icon-for-buffer)))
	  (propertize (format " %s  "
			      (if (or (null icon) (symbolp icon))
				  (nerd-icons-faicon "nf-fa-file_o" nil nil
						     :face 'nerd-icons-dsilver)
				icon)
			      )
		      'face `(:foreground ,(doom-color 'green) :background ,(doom-color 'bg))
	  'help-echo (format "Major-mode: %s" (format-mode-line mode-name)))
	  )
      ;; (propertize (format " %s " major-mode) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))
      (propertize (format " %s  " (format-mode-line mode-name)) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))
      )
    )
  


  (defun k8x1d-buffer-name-module ()
    (if (buffer-modified-p)
	(propertize (format " %s " (substring-no-properties (format-mode-line mode-line-buffer-identification))) 'face `(:foreground ,(doom-color 'fg) :background ,(doom-color 'bg)))
      (propertize (format " %s " (substring-no-properties (format-mode-line mode-line-buffer-identification))) 'face `(:foreground ,(doom-color 'fg-alt) :background ,(doom-color 'bg)))
      )
    )

  (defun k8x1d-buffer-status-module ()
    (if (buffer-modified-p)
	(propertize (format " %s " "*") 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'orange)))
      (propertize (format " %s " (substring-no-properties (format-mode-line mode-line-modified))) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'fg-alt)))
      )
    )



  (defun k8x1d-lsp-module ()
    ;; (propertize (format " %s " major-mode) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'green)))
    (when (bound-and-true-p eglot--managed-mode)
      (propertize " lsp " 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'grey)))
      )
    )

  (defun k8x1d-checker-module ()
    (when (bound-and-true-p flymake-mode)
      ;; (propertize (format " %s|%s " (format-mode-line (flymake--mode-line-counter :error))  (string-trim (format-mode-line (flymake--mode-line-counter :warning)))) 'face `(:foreground ,(doom-color 'bg) :background ,(doom-color 'yellow)))
      (let* ((errors (string-trim (format-mode-line (flymake--mode-line-counter :error))))
	     (warnings (string-trim (format-mode-line (flymake--mode-line-counter :warning))))
	     (notes (string-trim (format-mode-line (flymake--mode-line-counter :note))))
	     (error-p (if (string= errors "0") nil t))
	     (warning-p (if (string= warnings "0") nil t)))
	(propertize
	 (format "[%s:%s:%s]"
		 ;; (if error-p
		 (propertize (format "%s" errors) 'face `(:foreground ,(doom-color 'red) :background ,(doom-color 'bg)))
		 ;; "0")
		 ;; (if warning-p
		 (propertize (format "%s" warnings) 'face `(:foreground ,(doom-color 'yellow) :background ,(doom-color 'bg)))
		 ;; "0")
		 (propertize (format "%s" notes) 'face `(:foreground ,(doom-color 'green) :background ,(doom-color 'bg)))
		 )
	 'help-echo
	 (lambda (&rest _)
	    (concat
	     (format "%s known backends\n" (hash-table-count flymake--state))
	     (format "%s running\n" (length (flymake-running-backends)))
	     (format "%s disabled\n" (length (flymake-disabled-backends)))
	     "mouse-1: Display minor mode menu\n"
	     "mouse-2: Show help for minor mode"))
	 )
	)
      )
    )

  :config
  (setq evil-mode-line-format nil)
  (setq evil-mc-mode-line-prefix "󰗧")
  (setq-default mode-line-format
		'(
		  ;; Left module
		  ;; mode-line-front-space
		  ;; " "
		  (:eval (k8x1d-workspace-module))
		  ;; evil-mode-line-tag
		  (:eval (k8x1d-evil-module))
		  ;; (:eval (get-workspace-name))
		  ;;(:propertize
		  ;; ("" mode-line-mule-info mode-line-client mode-line-modified
		  ;;  mode-line-remote)
		  ;; display (min-width (5.0)))
		  ;; mode-line-modified
		  ;; mode-line-frame-identification
		  ;; mode-line-buffer-identification
		  (:eval (k8x1d-buffer-name-module))
		  ;; (:eval (k8x1d-buffer-status-module))
		  (:eval  (k8x1d-git-infos-module))
		  " "
		  mode-line-position
		  "  "
		  mode-line-end-spaces
		  evil-mc-mode-line
		  "  "
		  (:eval (anzu--update-mode-line))
		  ;; Right modules
		  mode-line-format-right-align
		  mode-line-misc-info
		  ;; minions-mode-line-modes
		  ;; flymake-mode-line-format
		  (:eval (k8x1d-checker-module))
		  (:eval (k8x1d-lsp-module))
		  (:eval (k8x1d-modeline-modes-module))
		  ;; " "
		  )
		)
  )

;; hide minor modes
(use-package minions
  :hook (after-init . minions-mode)
  :init
  (setq minions-mode-line-lighter "...")
  (setq minions-mode-line-delimiters '("" . ""))
  )


(use-package hide-mode-line
  :hook ((eat-mode . hide-mode-line-mode)
	 (dired-sidebar-mode . hide-mode-line-mode)
	 (vterm-mode . hide-mode-line-mode)
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
	  ;; (format "[Time left: %.2f years]" (memento-mori--life-expectency))))
	  (format "[memento mori: %.2f years]" (memento-mori--life-expectency))))
  (setq memento-mori-death-date "2067-06-22")
  :hook (after-init . memento-mori-mode)
  )

(provide 'modeline-module)
