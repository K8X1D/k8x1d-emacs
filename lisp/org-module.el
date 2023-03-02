;;
;; Org
;;

(use-package org
  :bind
  ;; From https://orgmode.org/manual/Activation.html
  (("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture))
  :hook
  (org-mode . org-indent-mode) ;; indent
  :config
  (setq org-directory "~/org")
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path t)
  (setq org-default-notes-file "~/org/notes.org")
  (setq org-agenda-files
	(file-expand-wildcards "~/org/*.org"))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (setq org-confirm-babel-evaluate 'nil)
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/org/todo.org" "Inbox")
	   "** TODO %?")
	  ("p" "Projects" entry (file+headline "~/org/projects.org" "Divers") 
	   "*** TODO %?\n  %i\n  %a")))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "IN PROGRESS(i)" "WAITING(w)" "NEXT(n)" "REPORTED(r)"  "|" "DONE(d)" "CANCELLED(c)")))
(setq org-todo-keyword-faces
      '(("WAITING" . (:foreground ,(doom-color 'yellow)))
        ("CANCELLED" . (:foreground ,(doom-color 'red)))))
  ;; Increase size of LaTeX fragment previews
  (plist-put org-format-latex-options :scale 1.0)
  ;; better quality latex preview
  (setq org-latex-create-formula-image-program 'dvisvgm)
  ;; This is usually the default, but keep in mind it must be nil
  (setq org-hide-leading-stars nil)
  ;; If you use Org Indent you also need to add this, otherwise the
  ;; above has no effect while Indent is enabled.
  (setq org-indent-mode-turns-on-hiding-stars nil)
  ;; babel support
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (sql . t)
     (gnuplot . t)
     (shell . t)))
  ;; add additional languages with '((language . t)))
  ;; export 
  ;; https://www.reddit.com/r/orgmode/comments/f5unzb/export_setting_language_does_not_work/
  (add-to-list 'org-latex-packages-alist '("AUTO" "babel" t ("pdflatex")))
  ;; taskjuggler
  ;;(require 'ox-taskjuggler)
  ;; Bibliography
  (setq org-cite-global-bibliography '("~/Zotero/k8x1d.bib"))
  )

;; Priorities symbols
(use-package org-fancy-priorities
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("[HIGH]" "[MID]" "[LOW]")))

;; Bullets symbols
(use-package org-superstar
  :hook
  (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-leading-bullet ?\s)
  (setq org-superstar-headline-bullets-list '("◉" "○" "◈" "◇" "▣" "□")))


;; Emphasis marker appering 
(use-package org-appear
  :init
  ;; show only in insert mode
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
	org-appear-autoemphasis t
	org-appear-autolinks t)
  )


;; Pomodoro
(use-package org-pomodoro
  :defer t
  :config
  ;; pomodoro
  (setq org-pomodoro-length 50)
  (setq org-pomodoro-short-break-length 10)
  (setq org-pomodoro-long-break-length 30)
  )


(provide 'org-module)

