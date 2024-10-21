;; -*- lexical-binding: t -*-
;; Citation manager
(use-package citar
  :general
  (k8x1d/leader-keys
    "ob" '(citar-open :which-key "Bibliography")
    )
  (k8x1d/local-leader-keys
    :keymaps 'LaTeX-mode-map
    "ic" '(citar-insert-citation :which-key "Citation")
    )
  (k8x1d/local-leader-keys
    :keymaps 'org-mode-map
    "ic" '(citar-insert-citation :which-key "Citation")
    )
  (k8x1d/local-leader-keys
    :keymaps 'markdown-mode
    "ic" '(citar-insert-citation :which-key "Citation")
    )
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
  :hook
  (org-mode . citar-embark-mode)
  (markdown-mode . citar-embark-mode)
  (LaTeX-mode . citar-embark-mode)
  :config
  (setq citar-at-point-function 'embark-act)
  )

;; Browse and fetch references
(use-package biblio
  :general
  (k8x1d/leader-keys 
    "s" '(:ignore t :which-key "Search")
    "sb" '(biblio-lookup :which-key "Bibliographic reference")
    )
  )


(provide 'bibliography-module)
