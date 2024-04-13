(use-package doom-themes
  :init
  (setq k8x1d/default-dark-theme 'doom-palenight
	k8x1d/default-light-theme 'doom-one-light)
  (defun k8x1d/switch-theme ()
    (interactive)
    (if (string= (car custom-enabled-themes) k8x1d/default-dark-theme)
	(progn
	  ;; (consult-theme k8x1d/default-light-theme)
	  (disable-theme (car custom-enabled-themes))
	  (load-theme k8x1d/default-light-theme t)
	  (k8x1d/set-frame-opacity 90)
	  )
      (progn
	;; (consult-theme k8x1d/default-dark-theme)
	(disable-theme (car custom-enabled-themes))
	(load-theme k8x1d/default-dark-theme t)
	(k8x1d/set-frame-opacity 80)
	)
      )
    )
  :bind
  ("C-c s t " . k8x1d/switch-theme)

;; TODO: replace by own system
  ;; :hook (after-init . (lambda () (load-theme 'doom-palenight t)))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)

  )

(use-package emacs
  :init
  (defun k8x1d/set-window-divider-colors ()
    (custom-set-faces
     `(window-divider ((t :foreground ,(doom-color 'green))))
     )
    )
  :hook (after-init . window-divider-mode)
  :config
  (setq window-divider-default-places t)
  (setq window-divider-default-bottom-width 1)
  (setq window-divider-default-right-width 1)
  (k8x1d/set-window-divider-colors)
  )
;; Follow system theme
;; Don't work with dwl, have to be adjusted
;; (use-package auto-dark
;;   :after doom-themes
;;   :hook ((after-init . auto-dark-mode)
;; 	 (auto-dark-dark-mode . (lambda ()
;; 				  (k8x1d/set-frame-opacity 80)
;; 				   (k8x1d/set-org-modern-colors)
;; 				   (k8x1d/set-tab-bar-colors)
;; 				  ))
;; 	 (auto-dark-light-mode . (lambda ()
;; 				   (k8x1d/set-frame-opacity 90)
;; 				   (k8x1d/set-org-modern-colors)
;; 				   (k8x1d/set-tab-bar-colors)
;; 				   ))
;; 	 )
;;   :config
;;   (setq auto-dark-dark-theme 'doom-palenight
;; 	auto-dark-light-theme 'doom-one-light)
;;   (defun auto-dark--is-dark-mode ()
;;     (let ((tmp (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme")))
;;       (string-match-p (regexp-quote "dark") tmp))
;;     )
;;   )

(provide 'theme-module)
