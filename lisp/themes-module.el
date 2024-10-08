;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Native emacs themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package modus-themes
  :if (string= k8x1d/theme "modus")
  :hook
  (after-init . (lambda ()
  ;;                 (load-theme 'modus-vivendi t)
                  (k8x1d/set-org-colors)))
  :bind
  ("<f5>" . k8x1d/modus-themes-toggle)
  ;; :custom-face
  ;; (modus-themes-tab-active ((t (:inherit t :box nil))))
  ;; (modus-themes-tab-inactive ((t (:inherit t :box nil))))
  :config
  (setq modus-themes-mixed-fonts t) ;; enable inheritance from ‘fixed-pitch’ in some faces
  ;; Deprecated
  ;; (setq modus-themes-tabs-accented t)
  ;; (setq modus-themes-markup '(bold italic intense background))
  ;; (setq modus-themes-diffs nil)
  ;; (setq modus-themes-links '(bold background no-underline))
  ;; (setq modus-themes-org-blocks 'tinted-background)

;; Switch theme function
  (defun k8x1d/modus-themes-toggle ()
    (interactive)
    (modus-themes-toggle)
    (k8x1d/set-org-colors)
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Doom emacs themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package doom-themes
  :if (string= k8x1d/theme "doom")
  :init
  (defun k8x1d/set-custom-colors ()
    (custom-set-faces
     `(window-divider ((t :foreground ,(doom-color 'green))))

     `(tab-bar ((t (:foreground ,(doom-color 'fg) :background ,(doom-color 'bg-alt) :height 0.9 ))))
     `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :background ,(doom-color 'bg)))))
     `(tab-bar-tab-inactive ((t (:foreground ,(doom-color 'grey) :background ,(doom-color 'bg-alt)))))

     ))
  :hook
  (after-init . (lambda ()
		  (load-theme 'doom-gruvbox t)
		  (k8x1d/set-org-colors)
		  (k8x1d/set-custom-colors)
		  ))
  :bind
  ("<f5>" . k8x1d/switch-theme)
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)

  ;; TODO: write
;; Switch theme function
  ;; (defun k8x1d/modus-themes-toggle ()
  ;;   (interactive)
  ;;   (modus-themes-toggle)
  ;;   (k8x1d/set-org-colors)
  ;;   )

  :init
(defvar k8x1d/default-emacs-dark-theme 'doom-gruvbox)
(defvar k8x1d/default-emacs-light-theme 'doom-gruvbox-light)

;; TODO: Move somewhere else
(defun k8x1d/set-frame-opacity (opacity)
    "Interactively change the current frame's opacity (v29 pgtk version).
OPACITY is an integer between 0 to 100, inclusive."
    (interactive
     (list (read-number "Opacity (0-100): "
			(or (frame-parameter nil 'alpha)
			    100))))
    (if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
	(set-frame-parameter nil 'alpha-background opacity)
      (set-frame-parameter nil 'alpha opacity)))

  ;; Switch theme
(defun k8x1d/switch-theme ()
    (interactive)
    (if (string= (car custom-enabled-themes) k8x1d/default-emacs-dark-theme)
	(progn
	  (disable-theme (car custom-enabled-themes))
	  (load-theme k8x1d/default-emacs-light-theme t)
	  (k8x1d/set-frame-opacity 90)
	  )
      (progn
	(disable-theme (car custom-enabled-themes))
	(load-theme k8x1d/default-emacs-dark-theme t)
	(k8x1d/set-frame-opacity 80)
	)
      )
    (k8x1d/set-org-colors)
    (k8x1d/set-custom-colors)
    )
  )


(provide 'themes-module)
