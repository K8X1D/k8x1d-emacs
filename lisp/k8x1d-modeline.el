;;; package --- Summary

;;; Commentary:

;;; Code:





;; Sources:
;; https://occasionallycogent.com/custom_emacs_modeline/index.html

;; (use-package doom-modeline
;;   :hook (after-init . doom-modeline-mode)
;;   ;; ((after-init . doom-modeline-mode)
;;   ;; 	 (doom-modeline-mode . display-battery-mode)
;;   ;; 	 (doom-modeline-mode . display-time-mode))

;;   :config
;;   ;; Add wanted information
;;   (setq doom-modeline-minor-modes t) ;; for minions
;;   (setq doom-modeline-enable-word-count t)
;;   ;; Clean-up modeline
;;   ;; (setq doom-modeline-icon nil) ;; remove all icons from modeline
;;   (setq doom-modeline-buffer-state-icon nil)
;;   (setq doom-modeline-major-mode-icon t)
;;   (setq doom-modeline-major-mode-color-icon t)

;;   (setq doom-modeline-workspace-name nil) ;; use tab instead
;;   (setq doom-modeline-buffer-encoding nil)
;;  ;; (setq doom-modeline-buffer-file-name-style 'file-name) ;; only the file name
;;   (setq doom-modeline-buffer-file-name-style 'auto)

;;   ;; Custom modal indicator for evil, Under test, see  k8x1d-evil.el.
;;   (setq doom-modeline-modal-icon nil)

;;   ;; Define your custom modeline
;;   (doom-modeline-def-modeline 'k8x1d-modeline
;;     ;; Left side
;;     '(modals
;;       buffer-info
;;       vcs
;;       buffer-position
;;       selection-info
;;       compilation)
;;     ;; Right side
;;     '(;;battery
;;       ;;time
;;       ;;process
;;       misc-info
;;       lsp
;;       checker
;;       major-mode
;;       minor-modes
;;       ))

;;   ;; Set default mode-line
;;   (add-hook 'doom-modeline-mode-hook
;;  	    (lambda ()
;;  	      (doom-modeline-set-modeline 'k8x1d-modeline 'default)) )

;;   ;; set particulat font for modeline
;;  ;; (setq doom-modeline-height 1) ; optional
;;   (if (facep 'mode-line-active)
;;       (set-face-attribute 'mode-line-active nil :family "Iosevka Term" :height 120) ; For 29+
;;     (set-face-attribute 'mode-line nil :family "Iosevka Term" :height 120))
;;   (set-face-attribute 'mode-line-inactive nil :family "Iosevka Term" :height 120)

;;   )


(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-state-icon nil)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
  )

;; (use-package lambda-line
;;   :straight (:type git :host github :repo "lambda-emacs/lambda-line")
;;   :custom
;;   (lambda-line-icon-time t) ;; requires ClockFace font (see below)
;;   (lambda-line-clockface-update-fontset "ClockFaceRectSolid") ;; set clock icon
;;   (lambda-line-position 'bottom) ;; Set position of status-line
;;   (lambda-line-abbrev t) ;; abbreviate major modes
;;   (lambda-line-hspace "  ")  ;; add some cushion
;;   (lambda-line-prefix t) ;; use a prefix symbol
;;   (lambda-line-prefix-padding nil) ;; no extra space for prefix
;;   (lambda-line-status-invert nil)  ;; no invert colors
;;   (lambda-line-gui-ro-symbol  " ⨂") ;; symbols
;;   (lambda-line-gui-mod-symbol " ⬤")
;;   (lambda-line-gui-rw-symbol  " ◯")
;;   (lambda-line-space-top +.50)  ;; padding on top and bottom of line
;;   (lambda-line-space-bottom -.50)
;;   (lambda-line-symbol-position 0.1) ;; adjust the vertical placement of symbol
;;   :hook ((after-init . lambda-line-mode)
;; 	 (lambda-line-mode . display-time-mode))
;;   :config
;;   ;; set divider line in footer
;;   (when (eq lambda-line-position 'top)
;;     (setq-default mode-line-format (list "%_"))
;;     (setq mode-line-format (list "%_"))))

;; Custom modeline
;; Inspired by https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
;; (use-package emacs
;;   :init
;;   (defun simple-mode-line-render (left right)
;;     "Return a string of `window-width' length.
;; Containing LEFT, and RIGHT aligned respectively."
;;     (let ((available-width
;; 	   (- (window-total-width)
;; 	      (+ (length (format-mode-line left))
;; 		 (length (format-mode-line right))))))
;;       (append left
;; 	      (list (format (format "%%%ds" available-width) ""))
;; 	      right)))
;;   :config
;;   (setq-default
;;    ;; (setq
;;    mode-line-format
;;    '((:eval
;;       (simple-mode-line-render
;;        ;; Left.
;;        (quote ("%e "
;; 	       evil-mode-line-tag
;; 	       " "
;; 	       mode-line-buffer-identification
;; 	       (vc-mode vc-mode)
;; 	       " [%l:%c]"
;; 	       ))
;;        ;;
;;        ;; Right.
;;        (quote (
;; 	       " "
;; 	       mode-line-frame-identification
;; 	       mode-line-misc-info
;; 	       mode-line-modes
;; 	       ))))))
;;   )

(use-package minions-mode
  :straight (:host github :repo "tarsius/minions")
  :hook (doom-modeline-mode . minions-mode)
  :init
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


;; (use-package emms-mode-line-cycle
;;   :config
;;   (emms-mode-line 1)
;;   (emms-playing-time 1)

;;   ;; `emms-mode-line-cycle' can be used with emms-mode-line-icon.
;;   (require 'emms-mode-line-icon)
;;   (setq emms-mode-line-cycle-use-icon-p t)

;;   (emms-mode-line-cycle 1)
;;   )

;; (use-package powerline
;;   :hook (after-init . powerline-vim-theme)
;; ;;(powerline-center-evil-theme)
;; )



(provide 'k8x1d-modeline)
;;; k8x1d-modeline.el ends here
