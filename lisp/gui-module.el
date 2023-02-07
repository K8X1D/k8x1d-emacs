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
  ;; Enable custom treemacs theme (all-the-icons must be installed!)
  (setq doom-themes-treemacs-theme "doom-gruvbox") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(custom-set-faces
 `(cursor ((t (:background ,(doom-color 'fg)))))
`(org-todo-keyword-faces
      '(("WAITING" . (:foreground ,(doom-color 'yellow)))
        ("CANCELLED" . (:foreground ,(doom-color 'red)))))

 )


;; Modeline
(use-package doom-modeline
  :defer t
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-workspace-name nil) ;; use tab instead
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
  (set-face-attribute 'default nil :font "DejaVu Sans Mono" :weight 'normal :height 150)
  (set-face-attribute 'fixed-pitch nil :font "DejaVu Sans Mono" :weight 'normal :height 180)
  (set-face-attribute 'variable-pitch nil :font "DejaVu Sans" :weight 'normal :height 1.5)
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



;; General mode caracteristics
(use-package emacs
  :defer t
  :config
  ;; Defaults browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")
  ;; follow symlinks 
  (setq vc-follow-symlinks t)
  ;; ibuffer instead of buffer-menu
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  ;; Tabs
  ;;(setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-close-button-show nil
	tab-bar-new-button-show nil
	tab-bar-auto-width nil)

  (setq tab-bar-separator " | ")
  (custom-set-faces
   '(tab-bar ((t (:inherit nil :background "#282828" :foreground "#928374" :height 1.0))))
   '(tab-bar-tab ((t (:background "#282828" :foreground "#ebdbb2":weight bold :underline t))))
   )
  )



(provide 'gui-module)
