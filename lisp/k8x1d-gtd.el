;; GTD
;; From https://lucidmanager.org/productivity/getting-things-done-with-emacs/
;; From https://members.optusnet.com.au/~charles57/GTD/orgmode.html
;; https://hamberg.no/gtd
(use-package org
  :defer t
  :bind
  (("C-c c" . 'org-capture)
   ("C-c o a" . 'org-agenda))
  :general
  (k8x1d/leader-keys
    "x" '(org-capture :which-key "Capture")
    )
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "t" '(org-todo :which-key "Todos")
    "c" '(:ignore t :which-key "Clock")
    "ci" '(org-clock-in :which-key "In")
    "co" '(org-clock-out :which-key "Out")
    "d" '(:ignore t :which-key "Date")
    "dd" '(org-deadline :which-key "Deadline")
    "ds" '(org-schedule :which-key "Scheduled")
    "d." '(org-time-stamp :which-key "Timestamp")
    )
  :config
  ;; Org agenda configuration
  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-timestamp-if-done t)

  ;; Org directory
  (setq org-directory "~/org")
  (setq org-agenda-files (append (file-expand-wildcards "~/Dropbox/Gmail/org/gtd/*.org")
				 (file-expand-wildcards "~/Dropbox/Gmail/org/doom/*.org")
				 (file-expand-wildcards "~/org/gtd/*.org")
				 ))


  ;; From doom configuration
  ;; See https://github.com/doomemacs/doomemacs/blob/master/modules/lang/org/config.el
  (with-no-warnings
    (custom-declare-face '+org-todo-active  '((t (:inherit (bold font-lock-constant-face org-todo)))) "")
    (custom-declare-face '+org-todo-project '((t (:inherit (bold font-lock-doc-face org-todo)))) "")
    (custom-declare-face '+org-todo-onhold  '((t (:inherit (bold warning org-todo)))) "")
    (custom-declare-face '+org-todo-cancel  '((t (:inherit (bold error org-todo)))) ""))
  (setq org-todo-keywords
	'((sequence
	   "TODO(t)"  ; A task that needs doing & is ready to do
	   "PROJ(p)"  ; A project, which usually contains other tasks
	   "LOOP(r)"  ; A recurring task
	   "STRT(s)"  ; A task that is in progress
	   "WAIT(w)"  ; Something external is holding up this task
	   "HOLD(h)"  ; This task is paused/on hold because of me
	   "IDEA(i)"  ; An unconfirmed and unapproved task or notion
	   "|"
	   "DONE(d)"  ; Task successfully completed
	   "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
	  )
	org-todo-keyword-faces
	'(("STRT" . +org-todo-active)
	  ("WAIT" . +org-todo-onhold)
	  ("HOLD" . +org-todo-onhold)
	  ("PROJ" . +org-todo-project)
	  ("KILL" . +org-todo-cancel)))

  ;; Refile configuration
  (setq 
   org-refile-targets
   '((nil :maxlevel . 3)
     (org-agenda-files :maxlevel . 3))
   org-refile-use-outline-path t
   org-refile-active-region-within-subtree 'file
   org-outline-path-complete-in-steps nil
   org-refile-allow-creating-parent-nodes t)

  ;; Capture Configuration (inspired by doom emacs)
  ;; See https://github.com/doomemacs/doomemacs/tree/master/modules/lang/org
  ;; TODO implement common set-up

  (setq org-default-notes-file (concat org-directory "/gtd/inbox.org")) ;; Orig
  )


(provide 'k8x1d-gtd)
