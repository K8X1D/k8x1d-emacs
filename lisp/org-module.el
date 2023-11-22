;;; package --- Summary

;;; Commentary:

;;; Code:


;; Org
(use-package org
  :bind
  ("C-c l" . org-store-link)
  :hook
  ((org-mode . org-indent-mode)
   (org-mode . visual-line-mode))
  :config
  ;; (setq org-directory "~/org")

  ;; Export options
  (require 'ox-md nil t) ;; md
  (require 'ox-odt nil t) ;; odt
  )


;; Export to github md
(use-package ox-gfm
  :after org
  :hook (org-mode . (lambda ()  (require 'ox-gfm nil t))) 
  )

;; Org agenda
(use-package org
  :bind ("C-c o a" . org-agenda)
  :config
  ;; org-agenda
  (setq org-agenda-files '("~/org/inbox.org"
			   "~/org/projects.org"
			   "~/org/notes.org"
			   "~/org/habits.org"
			   ))
  ;; take the whole buffer
  (setq org-agenda-window-setup 'current-window)
  ;; Show 10 day (3 before, 7 after)
  (setq
   org-agenda-span 10
   org-agenda-start-on-weekday nil
   org-agenda-start-day "-3d")
  ;; Optimize startup
  (setq org-agenda-inhibit-startup t)
  ;; Clean-up
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)
  )

;; Evil support
(use-package evil-org
  :after org
  :bind ([remap org-agenda-show-tags] . evil-tab-next)
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
  (evil-org-agenda-set-keys)
  )

;; Org gtd
(use-package org
  :bind ("C-c c" . org-capture)
  :config
  (setq org-refile-use-outline-path t
	org-outline-path-complete-in-steps nil)
  (setq org-refile-use-cache t)
  (setq org-refile-targets
	'(("~/org/inbox.org" :maxlevel . 5)
	  ("~/org/projects.org" :maxlevel . 5)
	  ("~/org/notes.org" :maxlevel . 5)
	  ))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCL(c)")))
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
	   "* TODO %?\n  %i\n")
	  ("n" "Notes" entry (file+headline "~/org/notes.org"  "Notes")
	   "* %U %?\n")))
  (setq org-enforce-todo-dependencies t)
  (setq org-enforce-todo-checkbox-dependencies t)
  )


;; Org-appear
(use-package org-appear
  
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (add-hook 'evil-insert-state-entry-hook
				       #'org-appear-manual-start
				       nil
				       t)
			     (add-hook 'evil-insert-state-exit-hook
				       #'org-appear-manual-stop
				       nil
				       t)))
  :hook
  (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t
	org-appear-trigger 'manual
	;;org-appear-trigger 'always
	org-appear-autoentities t
	org-appear-autosubmarkers t
	org-appear-autokeywords t
	org-appear-inside-latex t
	org-appear-autoemphasis t
	org-appear-autolinks t)
  )


;; Org esthetics
(use-package org-modern
  :after doom-themes
  :hook ((org-mode . org-modern-mode)
	 (org-agenda-finalize . org-modern-agenda))
  :config
  (setq org-modern-table nil)

  ;; Edit settings
  (setq org-auto-align-tags nil)
  (setq org-tags-column 0)
  (setq org-fold-catch-invisible-edits 'show-and-error)
  (setq org-special-ctrl-a/e t)
  (setq org-insert-heading-respect-content t)

  ;; Org styling, hide markup etc.
  (setq org-pretty-entities nil)
  (setq org-ellipsis "…")

  ;; Agenda styling
  (setq org-agenda-tags-column 0)
  (setq org-agenda-block-separator ?─)
  (setq org-agenda-time-grid
	'((daily today require-timed)
	  (800 1000 1200 1400 1600 1800 2000)
	  " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
  (setq org-agenda-current-time-string "⭠ now ─────────────────────────────────────────────────")

  ;; Bullets cutomization
  (setq org-modern-checkbox '((88 . "󰄲")
			      (45 . "󱋬")
			      (32 . "󰄮")))
  (setq org-modern-list '((43 . "▶")
			  (45 . "◦")
			  (42 . "•")))
  ;; (setq org-modern-priority
  ;; '((?A . ,(propertize "!!!" 'font-lock-face '(:foreground "#ff5370" )))
  ;; (?B . ,(propertize "!" 'font-lock-face '(:foreground "#ffcb6b" )))
  ;; (?C . ,(propertize "!" font-lock-face '(:foreground "#c3e88d")))))
  (setq org-modern-priority
        `((?A . ,(propertize "󰯬" 'face '(:foreground "#c3e88d")))
          (?B . ,(propertize "󰯯" 'face '(:foreground "#ffcb6b")))
          (?C . ,(propertize "󰯲" 'face '(:foreground "#ff5370")))))
  ;; Don't work
  ;; `((?A . ,(propertize "󰯬" 'face '(:foreground ,(doom-color 'green))))
  ;; (?B . ,(propertize "󰯯" 'face '(:foreground ,(doom-color 'yellow))))
  ;; (?C . ,(propertize "󰯲" 'face '(:foreground ,(doom-color 'red))))))

  ;; Faces adjustment
  (setq org-modern-todo-faces
	'(("TODO" :background "#ff5370" :foreground "#1c1f2b")
	  ("NEXT" :background "#c3e88d" :foreground "#1c1f2b")
	  ("WAIT" :background "#ffcb6b" :foreground "#1c1f2b")))
  ;; Don't work
  ;; '(("TODO" :background ,(doom-color 'red) :foreground "#1c1f2b")
  ;; ("NEXT" :background ,(doom-color 'green) :foreground "#1c1f2b")
  ;; ("WAIT" :background ,(doom-color 'yellow) :foreground "#1c1f2b")))

  ;; org block
  (setq org-modern-block-name t)
  (setq org-modern-block-fringe t)

  )

;; Better indentation support
(use-package org-modern-indent
  :vc (:url "https://github.com/jdtsmith/org-modern-indent"
	    :branch "main")
  :hook (org-modern-mode . org-modern-indent-mode))


;; Habit
(use-package org
  :config
  (require 'org-habit)
  )

(provide 'org-module)
;;; org-module.el ends here
