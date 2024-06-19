;; General configuration
(use-package flymake
    :bind
    (("C-c ! n" . flymake-goto-next-error)
     ("C-c ! p" . flymake-goto-prev-error)
     ("C-c ! l" . flymake-show-buffer-diagnostics))
    )

;; FIXME: failed to autoload
;;;; Extended support
(use-package flymake-collection
  ;; :hook (flymake-mode . flymake-collection-hook-setup)
  )

;; Display result in posframe
;;(use-package flymake-posframe
;;  :ensure nil
;;  :if k8x1d/posframe-support
;;  :hook (flymake-mode . flymake-posframe-mode)
;;  )

;;;; Indicator in the margin
(use-package flymake-margin
  :hook ((flymake-mode . flymake-margin-mode)
	 (flymake-margin-mode . (lambda () (progn
					     ;; (setq left-margin-width 2)
					     (setq right-margin-width 3)
					     (set-window-buffer nil (current-buffer)))))
	 )
  :config
  ;; (setq flymake-margin-error-symbol " ")
  ;; (setq flymake-margin-warning-symbol " ")
  ;; (setq flymake-margin-note-symbol " ")
  (setq flymake-margin-error-symbol "")
  (setq flymake-margin-warning-symbol "△")
  (setq flymake-margin-note-symbol "?")
  (setq flymake-margin-side 'right)
  )


;; Keybindings
(use-package flymake
  :init
  (defun k8x1d/flymake-show-buffer-diagnostics-vertical ()
    (interactive)
    (require 'flymake)
    (flymake-show-buffer-diagnostics)
    (evil-window-right 1)
    (evil-window-move-very-bottom)
    (evil-window-set-height 16)
    )
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/local-leader-keys
   :keymaps 'flymake-mode-map
   "d" '(:ignore t :which-key "Diagnostics")
   "db" '(k8x1d/flymake-show-buffer-diagnostics-vertical :which-key "Buffer")
   "dp" '(flymake-goto-prev-error :which-key "Previous")
   "dn" '(flymake-goto-next-error :which-key "Next")
   )
  )


(provide 'checker-module)
