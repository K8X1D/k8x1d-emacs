;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package dashboard
  ;; :hook (after-init . (lambda () (dashboard-setup-startup-hook)
  ;; ))
  ;; :init
  ;; ;; Daemon compatibility
  ;; (setq initial-buffer-choice (lambda ()
  ;; 				(get-buffer-create "*dashboard*")
  ;; 				(dashboard-refresh-buffer) ;; ensure that key shortcut work and line-number don't appears
  ;; 				))
  :bind
  ("C-c d" .'dashboard-refresh-buffer)
  :config
  ;; Banner
  (setq dashboard-startup-banner (concat user-emacs-directory "/banners/k8x1d-avatar_dark.png"))
  (setq dashboard-banner-logo-title "Welcome to K8X1d Emacs Dashboard!")
  ;; Icons
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
  ;; Faces
  (custom-set-faces
   `(dashboard-items-face ((t (:inherit widget-button :height 1.0))))
   `(dashboard-heading ((t (:inherit font-lock-keyword-face :height 1.0))))
   )
  (setq dashboard-page-separator "\n\f\n")
  ;; Problem, see https://github.com/emacs-dashboard/emacs-dashboard/issues/459
  ;; (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-projects-backend 'project-el)
  ;; Agenda configuration
  (setq dashboard-week-agenda t)
  (setq dashboard-item-names '(("Agenda for the coming week:" . "Agenda:")))
  (setq dashboard-match-agenda-entry "CATEGORY={Recherches}|CATEGORY={Implications}|CATEGORY={Emplois}|CATEGORY={Développements}|CATEGORY={Finances}")
  (setq dashboard-items '(
			  ;; (recents  . 5)
			  ;; (bookmarks . 5)
			  ;;			  (projects . 5)
			  (agenda . 10)
			  ))
  (setq dashboard-week-agenda t)
  (setq dashboard-agenda-sort-strategy '(time-up))
  (setq dashboard-center-content t)

  ;; Navigator configuration
  (setq dashboard-set-navigator t)
  (setq dashboard-navigator-buttons
 	`(
 	  ;; line1
 	  (
 	   ;; Gitlab homepage
 	   (,(nerd-icons-faicon "nf-fa-gitlab" :height 1.1 :v-adjust 0.0)
 	    ""
 	    ""
 	    (lambda (&rest _) (browse-url "https://gitlab.com/K8X1D")))
 	   ;; Linkedin
 	   (,(nerd-icons-faicon "nf-fa-linkedin" :height 1.1 :v-adjust 0.0)
 	    ""
 	    ""
 	    (lambda (&rest _) (browse-url "https://www.linkedin.com/in/kevin-kaiser-9b3699279/")))
 	   ;; Twitter
 	   (,(nerd-icons-faicon "nf-fa-twitter" :height 1.1 :v-adjust 0.0)
 	    ""
 	    ""
 	    (lambda (&rest _) (browse-url "https://twitter.com/K8X1D")))
 	   ;; Mastodon
 	   (,(nerd-icons-mdicon "nf-md-mastodon" :height 1.1 :v-adjust 0.0)
 	    ""
 	    ""
 	    (lambda (&rest _) (browse-url "https://mastodon.online/@k8x1d")))
 	   )

	  ))
  (setq dashboard-footer-messages '(
 				    "1937: Publication of Dobzhansky's 'Genetics and the Origin of Species, \n primer of Modern Synthesis"
 				    "'En effet, les divisions que nous établissons entre nos sciences, sans être arbitraires, comme quelques-uns le croient, sont essentiellement artificielles.
  En réalité, le sujet de toutes nos recherches est un ; nous ne le partageons que dans la vue de séparer les difficultés pour les mieux résoudre.
  Il en résulte plus d’une fois que, contrairement à nos répartitions classiques, des questions importantes exigeraient une certaine combinaison de plusieurs points de vue spéciaux,
  qui ne peut guère avoir lieu dans la constitution actuelle du monde savant ; ce qui expose à laisser ces problèmes sans solution beaucoup plus longtemps qu’il ne serait nécessaire.'
  Auguste Comte, Cours de philosophie positive (1830, 1ère leçon)"
 				    "'That’s a great deal to make one word mean,”Alice said in a thougthful tone.
  'When I make a work do a lot of work like that,' said Humpty Dumpty, 'I always pay it extra.''
  Lewis Carroll, Alice in Wonderland (1865), cité par Klein (1990, p. 55)"

 				    "‘alles is overal : maar het milieu selecteert’ [Everything is everywhere, but, the environment selects].
  Lourens Gerhard Marinus Baas Becking, Geobiologie of inleiding tot de milieukunde (1934, p. 15)"


                                    "Socratic paradox (one version) \n 'I know that I know nothing' \n derived from 'For I was conscious that I knew practically nothing...' \n (Plato, Apology 22d, translated by Harold North Fowler, 1966)."

 				    ))
  (dashboard-setup-startup-hook)
  )


(use-package page-break-lines
  :hook
  (after-init . global-page-break-lines-mode))

(provide 'dashboard-module)
;;; dashboard-module.el ends here
