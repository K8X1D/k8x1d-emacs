

(use-package org
  :config
  ;; ensure precise linkage between notebook and file
  (require 'org-id)
  (setq org-id-link-to-org-use-id t)
  (setq org-confirm-babel-evaluate nil)
  )

(provide 'notebook-module)
