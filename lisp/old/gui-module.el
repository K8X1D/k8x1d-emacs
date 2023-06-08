;;
;; Graphical user interface
;;

;; Theme
(use-package doom-themes
  :defer t
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


  ;; Customizations
  (custom-set-faces
   `(cursor ((t (:background ,(doom-color 'fg)))))
   `(org-todo-keyword-faces
     '(("WAITING" . (:foreground ,(doom-color 'yellow)))
       ("CANCELLED" . (:foreground ,(doom-color 'red)))))
   `(corfu-current ((t (:background ,(doom-color 'red)))))
   )


;; Modeline
(use-package doom-modeline
  :defer t
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-enable-word-count t)
  ;;(setq doom-modeline-workspace-name nil) ;; use tab instead
  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-buffer-encoding nil))

;; Pool minor modes
(use-package minions
  :defer t
  :hook
  (doom-modeline-mode . minions-mode))

;; Icons
(use-package all-the-icons
  :defer t
  :if (display-graphic-p))

;; Smoother scrolling (>= 29)
(add-hook 'after-init-hook 'pixel-scroll-precision-mode)

;; Highlight current line
(add-hook 'after-init-hook 'global-hl-line-mode)

;; Fonts
(use-package mixed-pitch
  :defer t
  :init
  (set-face-attribute 'default nil :font "Iosevka Term" :weight 'normal :height 150)
  (set-face-attribute 'fixed-pitch nil :font "Iosevka Term" :weight 'normal :height 180)
  ;;(set-face-attribute 'variable-pitch nil :font "DejaVu Sans" :weight 'normal :height 1.5)
  (set-face-attribute 'variable-pitch nil :font "Iosevka Aile" :weight 'normal :height 1.5)
  :hook
  (text-mode . mixed-pitch-mode)
  )


;; always allow 'y' instead of 'yes'.
(add-hook 'after-init-hook (lambda ()
			     (defalias 'yes-or-no-p 'y-or-n-p)))



;; Show key
(use-package which-key
  :defer t
  :hook
  (after-init . which-key-mode)
  )


;; Highlight todos
(use-package hl-todo
  :hook
  (after-init . global-hl-todo-mode)
  :config
  (define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
  (define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
  (define-key hl-todo-mode-map (kbd "C-c i") 'hl-todo-insert)
  (setq hl-todo-keyword-faces
	'(("TODO"   . "#FF0000")
	  ("FIXME"  . "#FF0000")
	  ("DEBUG"  . "#A020F0")
	  ("GOTCHA" . "#FF4500")
	  ("STUB"   . "#1E90FF"))))


;; General mode caracteristics
(use-package emacs
  :config
  ;; Defaults browser
  (setq browse-url-browser-function 'browse-url-generic
	browse-url-generic-program "firefox")
  ;; follow symlinks 
  (setq vc-follow-symlinks t)
  ;; ibuffer instead of buffer-menu
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  ;; Tabs
  (setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
 ;; (setq tab-bar-close-button-show nil
 ;;	tab-bar-new-button-show nil
 ;;	tab-bar-auto-width nil)

 ;; (setq tab-bar-separator " | ")
 ;; (custom-set-faces
 ;;  '(tab-bar ((t (:inherit nil :background "#282828" :foreground "#928374" :height 1.0))))
 ;;  '(tab-bar-tab ((t (:background "#282828" :foreground "#ebdbb2":weight bold :underline t))))
 ;;  )
  )


;;
;; Dashboard
;;

(use-package dashboard
  :bind
  ("C-c d" .'dashboard-refresh-buffer)
  :config
  ;; Faces
  (custom-set-faces
   `(dashboard-items-face ((t (:inherit widget-button :height 0.85))))
   `(dashboard-heading ((t (:inherit font-lock-keyword-face :height 0.9))))
   )
  (setq dashboard-startup-banner "~/Pictures/Personnel/k8x1d-avatar/k8x1d-avatar_200x145.png")
  ;;(setq dashboard-startup-banner 'logo) 
  (setq dashboard-banner-logo-title "Welcome to K8X1d Emacs Dashboard!")
  (setq dashboard-banner-logo-title "")
  (setq dashboard-match-agenda-entry "-main-mont-bud")
  (setq dashboard-page-separator "\n\f\n")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;;(setq dashboard-set-navigator t)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-items '((recents  . 4)
			  (bookmarks . 4)
			  (projects . 4)
			  (agenda . 4)))
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook))

(use-package page-break-lines
  :hook
  (after-init . global-page-break-lines-mode))


;; Alt
;;(use-package narumi
;;  :config
;;  (setq narumi-image-directory "~/Pictures/wallpapers/paintings/Cathy_Bible"))

(provide 'gui-module)
