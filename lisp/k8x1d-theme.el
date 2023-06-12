;;(use-package emacs
;;  :bind
;;  ("<f5>" . 'modus-themes-toggle)
;;  :hook 
;;  (after-init . (lambda ()
;;		  (load-theme 'modus-vivendi)
;;		  ))
;;  :config
;;  ;; Color customizations 
;;  (setq modus-vivendi-palette-overrides
;;	`((bg-main "#282828")
;;	  (fg-main "#ebdbb2")
;;	  (fg-dim "#ebdbb2")
;;	  (bg-dim "#282828")
;;	  (bg-active "#504945")
;;	  ;; Modeline
;;	  (bg-mode-line-active        "#ebdbb2")
;;	  (fg-mode-line-active        "#282828")
;;	  (border-mode-line-active    "#5a5a5a")
;;	  (bg-mode-line-inactive      "#e6e6e6")
;;	  (fg-mode-line-inactive      "#585858")
;;	  (border-mode-line-inactive  "#a3a3a3")
;;	  )
;;	modus-operandi-palette-overrides
;;	`((bg-main "#ebdbb2")
;;	  (fg-main "#282828")
;;	  (fg-dim "#282828")
;;	  (bg-dim "#ebdbb2")
;;	  (bg-active "#bdae93")
;;	  ;; Modeline
;;	  (bg-mode-line-active        "#282828")
;;	  (fg-mode-line-active        "#ebdbb2")
;;	  (border-mode-line-active    "#282828")
;;	  (bg-mode-line-inactive      "#e6e6e6")
;;	  (fg-mode-line-inactive      "#585858")
;;	  (border-mode-line-inactive  "#a3a3a3")
;;	  )
;;	)
;;
;;
;;
;;
;;  ;; Org block customization 
;;  (setq modus-themes-org-blocks 'tinted-background)
;; ;; (with-eval-after-load 'org
;; ;; ;;  (setq org-src-block-faces (cons org-src-block-faces 
;; ;; ;;				    '(("julia" (:inherit modus-themes-subtle-magenta :extend t)))
;; ;; ;;				    ;;'(("julia-vterm" (:inherit modus-themes-subtle-magenta :extend t)))
;; ;;   (setq org-src-block-faces
;; ;;     `(("emacs-lisp" modus-themes-nuanced-magenta)
;; ;;	("elisp" modus-themes-nuanced-magenta)
;; ;;	("clojure" modus-themes-nuanced-magenta)
;; ;;	("clojurescript" modus-themes-nuanced-magenta)
;; ;;	("c" modus-themes-nuanced-blue)
;; ;;	("c++" modus-themes-nuanced-blue)
;; ;;	("julia" modus-themes-nuanced-magenta)
;; ;;	("julia-vterm" modus-themes-nuanced-magenta)
;; ;;	("sh" modus-themes-nuanced-green)
;; ;;	("shell" modus-themes-nuanced-green)
;; ;;	("html" modus-themes-nuanced-yellow)
;; ;;	("xml" modus-themes-nuanced-yellow)
;; ;;	("css" modus-themes-nuanced-red)
;; ;;	("scss" modus-themes-nuanced-red)
;; ;;	("python" modus-themes-nuanced-green)
;; ;;	("ipython" modus-themes-nuanced-magenta)
;; ;;	("r" modus-themes-nuanced-cyan)
;; ;;	("yaml" modus-themes-nuanced-cyan)
;; ;;	("conf" modus-themes-nuanced-cyan)
;; ;;	("docker" modus-themes-nuanced-cyan)))
;; ;;   )
;;
;;
;;  (setq modus-themes-variable-pitch-ui nil)
;;
;;  (setq modus-themes-completions
;;	'((matches . (extrabold))
;;	  (selection . (semibold))))
;;
;;  (setq modus-themes-custom-auto-reload nil
;;	modus-themes-to-toggle '(modus-operandi modus-vivendi)
;;	modus-themes-mixed-fonts t
;;	modus-themes-italic-constructs t
;;	modus-themes-bold-constructs nil
;;	modus-themes-prompts nil
;;	modus-themes-headings
;;	'(;; Agenda
;;	  (agenda-structure . (variable-pitch light 2.0))
;;	  (agenda-date . (variable-pitch regular 1.3))
;;	  ;; Levels
;;	  (1 . (variable-pitch 1.5))
;;	  (2 . (variable-pitch 1.2))
;;	  (3 . (variable-pitch 1.1))
;;	  (t . (regular 1.15))))
;;
;;  ;; Tmp fix for daemon mode
;;  ;; see https://github.com/protesilaos/modus-themes/issues/7
;;  (add-to-list 'after-make-frame-functions #'(lambda (x) (load-theme 'modus-vivendi))) 
;;  )






(use-package doom-themes
  :init
  (defvar k8x1d/doom-dark-theme 'doom-gruvbox)
  (defvar k8x1d/doom-light-theme 'doom-gruvbox-light)
  (defvar k8x1d/actual-theme k8x1d/doom-dark-theme)

  (defun k8x1d/switch-theme (old-theme new-theme)
    (disable-theme old-theme)
    (load-theme new-theme t)
    (setq k8x1d/actual-theme new-theme))

  (defun k8x1d/dark-to-light-to-dark ()
    (interactive)
    (if (eq k8x1d/actual-theme k8x1d/doom-dark-theme)
	(k8x1d/switch-theme k8x1d/doom-dark-theme k8x1d/doom-light-theme)
      (k8x1d/switch-theme k8x1d/doom-light-theme k8x1d/doom-dark-theme)))
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
  (setq doom-gruvbox-brighter-comments t)
  )


(provide 'k8x1d-theme)
