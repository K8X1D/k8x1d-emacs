;; GTD
;; From https://lucidmanager.org/productivity/getting-things-done-with-emacs/
;; From https://members.optusnet.com.au/~charles57/GTD/orgmode.html
;; https://hamberg.no/gtd
(use-package org
  :bind
  (("C-c c" . 'org-capture)
   ("C-c a" . 'org-agenda))
  :config
  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-timestamp-if-done t
   org-directory "~/Dropbox/org"
   org-default-notes-file (concat org-directory "/gtd/inbox.org")
   org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "KILL(k)"))
   org-agenda-files (file-expand-wildcards (concat org-directory "/gtd/*.org"))
   org-refile-targets '((org-agenda-files :maxlevel . 3)))
  )



(provide 'k8x1d-gtd)
