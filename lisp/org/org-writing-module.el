;; General

;; Automatic TOC management
(use-package toc-org
  :hook (org-mode . toc-org-mode))


;; Citar integration
(use-package citar
  :after org
  :custom
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar))


(provide 'org-writing-module)
