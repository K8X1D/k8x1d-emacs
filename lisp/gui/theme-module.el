;;; package --- Summary-*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package doom-themes
  :init
  (require 'doom-themes)
  (defun k8x1d/switch-theme ()
    (interactive)
    (if (string= (car custom-enabled-themes) k8x1d/default-emacs-dark-theme)
	(progn
	  ;; (consult-theme k8x1d/default-light-theme)
	  (disable-theme (car custom-enabled-themes))
	  (load-theme k8x1d/default-emacs-light-theme t)
	  (k8x1d/set-frame-opacity 90)
	  )
      (progn
	;; (consult-theme k8x1d/default-dark-theme)
	(disable-theme (car custom-enabled-themes))
	(load-theme k8x1d/default-emacs-dark-theme t)
	(k8x1d/set-frame-opacity 80)
	)
      )
    (k8x1d/set-org-modern-colors)
    ;; (k8x1d/set-tab-bar-colors)
    (k8x1d/set-window-divider-colors)
    )
  ;; TODO: simplify function
  (defun k8x1d/get-system-theme ()
   (replace-regexp-in-string "\n" "" (replace-regexp-in-string "'" "" (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme")))
    )
  (if (string= (k8x1d/get-system-theme) "prefer-dark")
      (setq k8x1d/default-emacs-theme k8x1d/default-emacs-dark-theme)
    (setq k8x1d/default-emacs-theme k8x1d/default-emacs-light-theme)
    )
  (defun k8x1d/switch-system-theme-to-light ()
    (interactive)
    (async-shell-command (concat "gsettings set org.gnome.desktop.interface gtk-theme" " " k8x1d/default-light-theme))
    (if (string= (k8x1d/get-system-theme) k8x1d/default-dark-theme)
	(k8x1d/switch-theme))
    )
  (defun k8x1d/switch-system-theme-to-dark ()
    (interactive)
    (async-shell-command (concat "gsettings set org.gnome.desktop.interface gtk-theme" " " k8x1d/default-dark-theme))
    (if (string= (k8x1d/get-system-theme) k8x1d/default-light-theme)
	(k8x1d/switch-theme))
    )
  :bind
  (("C-c s t " ("Switch emacs theme". k8x1d/switch-theme))
   ("C-c s l" ("Switch theme to light" . k8x1d/switch-system-theme-to-light))
    ("C-c s d" ("Switch theme to dark" . k8x1d/switch-system-theme-to-dark)))

;; TODO: replace by own system
  ;; :hook (after-init . (lambda () (load-theme 'doom-palenight t)))
  :hook (after-init . (lambda ()
	(disable-theme (car custom-enabled-themes))
	;; (load-theme k8x1d/default-emacs-dark-theme t)))
	(load-theme k8x1d/default-emacs-theme t)))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config)
  )

(use-package emacs
  :hook (after-init . window-divider-mode)
  :init
  (require 'doom-themes)
  (defun k8x1d/set-window-divider-colors ()
    (custom-set-faces
     `(window-divider ((t :foreground ,(doom-color 'green))))
     )
    )
  (k8x1d/set-window-divider-colors)
  :config
  (setq window-divider-default-places t)
  (setq window-divider-default-bottom-width 1)
  (setq window-divider-default-right-width 1)
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


;; Keybindings
(use-package doom-themes
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "s"  '(:ignore t :which-key "Emacs")
    "st" '(k8x1d/switch-theme :which-key "Switch Light/Dark")
    "S"  '(:ignore t :which-key "System")
    "Sl" '(k8x1d/switch-system-theme-to-light :which-key "Light theme")
    "Sd" '(k8x1d/switch-system-theme-to-dark :which-key "Dark theme")
   )
  )



;;; REWRITE ;;;;
(defun k8x1d/set-gui-colors ()
  (custom-set-faces
   ;; General gui
   `(window-divider ((t :foreground ,(doom-color 'green))))

   ;; Org
   `(org-block ((t (:background ,(doom-color 'bg-alt)))))
   `(org-quote ((t (:background ,(doom-color 'bg-alt)))))

   )
  )

(defun k8x1d/set-org-src-colors-per-language ()
  (require 'org)
  (setq org-src-block-faces
	`(("emacs-lisp" (:background ,(doom-color 'magenta)))
	  ("python" (:background ,(doom-color 'blue)))
	  ("julia" (:background ,(doom-color 'magenta)))))
  )

(defun k8x1d/set-org-modern-colors ()
    (require 'org-modern)
    (setq org-modern-todo-faces
	  `(("TODO" :background ,(doom-color 'red) :foreground ,(doom-color 'bg) :family "Iosevka Nerd Font")
	    ("NEXT" :background ,(doom-color 'green) :foreground ,(doom-color 'bg)  :family "Iosevka Nerd Font")
	    ("WAIT" :background ,(doom-color 'yellow) :foreground ,(doom-color 'bg)  :family "Iosevka Nerd Font")))
    (setq org-modern-priority-faces
	  `((?A :background ,(doom-color 'green)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?B :background ,(doom-color 'orange)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?C :background ,(doom-color 'red)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")))
    (setq org-modern-symbol
	  `((?X :background ,(doom-color 'green)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?- :background ,(doom-color 'orange)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")
	    (?\s :background ,(doom-color 'red)
		:foreground ,(doom-color 'bg)
		:family "Iosevka Nerd Font")))
    )


(defun k8x1d/switch-theme ()
  (interactive)
  (if (string= (car custom-enabled-themes) k8x1d/default-emacs-dark-theme)
      (progn
	;; (consult-theme k8x1d/default-light-theme)
	(disable-theme (car custom-enabled-themes))
	(load-theme k8x1d/default-emacs-light-theme t)
	(k8x1d/set-frame-opacity 90)
	)
    (progn
      ;; (consult-theme k8x1d/default-dark-theme)
      (disable-theme (car custom-enabled-themes))
      (load-theme k8x1d/default-emacs-dark-theme t)
      (k8x1d/set-frame-opacity 80)
      )
    )
  (k8x1d/set-gui-colors)
  (k8x1d/set-org-modern-colors)
  (k8x1d/set-org-src-colors-per-language)
  )


(provide 'theme-module)
;;; theme-module.el ends here
