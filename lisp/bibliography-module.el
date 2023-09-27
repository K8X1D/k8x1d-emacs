;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package citar
  :hook
  ((LaTeX-mode . citar-capf-setup)
   (org-mode . citar-capf-setup))
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
  (setq citar-bibliography default-bibliography)
  (setq citar-at-point-function 'embark-act)
  ;; Notes
  (setq citar-notes-paths '("~/Zotero/notes"))
  )

(use-package citar-embark
  :after citar embark
  :no-require
  :config (citar-embark-mode))

(provide 'bibliography-module)
;;; bibliography-module-module.el ends here
