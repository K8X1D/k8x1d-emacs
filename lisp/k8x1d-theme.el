(use-package emacs
  :bind
  ("<f5>" . 'modus-themes-toggle)
  :hook 
  (after-init . (lambda ()
		  (load-theme 'modus-vivendi)
		  ))
  :config
  ;; Color customizations 
  (setq modus-vivendi-palette-overrides
	`((bg-main "#282828")
	  (fg-main "#ebdbb2")
	  (fg-dim "#ebdbb2")
	  (bg-dim "#282828")
	  (bg-active "#504945"))
	modus-operandi-palette-overrides
	`((bg-main "#ebdbb2")
	  (fg-main "#282828")
	  (fg-dim "#282828")
	  (bg-dim "#ebdbb2")
	  (bg-active "#bdae93"))
	)


  ;; Org block customization 
  (setq modus-themes-org-blocks 'tinted-background)
 ;; (with-eval-after-load 'org
 ;; ;;  (setq org-src-block-faces (cons org-src-block-faces 
 ;; ;;				    '(("julia" (:inherit modus-themes-subtle-magenta :extend t)))
 ;; ;;				    ;;'(("julia-vterm" (:inherit modus-themes-subtle-magenta :extend t)))
 ;;   (setq org-src-block-faces
 ;;     `(("emacs-lisp" modus-themes-nuanced-magenta)
 ;;	("elisp" modus-themes-nuanced-magenta)
 ;;	("clojure" modus-themes-nuanced-magenta)
 ;;	("clojurescript" modus-themes-nuanced-magenta)
 ;;	("c" modus-themes-nuanced-blue)
 ;;	("c++" modus-themes-nuanced-blue)
 ;;	("julia" modus-themes-nuanced-magenta)
 ;;	("julia-vterm" modus-themes-nuanced-magenta)
 ;;	("sh" modus-themes-nuanced-green)
 ;;	("shell" modus-themes-nuanced-green)
 ;;	("html" modus-themes-nuanced-yellow)
 ;;	("xml" modus-themes-nuanced-yellow)
 ;;	("css" modus-themes-nuanced-red)
 ;;	("scss" modus-themes-nuanced-red)
 ;;	("python" modus-themes-nuanced-green)
 ;;	("ipython" modus-themes-nuanced-magenta)
 ;;	("r" modus-themes-nuanced-cyan)
 ;;	("yaml" modus-themes-nuanced-cyan)
 ;;	("conf" modus-themes-nuanced-cyan)
 ;;	("docker" modus-themes-nuanced-cyan)))
 ;;   )


  (setq modus-themes-variable-pitch-ui nil)

  (setq modus-themes-completions
	'((matches . (extrabold))
	  (selection . (semibold))))

  (setq modus-themes-custom-auto-reload nil
	modus-themes-to-toggle '(modus-operandi modus-vivendi)
	modus-themes-mixed-fonts t
	modus-themes-italic-constructs t
	modus-themes-bold-constructs nil
	modus-themes-prompts nil
	modus-themes-headings
	'(;; Agenda
	  (agenda-structure . (variable-pitch light 2.0))
	  (agenda-date . (variable-pitch regular 1.3))
	  ;; Levels
	  (1 . (variable-pitch 1.5))
	  (2 . (variable-pitch 1.2))
	  (3 . (variable-pitch 1.1))
	  (t . (regular 1.15))))

  ;; Tmp fix for daemon mode
  ;; see https://github.com/protesilaos/modus-themes/issues/7
  (add-to-list 'after-make-frame-functions #'(lambda (x) (load-theme 'modus-vivendi))) 
  )




(provide 'k8x1d-theme)
