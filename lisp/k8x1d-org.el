(use-package org
  :bind
  ("C-c l" . org-store-link)
  :hook
  ((org-mode . org-indent-mode)
   (org-mode . visual-line-mode))
  :config
  (setq org-cite-global-bibliography '("~/Zotero/k8x1d.bib"))
  (setq org-image-actual-width nil)
  ;; Babel
  (setq org-confirm-babel-evaluate nil)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (julia-vterm . t)))
  )

;;(use-package org-modern
;;  :hook (after-init . global-org-modern-mode)
;; ;; :custom
;;;;  (org-modern-table nil)
;;  :config
;;  ;; Tmp fix, see https://github.com/minad/org-modern/issues/5
;;  (custom-set-variables '(org-modern-table nil))
;;  (setq
;;   ;; Edit settings
;;   org-auto-align-tags nil
;;   org-tags-column 0
;;   org-catch-invisible-edits 'show-and-error
;;   org-special-ctrl-a/e t
;;   org-insert-heading-respect-content t
;;
;;   ;; Org styling, hide markup etc.
;;   org-pretty-entities t
;;   org-ellipsis "…"
;;
;;   ;; Agenda styling
;;   org-agenda-tags-column 0
;;   org-agenda-block-separator ?─
;;   org-agenda-time-grid
;;   '((daily today require-timed)
;;     (800 1000 1200 1400 1600 1800 2000)
;;     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
;;   org-agenda-current-time-string
;;   "⭠ now ─────────────────────────────────────────────────")
;;  )

;; Prettify bullets
(use-package org-superstar
  :hook
  (org-mode . org-superstar-mode)
  :config
  ;; This is usually the default, but keep in mind it must be nil
  (setq org-hide-leading-stars nil)
  ;; This line is necessary.
  (setq org-superstar-leading-bullet ?\s)
  ;; If you use Org Indent you also need to add this, otherwise the
  ;; above has no effect while Indent is enabled.
  (setq org-indent-mode-turns-on-hiding-stars nil)
  (setq org-superstar-special-todo-items t))



;; Prettify priorities
(use-package org-fancy-priorities
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("[!]" "[*]" "[-]")))


(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

(use-package org-appear
  :hook
  ((org-mode . org-appear-mode)
   (org-mode . (lambda ()
		 (add-hook 'evil-insert-state-entry-hook
			   #'org-appear-manual-start
			   nil
			   t)
		 (add-hook 'evil-insert-state-exit-hook
			   #'org-appear-manual-stop
			   nil
			   t))))
  :config
  (setq org-hide-emphasis-markers t
	org-appear-trigger 'manual
	org-appear-autoemphasis t
	org-appear-autolinks t)
  )

(provide 'k8x1d-org)
