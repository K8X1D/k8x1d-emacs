;;;;
;;;; Pdf support
;;;;
(use-package pdf-tools
  :hook
  (pdf-view-mode . pdf-view-midnight-minor-mode) ;; dark mode by default
  :init
  (pdf-loader-install) ;; On demand loading
  )

;;
;; Terminal
;;

(use-package vterm
  :defer t
  :hook
  (vterm-mode . (lambda ()
		  (setq-local evil-insert-state-cursor 'box)
		  (evil-insert-state))))
(use-package multi-vterm
  :defer t
 :bind
  (("C-c o t" . multi-vterm-dedicated-toggle)
  ("C-c o T" . multi-vterm))
  :config
  (setq multi-vterm-dedicated-window-height-percent 35)
  )

(use-package hide-mode-line
  :defer t
  :hook
  (vterm-mode . hide-mode-line-mode))


;;
;; Guix interaction
;;
;;(use-package guix)

;;
;; Password-store interaction
;;
(use-package pass
  :defer t)
(use-package password-store
  :defer t)
(use-package password-store-otp
  :defer t)









(provide 'utilities-module)
