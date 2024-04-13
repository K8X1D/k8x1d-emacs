(use-package org
  :config
    ;; Exportation
    (setq org-cite-export-processors
	  '((md . (csl "chicago-fullnote-bibliography.csl"))   ; Footnote reliant
	    (latex biblatex)                                   ; For humanities
	    (odt . (csl "chicago-fullnote-bibliography.csl"))  ; Footnote reliant
	    (t . (csl "modern-language-association.csl"))))      ; Fallback
    )


;; Bibliography interaction
  (use-package citar
    :hook
    ((LaTeX-mode . citar-capf-setup)
     (org-mode . citar-capf-setup))
    :bind (("C-c b i c" . citar-insert-citation)
           ("C-c b i r" . citar-insert-reference)
           ("C-c b i b" . citar-insert-bibtex)
           ("C-c b o f" . citar-open)
           ("C-c b o n" . citar-open-note)
           (:map minibuffer-local-map
                 ("M-b" . citar-insert-preset))
           ;; (:map org-mod
           ;;       ("C-c b" . org-cite-insert))
           )
    :config
    ;; Org cite configuration to use citar
    (setq org-cite-insert-processor 'citar)
    (setq org-cite-follow-processor 'citar)
    (setq org-cite-activate-processor 'citar)
    (setq citar-bibliography k8x1d/bibliography)
    (setq citar-at-point-function 'embark-act)
    ;; Notes
    (setq citar-notes-paths '("~/Zotero/notes"))
    )

;; Integration with embark
  (use-package citar-embark
    :after citar embark
    :no-require
    :config (citar-embark-mode))

(provide 'bibliography-module)
