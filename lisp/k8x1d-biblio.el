(use-package citar
  :after org
  :general
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "b" '(:ignore t :which-key "Bibliography")
    "bi" '(:ignore t :which-key "Insert")
    "bic" '(citar-insert-citation :which-key "Citation")
    "bir" '(citar-insert-reference :which-key "Reference")
    "bo" '(citar-open :which-key "Open")
    "bO" '(citar-open-note :which-key "Open Note")
    )
  :bind (("C-c b i c" . citar-insert-citation)
	 ("C-c b i r" . citar-insert-reference)
	 ("C-c b o f" . citar-open)
	 ("C-c b o n" . citar-open-note)
	 (:map minibuffer-local-map
	       ("M-b" . citar-insert-preset))
	 (:map org-mode-map
	       ("C-c b" . org-cite-insert))
	 )
  :config
  ;; Org cite configuration to use citar
  (setq org-cite-insert-processor 'citar)
  (setq org-cite-follow-processor 'citar)
  (setq org-cite-activate-processor 'citar)
  (setq citar-bibliography k8x1d-default-bibliography)
  (setq citar-at-point-function 'embark-act)
  ;; Icons support
  (setq citar-symbols
 	`((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
 	  (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
 	  (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
  (setq citar-symbol-separator "  ")
  ;; Notes
  (setq citar-notes-paths '("~/Zotero/notes"))
  )

(provide 'k8x1d-biblio)
