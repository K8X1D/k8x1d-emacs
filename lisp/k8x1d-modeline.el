
;; Sources:
;; https://occasionallycogent.com/custom_emacs_modeline/index.html

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  ;; ((after-init . doom-modeline-mode)
  ;; 	 (doom-modeline-mode . display-battery-mode)
  ;; 	 (doom-modeline-mode . display-time-mode))

  :config
  ;; Add wanted information
  (setq doom-modeline-minor-modes t) ;; for minions
  (setq doom-modeline-enable-word-count t)
  ;; Clean-up modeline
  (setq doom-modeline-buffer-state-icon nil)
  (setq doom-modeline-major-mode-icon nil)
  ;;(setq doom-modeline-icon nil)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-file-name-style 'file-name)
  ;; ;; Custom modal indicator for evil, Under test
  ;; (setq doom-modeline-modal-icon nil)
  ;; Define your custom modeline
  ;; barebone version
  (doom-modeline-def-modeline 'k8x1d-modeline
    ;; Left side
    '(modals
      buffer-info
      vcs
      buffer-position
      selection-info
      compilation)
    ;; Right side
    '(battery
      time
      process
      misc-info
      lsp checker
      minor-modes
      major-mode))

;;(doom-modeline-def-modeline 'main
;;  '(bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
;;  '(compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker time))



  ;; Set default mode-line
  (add-hook 'doom-modeline-mode-hook
 	    (lambda ()
 	      (doom-modeline-set-modeline 'k8x1d-modeline 'default)) )

  ;; set particulat font for modeline
 ;; (setq doom-modeline-height 1) ; optional
  (if (facep 'mode-line-active)
      (set-face-attribute 'mode-line-active nil :family "Hack" :height 120) ; For 29+
    (set-face-attribute 'mode-line nil :family "Hack" :height 120))
  (set-face-attribute 'mode-line-inactive nil :family "Hack" :height 120)

  )


;;(use-package telephone-line
;;  :hook (after-init . telephone-line-mode)
;;  :config
;;  (setq telephone-line-lhs
;;	'((evil   . (telephone-line-evil-tag-segment))
;;	  (accent . (telephone-line-vc-segment
;;		     telephone-line-erc-modified-channels-segment
;;		     telephone-line-process-segment))
;;	  (nil    . (telephone-line-minor-mode-segment
;;		     telephone-line-buffer-segment))))
;;  (setq telephone-line-rhs
;;	'((nil    . (telephone-line-misc-info-segment))
;;	  (accent . (telephone-line-major-mode-segment))
;;	  (evil   . (telephone-line-airline-position-segment))))
;;  )


;; Custom modeline
;; Inspired by https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
(use-package emacs
  :init
  (defun simple-mode-line-render (left right)
    "Return a string of `window-width' length.
Containing LEFT, and RIGHT aligned respectively."
    (let ((available-width
	   (- (window-total-width)
	      (+ (length (format-mode-line left))
		 (length (format-mode-line right))))))
      (append left
	      (list (format (format "%%%ds" available-width) ""))
	      right)))
  :config
  (setq-default
   mode-line-format
   '((:eval
      (simple-mode-line-render
       ;; Left.
       (quote ("%e "
	       evil-mode-line-tag
	       " "
	       mode-line-buffer-identification
	       (vc-mode vc-mode)))
       ;; Right.
       (quote (
	       " [%l:%c]"
	       mode-line-frame-identification
	       mode-line-misc-info
	       mode-line-modes
	       ))))))
  )

(use-package minions-mode
  :hook (after-init . minions-mode)
  ;; :hook (doom-modeline-mode . minions-mode)
  ;; :hook (telephone-line-mode . minions-mode)
  :init
  ;;(setq minions-mode-line-lighter "minor-modes")
  (setq minions-mode-line-lighter "...")
  )

(use-package hide-mode-line
  :hook
  ((vterm-mode . hide-mode-line-mode)
   (dired-sidebar-mode . hide-mode-line-mode)
   (inferior-ess-r-mode . hide-mode-line-mode)
   (org-capture-mode . hide-mode-line-mode)
   (compilation-mode . hide-mode-line-mode)
   (geiser-repl-mode . hide-mode-line-mode)
   (inferior-python-mode . hide-mode-line-mode)
   (julia-vterm-repl-mode . hide-mode-line-mode)
   (special-mode . hide-mode-line-mode)
   (pdf-view-mode . hide-mode-line-mode))
  )

(provide 'k8x1d-modeline)
