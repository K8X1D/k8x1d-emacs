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
  ;; Define your custom modeline
 ;; (doom-modeline-def-modeline 'k8x1d-modeline
 ;;   ;; Left side
 ;;   '(bar workspace-name window-number modals matches follow buffer-info remote-host
 ;;	  ;;buffer-position
 ;;	  word-count parrot selection-info
 ;;	  vcs)
 ;;   ;; Right side
 ;;   '(compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl
 ;;		  lsp checker
 ;;		  input-method indent-info buffer-encoding
 ;;		  major-mode minor-modes
 ;;		  ;;process
 ;;		  time))
  ;; barebone version
  (doom-modeline-def-modeline 'k8x1d-modeline
    ;; Left side
    '(modals
      buffer-info
      word-count
      vcs)
    ;; Right side
    '(compilation
      lsp checker
      major-mode minor-modes))

  ;; Set default mode-line
  (add-hook 'doom-modeline-mode-hook
	    (lambda ()
	      (doom-modeline-set-modeline 'k8x1d-modeline 'default)))
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
  (setq minions-mode-line-lighter "minor-modes")
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
