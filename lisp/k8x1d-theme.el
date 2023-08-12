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
	  ;;`(hl-line ((t (:background "#28003d"))))
	  `(hl-line ((t (:background "#28003d"))))
	  `(org-block ((t (:background "#28003d"))))
	  `(org-inline-src-block ((t (:background "#28003d"))))
	  `(org-block-begin-line ((t (:background "#28003d"))))
	  `(org-block-end-line ((t (:background "#28003d")))))
       (custom-set-faces
	;;`(hl-line ((t (:background "#28003d"))))
	`(hl-line ((t (:background ,(doom-color 'region)))))
	`(org-block ((t (:background ,(doom-color 'base1)))))
	`(org-inline-src-block ((t (:background ,(doom-color 'base1)))))
	`(org-block-begin-line ((t (:background ,(doom-color 'base1)))))
	`(org-block-end-line ((t (:background ,(doom-color 'base1))))))
       ))

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

;; (use-package emacs
;;   ;;:hook (after-init . (lambda () (load-theme 'modus-vivendi)))
;;   :config
;;   (custom-set-faces
;;    ;; General
;;    `(default ((t (:background "#282828") :foreground  "#ebdbb2" )))
;;    `(cursor ((t (:background "#ebdbb2" :foreground "#282828"))))
;;    ;; highlight
;;    `(hl-line ((t (:background "#3c3836"))))
;;    `(region ((t (:background "#504945"))))
;;    ;; Fonts
;;    `(font-lock-comment-face ((t (:foreground "#928374"))))
;;    `(font-lock-string-face ((t (:foreground "#8ec07c"))))
;;    `(font-lock-constant-face ((t (:foreground "#fe8019"))))
;;    `(font-lock-keyword-face ((t (:foreground "#fb4934"))))
;;    `(font-lock-preprocessor-face ((t (:foreground "#d3869b"))))
;;    `(font-lock-builtin-face ((t (:foreground "#83a598"))))

;;   ;; ;; in test
;;   ;; `(font-lock-regexp-grouping-backslash ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-regexp-grouping-construct ((t (:foreground "#fe8019"))))


;;   ;; `(font-lock-punctuation-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-delimiter-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-bracket-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-negation-char-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-number-face ((t (:foreground "#fe8019"))))

;;   ;; `(font-lock-misc-punctuation-face ((t (:foreground "#fe8019"))))

;;   ;; `(font-lock-operator-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-function-name-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-function-call-face ((t (:foreground "#fe8019"))))

;;   ;; `(font-lock-property-name-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-property-use-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-variable-name-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-variable-use-face ((t (:foreground "#fe8019"))))
;;   ;; `(font-lock-variable-use-face ((t (:foreground "#98971a"))))

;;   ;; `(font-lock-type-face ((t (:foreground "#fe8019"))))

;;    ;; Corfu
;;    `(corfu-current ((t (:background "#504945"))))
;;    ;;`(font-lock-function-name-face ((t (:background "#fe8019"))))

;;    ;; Vertico
;;    `(highlight ((t (:background "#504945"))))
;;    `(minibuffer-prompt ((t (:foreground "#8ec07c"))))

;;    ;; Customize modeline color
;;    `(mode-line-active ((t (:background "#3c3836" :foreground "#ebdbb2"))))
;;    `(mode-line-buffer-id ((t (:background "#3c3836" :foreground "#ebdbb2"))))
;;    `(mode-line-inactive ((t (:background "#282828" :foreground "#ebdbb2"))))
;;    ;;`(doom-modeline-evil-normal-state ((t (:background "#ebdbb2" :foreground "#282828"))))
;;    ))


(provide 'k8x1d-theme)
