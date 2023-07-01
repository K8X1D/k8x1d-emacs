(use-package doom-themes
  :init
  (defvar k8x1d/doom-dark-theme 'doom-gruvbox)
  (defvar k8x1d/doom-light-theme 'doom-gruvbox-light)
  (defvar k8x1d/actual-theme k8x1d/doom-dark-theme)

  (defun k8x1d/switch-theme (old-theme new-theme)
    (disable-theme old-theme)
    (load-theme new-theme t)
    ;; Customization
    ;; Must be used *after* the theme is loaded
    (custom-set-faces
     `(cursor ((t (:background ,(doom-color 'fg) :foreground ,(doom-color 'bg))))))
    (setq k8x1d/actual-theme new-theme))

  (defun k8x1d/dark-to-light-to-dark ()
    (interactive)
    (if (eq k8x1d/actual-theme k8x1d/doom-dark-theme)
	(k8x1d/switch-theme k8x1d/doom-dark-theme k8x1d/doom-light-theme)
      (k8x1d/switch-theme k8x1d/doom-light-theme k8x1d/doom-dark-theme)))
  :bind
  ("<f5>" . 'k8x1d/dark-to-light-to-dark)
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme k8x1d/actual-theme t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  ;; Brighter comments
  (setq doom-gruvbox-brighter-comments nil)
  )


(provide 'k8x1d-theme)
