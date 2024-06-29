;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package doom-modeline
  :hook ((after-init . doom-modeline-mode)
         (doom-modeline-mode . display-battery-mode)
         (doom-modeline-mode . display-time-mode)
         (doom-modeline-mode . (lambda ()
                                 (doom-modeline-set-modeline 'custom-modeline 'default)))
         )
  :config
  ;; fonts
  ;; (custom-set-faces
  ;;  '(mode-line ((t (:family "Iosevka Font Mono" :height 0.9))))
  ;;  '(mode-line-active ((t (:family "Iosevka Nerd Font Mono" :height 0.9)))) ; For 29+
  ;;  '(mode-line-inactive ((t (:family "Iosevka Nerd Font Mono" :height 0.9)))))
  (setq nerd-icons-font-family "Symbols Nerd Font Mono")

;; XXX
  (setq doom-modeline-height 25)
  (setq doom-modeline-minor-modes t)
  ;; Icons
  (setq doom-modeline-icon t)
  ;; Modal
  (setq doom-modeline-modal-icon t)
  (setq doom-modeline-modal-modern-icon t)
  ;; Buffer name
  (setq doom-modeline-buffer-name t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-buffer-file-name-style 'auto)
  (setq doom-modeline-buffer-state-icon nil)
  ;; VCS
  (setq doom-modeline-vcs-max-length 12)

  ;; LSP
  (setq doom-modeline-lsp t)
  (setq doom-modeline-lsp-icon t)
  ;; Checker
  (setq doom-modeline-checker-simple-format t)
  ;; Bar
  (setq doom-modeline-bar-width 3)
  ;; (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  ;; Encoding
  (setq doom-modeline-buffer-encoding t)
  (setq doom-modeline-percent-position nil)

  ;; Custom segement
  (doom-modeline-def-segment k8x1d-lsp
    "The LSP server state."
    (when doom-modeline-lsp
      (let ((icon (cond ((bound-and-true-p lsp-mode)
                         doom-modeline--lsp)
                        ((bound-and-true-p eglot--managed-mode)
                         doom-modeline--eglot)
                        ((bound-and-true-p citre-mode)
                         doom-modeline--tags))))
        (when icon
          (concat
           (doom-modeline-spc)
           (doom-modeline-display-icon icon)
           )))))



  (doom-modeline-def-segment k8x1d-buffer-info
    "Combined information about the current buffer.
      Including the current working directory, the file name, and its state (modified,
      read-only or non-existent)."
    (concat
     (doom-modeline--buffer-name))
    )

  (doom-modeline-def-segment k8x1d-major-mode
    "Icons for current major-mode."
    (concat
     (doom-modeline--buffer-mode-icon)
     ))

  ;; Obsolete
  (doom-modeline-def-segment k8x1d-vcs
    "Displays the current branch, colored based on its state."
    (when-let ((icon doom-modeline--vcs-icon)
               (text doom-modeline--vcs-text))
      (concat
       (doom-modeline-spc)
       (propertize (concat
                    (doom-modeline-display-icon icon)
                    (doom-modeline-vspc)
                    ;;(doom-modeline-display-text text)
                    )
                   'mouse-face 'doom-modeline-highlight
                   'help-echo (get-text-property 1 'help-echo vc-mode)
                   'local-map (get-text-property 1 'local-map vc-mode))
       (doom-modeline-spc))))


  ;; (doom-modeline-def-segment k8x1d-clock
  ;;   "Icons for current major-mode."
  ;;   (concat
  ;;    (k8x1d/org-clock-format)
  ;;    ))

  ;; Custom doom-modeline
  (doom-modeline-def-modeline 'custom-modeline
    ;;'(bar modals " " buffer-position selection-info matches " "  buffer-info " " lsp checker vcs " " follow remote-host word-count parrot compilation)
    ;;'(misc-info " " battery time)
    ;; '(modals workspace-name k8x1d-buffer-info vcs  buffer-position selection-info matches follow word-count parrot buffer-encoding remote-host " " compilation)
    ;; '(time battery k8x1d-lsp " " check k8x1d-major-mode " ")
    '(modals workspace-name buffer-info vcs lsp " " check buffer-position selection-info matches follow word-count parrot buffer-encoding remote-host " " compilation)
    '(time battery)
    )

  ;; (eldoc bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
  ;; '(compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker time))


  ;; Display R process in modeline
  (add-hook 'inferior-ess-mode-hook
            (lambda ()
              (add-to-list 'mode-line-process '(:eval (nth ess--busy-count ess-busy-strings)))))
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
	 (compilation-mode . hide-mode-line-mode)
	 ;; (special-mode . hide-mode-line-mode)
	 ))

;; TODO: reduce
(use-package memento-mori
  :init
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
  (setq memento-mori-display-in-modeline nil)
  (require 'doom-themes)
  (defvar memento-mori--modeline-info
    `(memento-mori-mode
      ((:propertize
	("󰚌 ")
	mouse-face mode-line-highlight
	`face (:foreground ,(doom-color 'fg))
	help-echo (format "%.2f years left" (memento-mori--life-expectency))

	)
       " "))
    "A mode line construct to be added to `global-mode-string'.
See `mode-line-format' for information about the format.  It should
append a space to the `memento-mori-string' which is considered best
practice for inclusion in `global-mode-string'.")
  (setq memento-mori-death-date "2067-06-22")
  :hook ((after-init . memento-mori-mode)
	 (memento-mori-mode . (lambda ()
				(add-to-list 'global-mode-string memento-mori--modeline-info))))
  )

(provide 'modeline-module-alt)
;;; modeline-module.el ends here
