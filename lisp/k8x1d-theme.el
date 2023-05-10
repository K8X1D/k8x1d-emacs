;;(use-package doom-themes
;;  :init
;;  (setq dark-theme 'doom-gruvbox)
;;  (setq light-theme 'doom-gruvbox-light)
;;  (setq actual-theme dark-theme) 
;;
;;  (defun k8x1d/set-theme ()
;;    (load-theme actual-theme t)
;;    (custom-set-faces
;;     ;; Tab configuration
;;     `(tab-bar ((t (:inherit nil :family "Iosevka Aile" :background ,(doom-color 'bg-alt)))))
;;     `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :height 1.5))))
;;     `(tab-bar-tab-inactive ((t (:inherit nil :background ,(doom-color 'base3) :foreground ,(doom-color 'base5) :height 1.5))))
;;    ;; `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :background ,(doom-color 'bg) :height 1.5))))
;;    ;; `(tab-bar-tab-inactive ((t (:inverse-video t :height 1.5))))
;;     ;; todo 
;;     ;;`(org-todo ((t (:inverse-video t :box '(:line-width (3 . 3) :color ,(doom-color 'fg) :style flat-button) :weight bold))))
;;     ;;`(org-done ((t (:inverse-video t :box '(:line-width (3 . 3) :color ,(doom-color 'fg) :style flat-button) :weight bold))))
;;     `(font-lock-comment-face ((t (:foreground "#928374"))))
;;     ;;'(font-lock-string-face ((t (:foreground "#b8bb26" :family "Hack"))))
;;     ;;'(font-lock-string-face ((t (:foreground "#b8bb26" :family "JuliaMono"))))
;;     `(font-lock-string-face ((t (:foreground "#b8bb26" :family "DejaVu Sans Mono Nerd Font"))))
;;     `(doom-modeline-evil-normal-state ((t (:foreground ,(doom-color 'green)))))
;;     `(doom-modeline-evil-visual-state ((t (:foreground ,(doom-color 'red)))))
;;     `(doom-modeline-emphasis ((t (:foreground ,(doom-color 'red)))))
;;     `(doom-modeline-evil-insert-state ((t (:foreground ,(doom-color 'teal)))))
;;     )
;;    )
;;
;;  (defun switch-theme (theme)
;;    (disable-theme actual-theme)
;;    (setq actual-theme theme)
;;    (k8x1d/set-theme)
;;    ;;`(org-inline-src-block ((t (:background ,(doom-color 'base3)))))
;;    )
;;
;;  (defun k8x1d/dark-light-theme-switch ()
;;    (interactive)
;;    (if (equal actual-theme dark-theme)
;;	(switch-theme light-theme)
;;      (switch-theme dark-theme)
;;      ))
;;  :bind
;;  ("<f5>" . 'k8x1d/dark-light-theme-switch)
;;  :hook 
;;  (after-init . (lambda ()
;;		  ;;(load-theme 'modus-vivendi)
;;		  (k8x1d/set-theme)
;;		  ))
;;  :config
;;  ;; Global settings (defaults)
;;  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;	doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;  (load-theme 'doom-gruvbox t)
;;  ;; Enable flashing mode-line on errors
;;  (doom-themes-visual-bell-config)
;;  ;; Corrects (and improves) org-mode's native fontification.
;;  (doom-themes-org-config)
;;  ;; Brighter comments
;;  (setq doom-gruvbox-brighter-comments nil)
;;  )



;;(use-package lambda-themes
;;  :straight (:type git :host github :repo "lambda-emacs/lambda-themes") 
;;  :custom
;;  (lambda-themes-set-italic-comments t)
;;  (lambda-themes-set-italic-keywords t)
;;  (lambda-themes-set-variable-pitch t) 
;;  :config
;;  ;; load preferred theme 
;;  (load-theme 'lambda-dark))


(use-package emacs
  :bind
  ("<f5>" . 'modus-themes-toggle)
  :hook 
  (after-init . (lambda () (load-theme 'modus-vivendi)))
  :config
  (setq modus-themes-custom-auto-reload nil
	modus-themes-to-toggle '(modus-operandi modus-vivendi)
	modus-themes-mixed-fonts t
	modus-themes-variable-pitch-ui nil
	modus-themes-italic-constructs t
	modus-themes-bold-constructs nil
	modus-themes-org-blocks nil
	modus-themes-completions '((t . (extrabold)))
	modus-themes-prompts nil
	modus-themes-headings
	'((agenda-structure . (variable-pitch light 2.2))
          (agenda-date . (variable-pitch regular 1.3))
          (t . (regular 1.15))))
  ;; Custom colors
  (setq modus-themes-common-palette-overrides
	`((bg-main "#282828")
	  (fg-main "#ebdbb2")
	  ;; (bg-tab-bar      "#313131")
	  ;; (bg-tab-current  "#282828")
	  ;; (bg-tab-other    "#928374")
	  ))
  (custom-set-faces
   ;; Tab configuration
   `(tab-bar ((t (:inherit nil :family "Iosevka Aile"))))
   `(tab-bar-tab ((t (:inherit nil :height 1.5))))
   `(tab-bar-tab-inactive ((t (:inherit nil :height 1.5))))
   )
  )

(provide 'k8x1d-theme)
