(use-package citar
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
  (setq citar-bibliography org-cite-global-bibliography)
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
