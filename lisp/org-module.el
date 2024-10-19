;; -*- lexical-binding: t; -*-

;; TODO: explore https://lucidmanager.org/productivity/ricing-org-mode/

;; General configuration
(use-package org
  :general
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "t" '(org-todo :which-key "Todo cycle")
    "i" '(:ignore t :which-key "Insert")
    "id" '(org-deadline :which-key "Deadline")
    "is" '(org-schedule :which-key "Schedule")
    "i." '(org-timestamp :which-key "Timestamp")
    "i," '(org-insert-structure-template :which-key "Template")
    "c" '(:ignore t :which-key "Clock")
    "ci" '(org-clock-in :which-key "In")
    "co" '(org-clock-out :which-key "Out")
    )
  )

;; Indentation
(use-package org-indent
  :ensure nil
  :diminish
  :hook
  (org-mode . org-indent-mode)
  )

;; Agenda configuration
(use-package org-agenda
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "oa"  '(org-agenda :which-key "Agenda")
    )
  :ensure nil
  :bind
  ("C-c o a" . org-agenda)
  :config
  (setq org-agenda-files k8x1d/org-agenda-files)
  ;; (setq org-agenda-files k8x1d/agenda-files
  ;; 	'("~/org/projects/implications.org"
  ;; 	"~/org/projects/bin.org"
  ;;       "~/org/projects/doctorat.org"
  ;;       "~/org/projects/developpements.org"
  ;;       "~/org/projects/articles.org"
  ;;       "~/org/projects/financements.org"
  ;;       "~/org/projects/administratifs.org"
  ;;       "~/org/projects/machines.org"
  ;;       "~/org/projects/evocult.org"
  ;;       "~/org/projects/recherches.org"
  ;;       "~/org/projects/contrats.org"
  ;;       "~/org/projects/presentations.org"
  ;;       "~/org/projects/vulgarisation.org"
  ;;       ;; "~/org/Horaire.org"
  ;;       "~/org/Inbox.org"
  ;;       "~/org/Habits.org")) ;; org-agenda files

  ;; Don't show tasks if already done
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-timestamp-if-done t)
  (setq org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)) ;; really ensure that done are not shown, see https://stackoverflow.com/questions/8281604/remove-done-tasks-from-agenda-view

  ;; Habit configuration
  (setq org-habit-preceding-days 7)
  (setq org-habit-following-days 3) 
  (setq org-habit-graph-column 17) 

  ;; Reduce redundancy
  (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
  (setq org-agenda-skip-scheduled-delay-if-deadline t)
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
  (setq org-agenda-skip-scheduled-repeats-after-deadline t)
  (setq org-agenda-skip-timestamp-if-deadline-is-shown t)
  (setq org-agenda-show-future-repeats t) 

  ;; Initial agenda
  (setq org-agenda-span 'day) ;; span
  (setq org-agenda-inhibit-startup t)
  (setq org-agenda-window-setup 'current-window) ;; take the whole buffer
  (setq org-agenda-start-on-weekday 0) ;; start agenda on sunday

  (setq org-agenda-prefix-format '(
				   (agenda . " %i %-15c%-18t [󰔟%-4s |󰿖 %-3e] ")
				   (todo . " %i %-12:c")
				   (tags . " %i %-12:c")
				   (search . " %i %-12:c")
				   ))
  (setq org-agenda-todo-keyword-format "%-4s ")
  (setq org-agenda-log-mode-items '(closed))
  (setq org-agenda-sorting-strategy '((agenda time-up priority-down category-up tag-up habit-down )))
  )

;; GTD configuration
(use-package org
  :general
  (k8x1d/leader-keys
   "X"  '(org-capture :which-key "Capture")
    )
  :config
  ;; Capture
  (setq org-directory "~/org")
  (setq org-refile-targets
	'((nil :maxlevel . 3)
	  (org-agenda-files :maxlevel . 3)))
  (setq org-refile-use-outline-path t
	org-outline-path-complete-in-steps nil)
  (setq org-refile-use-cache t)
  (setq org-default-notes-file (concat k8x1d/notes-directory "/notes_frame13.org"))
  (setq org-capture-templates
	'(("t" "Todo" entry (file (lambda () (concat k8x1d/inbox-directory "/inbox-frame13.org")))
	   "* TODO %?\n")
	  ;; To write: 
	  ;; see https://orgmode.org/manual/Capture-templates.html
	  ;; ("p" "Project" entry (file+function "~/org/projects.org" k8x1d/get-project-name)
	  ;;  "*  %?\n  %i\n")
	  ;; Calendars
	  ("c" "Calendars")
	  ("cr" "Recherches" entry (file (lambda () (concat k8x1d/calendars-directory "/recherche.org"))) "* %?\n%^T")
	  ("cs" "Social" entry (file (lambda () (concat k8x1d/calendars-directory "/social.org"))) "* %?\n%^T")
	  ("ci" "Implications" entry (file (lambda () (concat k8x1d/calendars-directory "/implications.org"))) "* %?\n%^T")
	  ("cf" "Formations" entry (file (lambda () (concat k8x1d/calendars-directory "/formations.org"))) "* %?\n%^T")
	  ("cE" "Exercices" entry (file (lambda () (concat k8x1d/calendars-directory "/exercices.org"))) "* %?\n%^T")
	  ("ce" "Emplois" entry (file (lambda () (concat k8x1d/calendars-directory "/emplois.org"))) "* %?\n%^T")
	  ("cd" "Développement" entry (file (lambda () (concat k8x1d/calendars-directory "/developpements.org"))) "* %?\n%^T")
	  ;; Notes
	  ("n" "Notes" entry (file+function (lambda () (concat k8x1d/notes-directory "/notes_frame13.org"))  "Notes")
	   "* %U %?\n")))



  ;; Don't break window layout when suggestion todo state option
  (setq org-use-fast-todo-selection 'expert)
  (setq org-src-window-setup 'split-window-below) 

  (setq org-enforce-todo-dependencies t)
  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCL(c)")))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Gui (modern) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org-modern
  :if (string= k8x1d/org-gui "org-modern")
  :init
  (defun k8x1d/set-org-colors ()
    (require 'org-modern)
     (setq org-modern-todo-faces
           '(("TODO" :background "darkred" :foreground "white" :family "Iosevka Nerd Font" :weight 'semibold)
             ("NEXT" :background "darkgreen" :foreground "white" :family "Iosevka Nerd Font" :weight 'semibold)
             ("WAIT" :background "yellow4" :foreground "white" :family "Iosevka Nerd Font" :weight 'semibold)
             ("DONE" :background "grey" :foreground "white" :family "Iosevka Nerd Font" :weight 'semibold)
             ("CNCL" :background "grey" :foreground "white" :family "Iosevka Nerd Font" :weight 'semibold)
	     ))
    ;; ;; (setq org-modern-priority-faces
    ;;       `((?A :background ,(doom-color 'green)
    ;;             :foreground ,(doom-color 'bg)
    ;;             :family "Iosevka Nerd Font")
    ;;         (?B :background ,(doom-color 'orange)
    ;;             :foreground ,(doom-color 'bg)
    ;;             :family "Iosevka Nerd Font")
    ;;         (?C :background ,(doom-color 'red)
    ;;             :foreground ,(doom-color 'bg)
    ;;             :family "Iosevka Nerd Font")))
     (setq org-modern-symbol
           `((?X :background "darkgreen"
                 :foreground "white"
                 :family "Iosevka Nerd Font")
             (?- :background "darkorange"
                 :foreground "white"
                 :family "Iosevka Nerd Font")
             (?\s :background "darkred"
                  :foreground "white"
                  :family "Iosevka Nerd Font")))

     (setq org-modern-checkbox '((?X . #("󰄲 " 0 2 (composition ((3)))))
				 (?- . #("󱋬 " 0 2 (composition ((3)))))
				 (?\s . #("󰄮 " 0 2 (composition ((3)))))))
    )
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  ;; :custom-face
  ;; (org-modern-todo ((t (:inherit t :height 0.9 :weight semibold :family "Iosevka Nerd Font"))))
  ;; (org-modern-done ((t (:inherit t :height 0.9 :weight semibold :family "Iosevka Nerd Font"))))
  :config
  ;; Org block
  (setq org-modern-block-fringe t)
  ;; Bullets
  (setq org-modern-fold-stars '(("󰻃" . "󰄰")))
  ;; Todos
  (setq org-modern-todo t)
  
  ;; Table 
  (setq org-modern-table t)
  (setq org-modern-table-vertical 0.0) ;; truly hide
  (setq org-modern-table-horizontal 0.1)
  ;; Checkbox
  (setq org-modern-checkbox '((?X . "󰄲 ")
			      (?- . "󱋬 ")
			      (?\s . "󰄮 ")))
  )

;; Better indentation for org-modern
(use-package org-modern-indent
  :if (string= k8x1d/org-gui "org-modern")
  :hook
  (org-modern-mode . org-modern-indent-mode)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org gui (custom)  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package emacs
  :if (string= k8x1d/org-gui "custom")
  :config
  (defun k8x1d/set-org-colors ()
    (custom-set-faces
     ;; Adapted from org-modern-label
     `(org-todo ((t (:weight semibold :height 1.0 :width wide :underline nil :family "Iosevka Nerd Font" :foreground ,(doom-color 'red)))))
     `(org-done ((t (:weight semibold :height 1.0 :width wide :underline nil :family "Iosevka Nerd Font" :foreground ,(doom-color 'grey)))))
     `(org-table ((nil (:inherit 'fixed-pitch))))
     )
    )
  )


;; Improve org mode looks
(use-package org
  :config
  (setq org-startup-indented t
	org-pretty-entities t
	org-use-sub-superscripts "{}"
	org-hide-emphasis-markers t
	;; org-startup-with-inline-images t
	;; org-image-actual-width '(300))
	)
  (setq org-image-actual-width nil)
  (setq org-tags-column 0)
  )

;; Bullets
(use-package org-superstar
  :if (string= k8x1d/org-gui "custom")
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '(9673 9675 10040))
  (setq org-superstar-item-bullet-alist '((42 . 8226) (43 . 10148) (45 . 8211)))
  )

;; Markup
(use-package org-appear
  :hook
  (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t)
  (setq org-appear-autolinks t)
  (setq org-appear-autosubmarkers t)
  (setq org-appear-autoentities t)
  (setq org-appear-autokeywords t)
  (setq org-appear-inside-latex t)
  (setq org-appear-delay 0.0)
  (setq org-appear-trigger #'always)
  )

;; Latex support
(use-package org
  :config
  (setq org-preview-latex-default-process 'dvipng))


;; Automatic table of content
(use-package toc-org
  :hook
  (org-mode . toc-org-mode))

(provide 'org-module)
