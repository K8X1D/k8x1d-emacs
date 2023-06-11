
;; Sources:
;; https://occasionallycogent.com/custom_emacs_modeline/index.html

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  ;; Add wanted information
  (setq doom-modeline-minor-modes t) ;; for minions
  (setq doom-modeline-enable-word-count t)
  ;; Clean-up modeline
  ;; (setq doom-modeline-buffer-state-icon nil)
  ;; (setq doom-modeline-major-mode-icon nil)
  ;;(setq doom-modeline-icon nil)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-file-name-style 'file-name)
  ;; ;; Custom modal indicator for evil, Under test
  ;; (setq doom-modeline-modal-icon nil)
 ;; (setq evil-normal-state-tag "NORMAL"
 ;;	evil-emacs-state-tag "EMACS"
 ;;	evil-insert-state-tag "INSERT"
 ;;	evil-motion-state-tag "MOTION"
 ;;	evil-visual-state-tag "VISUAL"
 ;;	evil-operator-state-tag "OPERATOR")
 ;; ;; Define your custom modeline
 ;; ;; barebone version
 ;; (doom-modeline-def-modeline 'k8x1d-modeline
 ;;   ;; Left side
 ;;   '(modals
 ;;     buffer-info
 ;;     vcs
 ;;     compilation)
 ;;   ;; Right side
 ;;   '(lsp checker
 ;;     minor-modes
 ;;     major-mode))

 ;; ;; Set default mode-line
 ;; (add-hook 'doom-modeline-mode-hook
 ;;	    (lambda ()
 ;;	      (doom-modeline-set-modeline 'k8x1d-modeline 'default)))
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
   (julia-vterm-repl-mode . hide-mode-line-mode))
  )



;;(use-package lambda-line
;;  :straight (:type git :host github :repo "lambda-emacs/lambda-line") 
;;  :custom
;;  (lambda-line-icon-time t) ;; requires ClockFace font (see below)
;;  (lambda-line-clockface-update-fontset "ClockFaceRect") ;; set clock icon
;;  (lambda-line-position 'bottom) ;; Set position of status-line 
;;  (lambda-line-abbrev t) ;; abbreviate major modes
;;  (lambda-line-hspace "  ")  ;; add some cushion
;;  (lambda-line-prefix t) ;; use a prefix symbol
;;  (lambda-line-prefix-padding nil) ;; no extra space for prefix 
;;  (lambda-line-status-invert nil)  ;; no invert colors
;;  (lambda-line-gui-ro-symbol  " ⨂") ;; symbols
;;  (lambda-line-gui-mod-symbol " ⬤") 
;;  (lambda-line-gui-rw-symbol  " ◯") 
;;  (lambda-line-space-top +.50)  ;; padding on top and bottom of line
;;  (lambda-line-space-bottom -.50)
;;  (lambda-line-symbol-position 0.1) ;; adjust the vertical placement of symbol
;;  :config
;;  ;; activate lambda-line 
;;
;;
;;  (lambda-line-mode) 
;;  ;; set divider line in footer
;;  (when (eq lambda-line-position 'top)
;;    (setq-default mode-line-format (list "%_"))
;;    (setq mode-line-format (list "%_"))))

(provide 'k8x1d-modeline)
