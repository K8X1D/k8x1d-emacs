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
  (setq doom-modeline-buffer-file-name-style 'file-name)
  ;; Custom modal indicator for evil, Under test
  (setq doom-modeline-modal-icon nil)
  (setq evil-normal-state-tag "(N)"
	evil-emacs-state-tag "(E)"
	evil-insert-state-tag "(I)"
	evil-motion-state-tag "(M)"
	evil-visual-state-tag "(V)"
	evil-operator-state-tag "(O)")
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
