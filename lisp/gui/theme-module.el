(use-package doom-themes
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
  :hook (after-init . window-divider-mode)
  :custom-face (window-divider ((t :foreground ,(doom-color 'green))))
  :config
  (setq window-divider-default-places t)
  (setq window-divider-default-bottom-width 1)
  (setq window-divider-default-right-width 1)
  )

(provide 'theme-module)
