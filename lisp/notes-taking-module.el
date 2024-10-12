;; -*- lexical-binding: t -*-
;; Denote
(use-package denote
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   ;; "oj"  '(denote-journal-extras-new-or-existing-entry :which-key "Journal")
   "on"  '(denote :which-key "Note")
    )
  :bind
  ("C-c c n" . denote)
  ("C-c c j" . denote-journal-extras-new-or-existing-entry)
  :config
  (setq denote-directory k8x1d/notes-directory)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Logseq compatible journal ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package emacs
  :general
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "oj" '(k8x1d/create-or-find-today-journal-entry :which-key "Journal") 
    )
  :config
  (defun k8x1d/today-date ()
    (format-time-string "%Y-%m-%d" (current-time))
    )
  (defun k8x1d/create-or-find-today-journal-entry ()
    (interactive)
    (find-file (concat k8x1d/journal-directory "/" (k8x1d/today-date) ".org"))
    )
  )

;; Org capture integration
(use-package org-capture
  :ensure nil
  :config
  (add-to-list 'org-capture-templates
	       '("N" "New note (with Denote)" plain
		 (file denote-last-path)
		 #'denote-org-capture
		 :no-save t
		 :immediate-finish nil
		 :kill-buffer t
		 :jump-to-captured t)
	       t)
  )

;; Citar integration
(use-package citar-denote 
  :bind
  (
   ("C-c w n" . citar-denote-open-note)
   ("C-c w d" . citar-denote-dwim)
   ("C-c w e" . citar-denote-open-reference-entry)
   ("C-c w a" . citar-denote-add-citekey)
   ("C-c w k" . citar-denote-remove-citekey)
   ("C-c w r" . citar-denote-find-reference)
   ("C-c w l" . citar-denote-link-reference)
   ("C-c w f" . citar-denote-find-citation)
   ("C-c w x" . citar-denote-nocite)
   ("C-c w y" . citar-denote-cite-nocite)
   ("C-c w z" . citar-denote-nobib)
   )
  :hook
  (after-init . citar-denote-mode)
  :config
  (setq citar-denote-file-type 'org)
  (setq citar-denote-keyword "bib")
  (setq citar-denote-signature nil)
  (setq citar-denote-subdir nil)
  (setq citar-denote-template nil)
  (setq citar-denote-title-format "title")
  (setq citar-denote-title-format-andstr "and")
  (setq citar-denote-title-format-authors 1)
  (setq citar-denote-use-bib-keywords nil)
  )


;; Menu
(use-package denote-menu
  :bind
  ("C-c z" . denote-menu-list-notes)
  :config
  (define-key denote-menu-mode-map (kbd "c") #'denote-menu-clear-filters)
  (define-key denote-menu-mode-map (kbd "/ r") #'denote-menu-filter)
  (define-key denote-menu-mode-map (kbd "/ k") #'denote-menu-filter-by-keyword)
  (define-key denote-menu-mode-map (kbd "/ o") #'denote-menu-filter-out-keyword)
  (define-key denote-menu-mode-map (kbd "e") #'denote-menu-export-to-dired)
  )

;; Consult integration 
(use-package consult-denote
  :hook
  (after-init . consult-denote-mode))









(provide 'notes-taking-module)
