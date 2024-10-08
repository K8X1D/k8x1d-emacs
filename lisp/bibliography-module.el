;; -*- lexical-binding: t -*-
;; Citation manager
(use-package citar
  :bind
  ("C-c w c" . citar-create-note)
   ("C-c o z" . citar-open)
  :config
  (setq citar-bibliography k8x1d/bibliography) ;; set bibliography's location
  (setq citar-open-always-create-notes nil) ;; Allow multiple notes per bibliographic entry
  (setq citar-file-open-functions '(("html" . citar-file-open-external)
				    ;; ("pdf" . citar-file-open-external)
				    (t . find-file))) 
  )

;; Org integration
(use-package org
  :hook
  (org-mode . citar-capf-setup)
  :config
  (require 'citar-org)
  (setq citar-at-point-function 'embark-act)
  (setq org-cite-insert-processor 'citar)
  (setq org-cite-follow-processor 'citar)
  (setq org-cite-activate-processor 'citar)
  )

;; Latex integration
(use-package tex
  :ensure auctex
  :hook
  (LaTeX-mode . citar-capf-setup)
  :config
  (require 'citar-latex)
  )

;; Embark integration
(use-package citar-embark
  :after citar embark
  ;; :no-require
  :config
  (require 'citar-embark)
  (citar-embark-mode))

;; Browse and fetch references
(use-package biblio)


(provide 'bibliography-module)
