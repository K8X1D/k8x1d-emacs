(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  ;; Add wanted information
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-minor-modes t) ;; for minions
  ;; Clean-up modeline
  (setq doom-modeline-buffer-state-icon nil)
  (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
  (setq doom-modeline-buffer-encoding nil)
  ;; Custom modal indicator for evil, Under test
  (setq doom-modeline-modal-icon nil)
  (setq evil-normal-state-tag   (propertize "[Normal]" 'face '((:background ,(doom-color 'green) :foreground ,(doom-color 'bg))))
	evil-emacs-state-tag    (propertize "[Emacs]" 'face '((:background ,(doom-color 'orange) :foreground ,(doom-color 'bg))))
	evil-insert-state-tag   (propertize "[Insert]" 'face '((:background ,(doom-color 'red)) :foreground ,(doom-color 'fg)))
	evil-motion-state-tag   (propertize "[Motion]" 'face '((:background ,(doom-color 'blue)) :foreground ,(doom-color 'fg)))
	evil-visual-state-tag   (propertize "[Visual]" 'face '((:background ,(doom-color 'grey) :foreground ,(doom-color 'bg))))
	evil-operator-state-tag (propertize "[Operator]" 'face '((:background ,(doom-color 'violet)))))
  )

(use-package minions-mode
  :hook (doom-modeline-mode . minions-mode))

(provide 'k8x1d-modeline)
