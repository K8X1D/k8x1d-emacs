;;
;; Set Theme
;; 


;;(global-set-key (kbd "<f5>") 'k8x1d/dark-light-theme-switch)

;;(load-theme 'modus-operandi)


(use-package doom-themes
  :init
  (setq dark-theme 'doom-gruvbox)
  (setq light-theme 'doom-gruvbox-light)
  (setq actual-theme dark-theme) 

  (defun k8x1d/set-theme ()
    (load-theme actual-theme t)
    (custom-set-faces
     `(tab-bar ((t (:inherit nil :family "Iosevka Aile" :background ,(doom-color 'bg-alt)))))
     `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :height 1.5))))
     `(tab-bar-tab-inactive ((t (:inherit nil :background ,(doom-color 'base3) :foreground ,(doom-color 'base5) :height 1.5))))
     ;; todo 
     ;;`(org-todo ((t (:inverse-video t :box '(:line-width (3 . 3) :color ,(doom-color 'fg) :style flat-button) :weight bold))))
     ;;`(org-done ((t (:inverse-video t :box '(:line-width (3 . 3) :color ,(doom-color 'fg) :style flat-button) :weight bold))))
     `(font-lock-comment-face ((t (:foreground "#928374"))))
     ;;'(font-lock-string-face ((t (:foreground "#b8bb26" :family "Hack"))))
     ;;'(font-lock-string-face ((t (:foreground "#b8bb26" :family "JuliaMono"))))
     `(font-lock-string-face ((t (:foreground "#b8bb26" :family "DejaVu Sans Mono Nerd Font"))))
     `(doom-modeline-evil-normal-state ((t (:foreground ,(doom-color 'green)))))
     `(doom-modeline-evil-visual-state ((t (:foreground ,(doom-color 'red)))))
     `(doom-modeline-emphasis ((t (:foreground ,(doom-color 'red)))))
     `(doom-modeline-evil-insert-state ((t (:foreground ,(doom-color 'teal)))))
     )
    )

  (defun switch-theme (theme)
    (disable-theme actual-theme)
    (setq actual-theme theme)
    (k8x1d/set-theme)
    ;;`(org-inline-src-block ((t (:background ,(doom-color 'base3)))))
    )

  (defun k8x1d/dark-light-theme-switch ()
    (interactive)
    (if (equal actual-theme dark-theme)
	(switch-theme light-theme)
      (switch-theme dark-theme)
      ))
  :bind
  ("<f5>" . 'k8x1d/dark-light-theme-switch)
  :hook 
  (after-init . (lambda ()
		  ;;(load-theme 'modus-vivendi)
		  (k8x1d/set-theme)
		  ))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  ;; Brighter comments
  (setq doom-gruvbox-brighter-comments t)
  )



;;(add-hook 'after-init-hook (lambda ()
;;			     ;;(load-theme 'modus-vivendi)
;;			     (k8x1d/set-theme)
;;			     ))














(provide 'k8x1d-theme)
