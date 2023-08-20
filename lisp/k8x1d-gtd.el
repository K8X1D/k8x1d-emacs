;;; package --- Summary

;;; Commentary:

;;; Code:


;; GTD
;; ;; From https://lucidmanager.org/productivity/getting-things-done-with-emacs/
;; ;; From https://members.optusnet.com.au/~charles57/GTD/orgmode.html
;; ;; https://hamberg.no/gtd
;; (use-package org
;;   :defer t
;;   :bind
;;   (("C-c c" . 'org-capture)
;;    ("C-c o a" . 'org-agenda))
;;   :general
;;   (k8x1d/leader-keys
;;     "x" '(org-capture :which-key "Capture")
;;     )
;;   (k8x1d/local-leader-keys
;;     :keymaps 'org-mode-map
;;     "t" '(org-todo :which-key "Todos")
;;     "c" '(:ignore t :which-key "Clock")
;;     "ci" '(org-clock-in :which-key "In")
;;     "co" '(org-clock-out :which-key "Out")
;;     "d" '(:ignore t :which-key "Date")
;;     "dd" '(org-deadline :which-key "Deadline")
;;     "ds" '(org-schedule :which-key "Scheduled")
;;     "d." '(org-time-stamp :which-key "Timestamp")
;;     )
;;   :config
;;   ;; Org agenda configuration
;;   (setq
;;    org-agenda-skip-scheduled-if-done t
;;    org-agenda-skip-deadline-if-done t
;;    org-agenda-skip-timestamp-if-done t)

;;   ;; Org directory
;;   (setq org-directory "~/org")
;;   (setq org-agenda-files (append
;; 			  ;;(file-expand-wildcards "~/Dropbox/Gmail/org/gtd/*.org")
;; 			  ;;(file-expand-wildcards "~/Dropbox/Gmail/org/doom/*.org")
;; 			  (file-expand-wildcards "~/org/gtd/*.org")
;; 			  ))


;;   ;; From doom configuration
;;   ;; See https://github.com/doomemacs/doomemacs/blob/master/modules/lang/org/config.el
;;   (with-no-warnings
;;     (custom-declare-face '+org-todo-active  '((t (:inherit (bold font-lock-constant-face org-todo)))) "")
;;     (custom-declare-face '+org-todo-project '((t (:inherit (bold font-lock-doc-face org-todo)))) "")
;;     (custom-declare-face '+org-todo-onhold  '((t (:inherit (bold warning org-todo)))) "")
;;     (custom-declare-face '+org-todo-cancel  '((t (:inherit (bold error org-todo)))) ""))
;;   (setq org-todo-keywords
;; 	'((sequence
;; 	   "TODO(t)"  ; A task that needs doing & is ready to do
;; 	   "PROJ(p)"  ; A project, which usually contains other tasks
;; 	   "LOOP(r)"  ; A recurring task
;; 	   "STRT(s)"  ; A task that is in progress
;; 	   "WAIT(w)"  ; Something external is holding up this task
;; 	   "HOLD(h)"  ; This task is paused/on hold because of me
;; 	   "IDEA(i)"  ; An unconfirmed and unapproved task or notion
;; 	   "|"
;; 	   "DONE(d)"  ; Task successfully completed
;; 	   "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
;; 	  )
;; 	org-todo-keyword-faces
;; 	'(("STRT" . +org-todo-active)
;; 	  ("WAIT" . +org-todo-onhold)
;; 	  ("HOLD" . +org-todo-onhold)
;; 	  ("PROJ" . +org-todo-project)
;; 	  ("KILL" . +org-todo-cancel)))

;;   ;; Refile configuration
;;   (setq
;;    org-refile-targets
;;    '((nil :maxlevel . 3)
;;      (org-agenda-files :maxlevel . 3))
;;    org-refile-use-outline-path t
;;    org-refile-active-region-within-subtree 'file
;;    org-outline-path-complete-in-steps nil
;;    org-refile-allow-creating-parent-nodes t)

;;   ;; Capture Configuration (inspired by doom emacs)
;;   ;; See https://github.com/doomemacs/doomemacs/tree/master/modules/lang/org
;;   ;; TODO implement common set-up

;;   (setq org-default-notes-file (concat org-directory "/gtd/inbox.org")) ;; Orig
;;   )


;; ;; Habits
;; ;; see https://stackoverflow.com/questions/8751287/weekly-repeating-tasks-emacs-org-mode
;; ;; see http://orgmode.org/manual/Tracking-your-habits.html
;; (use-package org
;;   :config
;;   (require 'org-habit)
;;   )

;;
;; New version
;;

(use-package org
  :general
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
     ))


(use-package org-gtd
  :init
  (setq org-gtd-update-ack "3.0.0")
  :custom
  (org-gtd-directory (concat org-directory "/gtd"))
  :hook ((org-mode . (lambda ()
		       (require 'org-gtd)
		       (org-gtd-mode)))
	 (org-gtd-mode . org-edna-mode))
  :config
  (setq org-edna-use-inheritance t)
  (setq org-gtd-organize-hooks '(org-gtd-set-area-of-focus org-set-tags-command))
  :general
  (k8x1d/leader-keys
    "d" '(:ignore t :which-key "GTD")
    "d c" '(org-gtd-capture :which-key "Capture")
    "d e" '(org-gtd-engage :which-key "Engage")
    "d p" '(org-gtd-process-inbox :which-key "Process Inbox")
    "d a" '(org-gtd-archive-completed-items :which-key "Archive completed items")
    )
  :bind
  (:map org-gtd-clarify-map
   ("C-c c" . org-gtd-organize)
  ))


(provide 'k8x1d-gtd)
;;; k8x1d-gtd.el ends here
