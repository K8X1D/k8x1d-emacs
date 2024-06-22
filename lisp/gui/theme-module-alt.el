;;; package --- Summary-*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;; REWRITE ;;;;

(use-package doom-themes
  :init 
  (setq k8x1d/default-emacs-theme k8x1d/default-emacs-dark-theme)
  :hook (after-init . (lambda ()
			(disable-theme (car custom-enabled-themes))
			(load-theme k8x1d/default-emacs-theme t)
			(k8x1d/adjust-theme-colors)
			))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  )



(require 'doom-themes)

(defun k8x1d/set-gui-colors ()
  (custom-set-faces
   ;; General gui
   `(window-divider ((t :foreground ,(doom-color 'green))))

   ;; Org
   `(org-block ((t (:background ,(doom-color 'bg-alt)))))
   `(org-quote ((t (:background ,(doom-color 'bg-alt)))))
   `(org-block-begin-line ((t (:foreground ,(doom-color 'green) :background ,(doom-color 'bg)))))
   `(org-block-end-line ((t (:foreground ,(doom-color 'green) :background ,(doom-color 'bg)))))
   `(org-meta-line ((t (:foreground ,(doom-color 'green)))))
   `(org-agenda-clocking ((t (:weight bold :inverse-video t :background nil))))
   `(org-imminent-deadline ((t (:weight normal)))) 
   `(org-modern-done ((t (:background ,(doom-color 'bg-alt) :foreground ,(doom-color 'bg) :family "Iosevka Nerd Font"))))

   ;; Consult
   `(orderless-match-face-0 ((t (:foreground ,(doom-color 'green) :background ,(doom-color 'bg) :weight bold))))

   ;; Anzy
   `(anzu-mode-line ((t (:foreground ,(doom-color 'green)))))
   `(anzu-mode-line-no-match ((t (:foreground ,(doom-color 'red)))))

   ;; Hl-todo
   `(hl-todo ((t (:foreground ,(doom-color 'red)))))

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


(defun k8x1d/adjust-theme-colors ()
  (k8x1d/set-gui-colors)
  (k8x1d/set-org-modern-colors)
  ;; (k8x1d/set-org-src-colors-per-language)
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
  (k8x1d/adjust-theme-colors)
  )



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



(use-package emacs
  :hook (after-init . window-divider-mode)
  :config
  (setq window-divider-default-places t)
  (setq window-divider-default-bottom-width 1)
  (setq window-divider-default-right-width 1)
  )


(provide 'theme-module-alt)
;;; theme-module.el ends here
