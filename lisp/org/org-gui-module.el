;; General
(use-package org
  :custom-face (org-block ((t (:background ,(doom-color 'bg)))))
  :hook ((org-mode . org-indent-mode)
	 (org-mode . visual-line-mode)))

;; (use-package org-margin
;;   :hook ((org-mode . org-margin-mode)
;; 	 (org-margin-mode . (lambda () (progn
;; 					 (org-indent-mode -1)
;; 					 (setq left-margin-width 10)
;; 					 (set-window-buffer nil (current-buffer)))))
;; 	 )
;;   :config
;;   (setq org-margin-headers
;; 	'((stars #("     *" 0 6 (face org-level-1))
;; 		 #("    **" 0 6 (face org-level-2))
;; 		 #("   ***" 0 6 (face org-level-3))
;; 		 #("  ****" 0 6 (face org-level-4))
;; 		 #(" *****" 0 6 (face org-level-5))
;; 		 #("******" 0 6 (face org-level-6)))
;; 	  (H-txt #("H1" 0 2 (face org-level-1))
;; 		 #("H2" 0 2 (face org-level-2))
;; 		 #("H3" 0 2 (face org-level-3))
;; 		 #("H4" 0 2 (face org-level-4))
;; 		 #("H5" 0 2 (face org-level-5))
;; 		 #("H6" 0 2 (face org-level-6))))
;; 	)
;;   )

;; Modern look
(use-package org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda))
  :custom-face (org-modern-tag ((t (:background ,(doom-color 'bg-alt)))))
  :custom
  (org-modern-hide-stars nil)		; adds extra indentation
  (org-modern-table nil)
  (org-modern-block-name '("" . "")) ; or other chars; so top bracket is drawn promptly

  :config
  ;; (setq org-modern-table t)

  ;; Edit settings
  (setq org-fold-catch-invisible-edits 'show-and-error)
  (setq org-special-ctrl-a/e t)
  (setq org-insert-heading-respect-content t)

  ;; Org styling, hide markup etc.
  (setq org-pretty-entities nil)
  (setq org-ellipsis "…")

  ;; Agenda styling
  (setq org-agenda-block-separator ?─)
  (setq org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
  (setq org-agenda-current-time-string "⭠ now ─────────────────────────────────────────────────")

  ;; Bullets cutomization
  (setq org-modern-checkbox '((?X . "󰄲 ")
                              (?- . "󱋬 ")
                              (?\s . "󰄮 ")))
  (setq org-modern-list '((43 . "▶")
                          (45 . "◦")
                          (42 . "•")))
  (setq org-modern-star '("◉" "●" "○"))

  ;; org block
  (setq org-modern-block-name t)
  (setq org-modern-block-fringe t)
  )

;; Better indentation for org-modern
(if (string= k8x1d/package-management "straight")
    (straight-use-package
     '(org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent"))
  )
(use-package org-modern-indent
  :hook (org-modern-mode . org-modern-indent-mode)
  :config
  (setq org-modern-block-fringe nil) ;; in test, seems to cause conflict with indent
  (setq org-src-preserve-indentation nil)
  (setq org-modern-hide-stars nil)		; adds extra indentation
  (setq org-modern-table nil)
  (setq org-modern-block-name '("" . "")) ; or other chars; so top bracket is drawn promptly
  )

;; Hide/Show markup
(use-package org-appear
  :hook ((org-mode . (lambda ()
                             (add-hook 'evil-insert-state-entry-hook
                                       #'org-appear-manual-start
                                       nil
                                       t)
                             (add-hook 'evil-insert-state-exit-hook
                                       #'org-appear-manual-stop
                                       nil
                                       t)))
  (org-mode . org-appear-mode))
  :config
  (setq org-hide-emphasis-markers t
        org-appear-trigger 'manual
        ;;org-appear-trigger 'always
        org-appear-autoentities t
        org-appear-autosubmarkers t
        org-appear-autokeywords t
        org-appear-inside-latex t
        org-appear-autoemphasis t
        org-appear-autolinks t)
  )


;; Automatic tags alignement
(use-package org
  :config
  ;; Tags
  (setq org-auto-align-tags t)
  ;; (setq org-auto-align-tags nil)
 ;; ;; Dynamic tags position adjustment, inspired from https://emacs.stackexchange.com/questions/10087/how-to-better-align-tags-in-org-mode-using-variable-width-font and https://orgmode.org/worg/org-hacks.html#orgheadline64
 ;; (setq k8x1d/org-adjust-tags-column t)
 ;; (when k8x1d/org-adjust-tags-column
 ;;   (defun get-right-alignment-position ()
 ;;     (- 2 (window-max-chars-per-line)))
 ;;   (defun org-realign-all-tags-now ()
 ;;     (set (make-local-variable 'org-tags-column)
 ;;          (get-right-alignment-position))
 ;;     (org-align-all-tags)
 ;;     (set-buffer-modified-p nil)
 ;;     )
 ;;   (defun k8x1d/org-adjust-tags-column-before-save ()
 ;;     "Tags need to be left-adjusted when saving."
 ;;     (set (make-local-variable 'org-tags-column)
 ;;          1)
 ;;     (org-align-all-tags)
 ;;     (set-buffer-modified-p nil)
 ;;     )
 ;;   (defun k8x1d/org-adjust-tags-column-after-save ()
 ;;     "Revert left-adjusted tag position done by before-save hook."
 ;;     (set (make-local-variable 'org-tags-column)
 ;;          (get-right-alignment-position))
 ;;     (org-align-all-tags)
 ;;     (set-buffer-modified-p nil)
 ;;     )

 ;;   (setq org-tags-column (get-right-alignment-position)) 

 ;;   (add-hook 'org-mode-hook #'org-realign-all-tags-now)
 ;;   (add-hook 'text-scale-mode-hook #'org-realign-all-tags-now)
 ;;   (add-hook 'before-save-hook #'k8x1d/org-adjust-tags-column-before-save)
 ;;   (add-hook 'after-save-hook #'k8x1d/org-adjust-tags-column-after-save)

 ;;   (defadvice org-refile (around org-refile-disable-adjust-tags)
 ;;     "Disable dynamically adjusting tags"
 ;;     (let ((k8x1d/org-adjust-tags-column nil))
 ;;       ad-do-it))
 ;;   (ad-activate 'org-refile)

 ;;   ) 
  )


;; TODO: adjust sequence, not loaded when launched in daemon-mode
(use-package org-modern
  :init
  (defun k8x1d/set-org-modern-colors ()
    (require 'org-modern)
    (setq org-modern-todo-faces
	  `(("TODO" :background ,(doom-color 'red) :foreground ,(doom-color 'bg) :family "Iosevka Nerd Font")
	    ("NEXT" :background ,(doom-color 'green) :foreground ,(doom-color 'bg)  :family "Iosevka Nerd Font")
	    ("WAIT" :background ,(doom-color 'yellow) :foreground ,(doom-color 'bg)  :family "Iosevka Nerd Font")))
    (setq org-modern-priority-faces
	  `((?A :background ,(doom-color 'green)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?B :background ,(doom-color 'orange)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?C :background ,(doom-color 'red)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")))
    (setq org-modern-symbol
	  `((?X :background ,(doom-color 'green)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?- :background ,(doom-color 'orange)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?\s :background ,(doom-color 'red)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")))
    )
  :custom-face
  (org-modern-done ((t (:family "Iosevka Nerd Font"))))
  ;; (org-agenda-clocking ((t (:weight bold :underline (:color foreground-color :style line :position 4) :background nil))))
  (org-agenda-clocking ((t (:weight bold :inverse-video t :background nil))))
  ;; (org-agenda-date ((t (:weight normal))))
  (org-imminent-deadline ((t (:weight normal)))) 
  :config
  (k8x1d/set-org-modern-colors)
  ;; Correct for issue with state faces https://github.com/minad/org-modern/issues/26
  (add-hook 'org-agenda-finalize-hook
	    (lambda ()
	      (setq-local org-todo-keywords-for-agenda '("TODO" "NEXT" "WAIT"))))
  )

;; Popup in posframe
(if (string= k8x1d/package-management "straight")
    (straight-use-package
     '(org-popup-posframe :type git :host github :repo "A7R7/org-popup-posframe"))
  )
(use-package org-popup-posframe 
  :if k8x1d/posframe-support
  :hook (org-mode . org-popup-posframe-mode)
  :config
  (require 'posframe)
  (setq org-popup-posframe-org-export-dispatch-poshandler #'posframe-poshandler-frame-center)
  (setq org-popup-posframe-org-capture-poshandler #'posframe-poshandler-frame-center)
  (setq org-popup-posframe-parameters
	'((left-fringe . 10)
	  (right-fringe . 10)
	  (alpha-background . 100) ;; no transparency
	  ))

  )

(if (string= k8x1d/package-management "straight")
    (straight-use-package
     '(org-margin :type git :host github :repo "rougier/org-margin"))
  )
(use-package org-margin)


(provide 'org-gui-module)
