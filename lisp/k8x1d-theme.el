;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package doom-themes
  :general
  (k8x1d/leader-keys
    "c" '(:ignore t :which-key "Customize")
    "ct" '(:ignore t :which-key "Theme")
    "cts" '(k8x1d/dark-to-light-to-dark :which-key "Switch Light/Dark")
    )
  :init
  (defvar k8x1d/doom-dark-theme 'doom-palenight)
  (defvar k8x1d/doom-light-theme 'doom-one-light)
  (defvar k8x1d/actual-theme k8x1d/doom-dark-theme)

  (defun k8x1d/adjust-theme ()
    (if (equal k8x1d/actual-theme k8x1d/doom-dark-theme)
	(custom-set-faces
	 `(hl-line ((t (:background "#28003d"))))
	 `(tab-bar-echo-area-tab ((t (:background ,(doom-color 'magenta) :foreground ,(doom-color 'base0)))))
	 `(tab-bar-echo-area-tab-inactive ((t (:foreground ,(doom-color 'magenta)))))
	 `(solaire-default-face ((t (:background ,(doom-color 'base0)))))
	 `(org-block ((t (:background "#28003d"))))
	 `(org-inline-src-block ((t (:background "#28003d"))))
	 `(org-block-begin-line ((t (:background "#28003d"))))
	 `(org-block-end-line ((t (:background "#28003d")))))
      (custom-set-faces
       `(hl-line ((t (:background ,(doom-color 'region)))))
       `(tab-bar-echo-area-tab ((t (:background ,(doom-color 'magenta) :foreground ,(doom-color 'base0)))))
       `(tab-bar-echo-area-tab-inactive ((t (:foreground ,(doom-color 'magenta)))))
       `(solaire-default-face ((t (:background ,(doom-color 'base0)))))
       `(org-block ((t (:background ,(doom-color 'base1)))))
       `(org-inline-src-block ((t (:background ,(doom-color 'base1)))))
       `(org-block-begin-line ((t (:background ,(doom-color 'base1)))))
       `(org-block-end-line ((t (:background ,(doom-color 'base1))))))
      )
    )

  (defun k8x1d/switch-theme (old-theme new-theme)
    (disable-theme old-theme)
    (load-theme new-theme t)
    (setq k8x1d/actual-theme new-theme))

  (defun k8x1d/dark-to-light-to-dark ()
    (interactive)
    (if (eq k8x1d/actual-theme k8x1d/doom-dark-theme)
	(k8x1d/switch-theme k8x1d/doom-dark-theme k8x1d/doom-light-theme)
      (k8x1d/switch-theme k8x1d/doom-light-theme k8x1d/doom-dark-theme))
    (k8x1d/adjust-theme)
    )
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
 	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)

  :hook
  (after-init . (lambda ()
 		  (load-theme k8x1d/actual-theme t)
		  (k8x1d/adjust-theme)))
  )

(provide 'k8x1d-theme)
;;; k8x1d-theme.el ends here
