;; Capture configuration
(use-package org
  :bind ("C-c c" . org-capture)
  :custom (org-directory k8x1d/org-directory)
  :config
  (setq org-refile-targets
	'((nil :maxlevel . 3)
	  (org-agenda-files :maxlevel . 3)))
  (setq org-refile-use-outline-path t
	org-outline-path-complete-in-steps nil)
  (setq org-refile-use-cache t)
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-capture-templates
	'(("t" "Todo" entry (file (lambda () (concat org-directory "/Inbox.org")))
	   "* TODO %?\n  %i\n")
	  ;; To write: 
	  ;; see https://orgmode.org/manual/Capture-templates.html
	  ;; ("p" "Project" entry (file+function "~/org/projects.org" k8x1d/get-project-name)
	  ;;  "*  %?\n  %i\n")
	  ("n" "Notes" entry (file+headline (lambda () (concat org-directory "/notes.org"))  "Notes")
	   "* %U %?\n")))
  )

;; Org agenda
(use-package org
  :bind ("C-c o a" . org-agenda)
  :config
  (setq org-agenda-files k8x1d/org-files) ;; org-agenda files
  (setq org-agenda-window-setup 'current-window) ;; take the whole buffer
  (setq org-agenda-span 'day) ;; span
  ;; Optimize startup
  (setq org-agenda-inhibit-startup t)
  ;; Clean-up
  (setq org-agenda-skip-deadline-if-done nil)
  (setq org-agenda-skip-scheduled-if-done nil)
  (setq org-agenda-skip-timestamp-if-done nil)
  ;; tags position
  (add-hook 'org-agenda-finalize-hook 'place-agenda-tags)
  (defun place-agenda-tags ()
    "Put the agenda tags by the right border of the agenda window."
    (interactive)
    (setq org-agenda-tags-column (- 4 (window-width)))
    (org-agenda-align-tags)
    )
  ;; org agenda keys
  ;; (setq org-agenda-sticky nil)
  ;; View configuration
  ;; In test
  (setq org-agenda-compact-blocks t)
  (setq org-todo-keywords-for-agenda '((sequence "TODO" "NEXT" "WAIT" "|" "DONE" "CNCL")))
  ;; (setq org-agenda-time-grid '((daily today require-timed) "----------------------" nil))
  (setq org-agenda-include-deadlines t)
  (setq org-agenda-include-diary nil)
  (setq org-agenda-block-separator nil)
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-deadline-leaders '("[Today]" "In %3d d.: " "%2d d. ago: "))
  (setq org-agenda-scheduled-leaders '("[Today]" "Sched.%2dx: "))
  )


;; Group agenda
(use-package org-super-agenda
;;  :init
;;  (defun k8x1d/org-agenda-day ()
;;    (interactive)
;;    (tabspaces-switch-or-create-workspace "GTD")
;;    (org-agenda nil "d")
;;    )
;;  (defun k8x1d/org-agenda-week ()
;;    (interactive)
;;    (tabspaces-switch-or-create-workspace "GTD")
;;    (org-agenda nil "w")
;;    )
;;  (defun k8x1d/org-agenda-month ()
;;    (interactive)
;;    (tabspaces-switch-or-create-workspace "GTD")
;;    (org-agenda nil "m")
;;    )
;;  (defun k8x1d/org-agenda-grouped-tags ()
;;    (interactive)
;;    (tabspaces-switch-or-create-workspace "GTD")
;;    (org-agenda nil "t")
;;    )
;;  (push '(GTD  . k8x1d/org-agenda-day) k8x1d-workspaces)
;;  (defun k8x1d/switch-or-create-gtd-workspace ()
;;    (interactive)
;;    (k8x1d/switch-or-create-predefined-workspace 'GTD)
;;    )
  :hook (org-agenda-mode . org-super-agenda-mode)
  :config
  ;; Fix for evil user, see https://github.com/alphapapa/org-super-agenda/issues/50
  (setq org-super-agenda-header-map (make-sparse-keymap))
  :init
  (setq org-agenda-custom-commands
        '(("d" "Agenda for the day"
           ((agenda "" ((org-agenda-span 'day)
                        (org-agenda-deadline-leaders '(" " "-%3d" "+%3d"))
                        (org-agenda-scheduled-leaders '(" " "+%2d"))
                        (org-agenda-skip-deadline-if-done t)
                        (org-agenda-skip-scheduled-if-done t)
                        (org-agenda-skip-timestamp-if-done t)
                        (org-super-agenda-groups
                         '(
                           (:name "Aujourd'hui"
                                  :time-grid t
                                  :order 0)
                           (:name "Échéancier"
                                  :deadline today
                                  :scheduled today
                                  :order 1)
                           (:name "En retard"
                                  :deadline past
                                  :scheduled past
                                  :order 2)
                           (:name "À venir"
                                  :deadline future
                                  :scheduled future
                                  :order 3)
                           )))))
           )
          ("w" "Agenda for the week"
           ((agenda "" ((org-agenda-span 'week)
                        (org-agenda-start-on-weekday 0)
                        (org-agenda-deadline-leaders '(" " "-%3d" "+%3d"))
                        (org-agenda-scheduled-leaders '(" " "+%2d"))
                        (org-super-agenda-groups
                         '((:name ""
                                  :time-grid t
                                  :deadline today
                                  :scheduled today
                                  :date today
                                  :discard (:deadline past :scheduled past :deadline future :scheduled future)
                                  :order 1)
                           )))))
           )
          ("m" "Agenda for the month"
           ((agenda "" ((org-agenda-span 'month)
                        (org-agenda-start-on-weekday 0)
                        (org-agenda-deadline-leaders '(" " "-%3d" "+%3d"))
                        (org-agenda-scheduled-leaders '(" " "+%2d"))
                        (org-super-agenda-groups
                         '((:name "Today"
                                  :deadline future 
                                  :discard (:not (:deadline future))
                                  ;; :discard (:deadline today :scheduled past :scheduled today :scheduled future :scheduled t :date nil :date t :date today :deadline past)
                                  :order 1)
                           )))))
           )

          ("t" "Grouped tags "
           ((org-tags-view "" ((org-agenda-span 'week)
                        (org-agenda-start-on-weekday 0)
                        (org-agenda-deadline-leaders '(" " "-%3d" "+%3d"))
                        (org-agenda-scheduled-leaders '(" " "+%2d"))
                        (org-super-agenda-groups
                         '((:name "Job"
                                  :auto-tags t
                                  :order 1)
                           )))))
           )
          ))
  )

;; 
(use-package origami
  :bind
  (:map org-agenda-mode-map
        ([remap org-agenda-goto] . origami-toggle-node))
  :hook (org-super-agenda-mode . origami-mode)
  )

;; Clock
(use-package org
  :init
  (defun k8x1d/org-clock-goto ()
    (interactive)
    (if (member "GTD" (tabspaces--list-tabspaces)) (tabspaces-switch-or-create-workspace "GTD"))
    (org-clock-goto)
    )
  :bind
  ("C-c o c" . k8x1d/org-clock-goto)
  :config
  (setq org-clock-persist t)
  )

(provide 'org-agenda-module)