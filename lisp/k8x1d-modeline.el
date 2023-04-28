(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  ;; Add wanted information
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-minor-modes t) ;; for minions
  ;; Clean-up modeline
  ;; (setq doom-modeline-buffer-state-icon nil)
  ;; (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-icon nil)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
  (setq doom-modeline-buffer-encoding nil)
  ;; Custom modal indicator for evil, Under test
  (setq doom-modeline-modal-icon nil)
  (setq evil-normal-state-tag   (propertize "(N)" 'face '((:background ,(doom-color 'green) :foreground ,(doom-color 'bg))))
	evil-emacs-state-tag    (propertize "(E)" 'face '((:background ,(doom-color 'orange) :foreground ,(doom-color 'bg))))
	evil-insert-state-tag   (propertize "(I)" 'face '((:inverse-video t :background ,(doom-color 'red)) :foreground ,(doom-color 'fg)))
	evil-motion-state-tag   (propertize "(M)" 'face '((:background ,(doom-color 'blue)) :foreground ,(doom-color 'fg)))
	evil-visual-state-tag   (propertize "(V)" 'face '((:background ,(doom-color 'grey) :foreground ,(doom-color 'bg))))
	evil-operator-state-tag (propertize "(O)" 'face '((:background ,(doom-color 'violet)))))
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

(use-package minions-mode
  :hook (doom-modeline-mode . minions-mode)
  ;; :hook (telephone-line-mode . minions-mode)
  :init
  (setq minions-mode-line-lighter "...")
  )

(use-package hide-mode-line
  :hook
  ((vterm-mode . hide-mode-line-mode)
   (dired-sidebar-mode . hide-mode-line-mode)
   (inferior-ess-r-mode . hide-mode-line-mode)
   (org-capture-mode . hide-mode-line-mode)
   (julia-vterm-repl-mode . hide-mode-line-mode))
  )

(provide 'k8x1d-modeline)
