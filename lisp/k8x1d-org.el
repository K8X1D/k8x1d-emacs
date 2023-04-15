

(global-set-key (kbd "C-c l") #'org-store-link)

;; Indent bullets
(add-hook 'org-mode-hook #'org-indent-mode)


;; Bibliography
(setq org-cite-global-bibliography '("~/Zotero/k8x1d.bib"))


;; Esthetics
(setq org-insert-heading-respect-content t)


;; Modern look to org
;; TODO: explore doc for org-modern
;; Must be set after org-indent-mode, if not, coloring problem occurs (invisible level-2 bullets)
;;(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-indent-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
;;(global-org-modern-mode)


(setq org-image-actual-width nil)



;; Add "#+auto_tangle: t" option for header
(add-hook 'org-mode-hook #'org-auto-tangle-mode)
;; Wrap text by default
(add-hook 'org-mode-hook #'visual-line-mode)


;;
;; Org babel
;;
(with-eval-after-load "org"
  (setq org-confirm-babel-evaluate nil)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (julia-vterm . t))))




;; Visibility of hidden elements only when in insert mode
;; from https://github.com/awth13/org-appear
(add-hook 'org-mode-hook #'org-appear-mode)
(setq org-hide-emphasis-markers t
      org-appear-trigger 'manual
      org-appear-autoemphasis t
      org-appear-autolinks t)

(add-hook 'org-mode-hook (lambda ()
                           (add-hook 'evil-insert-state-entry-hook
                                     #'org-appear-manual-start
                                     nil
                                     t)
                           (add-hook 'evil-insert-state-exit-hook
                                     #'org-appear-manual-stop
                                     nil
                                     t)))







(provide 'k8x1d-org)
