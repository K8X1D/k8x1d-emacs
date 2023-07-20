
;;
;; Org-roam
;;


;;;; Web visualization network
;;(add-hook 'org-roam-db-autosync-mode-hook #'org-roam-ui-mode)

;;
;; Base
;;
(use-package org-roam
  :general
  (k8x1d/leader-keys
    "n" '(:ignore t :which-key "Notes")
    "nl" '(org-roam-buffer-toggle :which-key "Buffer")
    "nf" '(org-roam-node-find :which-key "Find")
    "ng" '(org-roam-graph :which-key "Graph")
    "ni" '(org-roam-node-insert :which-key "Insert")
    "nc" '(org-roam-capture :which-key "Capture")
    "nj" '(org-roam-dailies-capture-today :which-key "Journal")
    )
  :custom
  (org-roam-directory (concat org-directory "/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq find-file-visit-truename t)
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))



;;
;; Better graph visualization
;;
(use-package websocket
    :after org-roam)

(use-package org-roam-ui
  :bind (("C-c n g" . org-roam-ui-open))
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t
	org-roam-ui-open-on-start t))


;;
;; Integration with citar
;;
(use-package citar-org-roam
  :after (citar org-roam)
  :config (citar-org-roam-mode))


;;(use-package consult-org-roam
;;   :ensure t
;;   :after org-roam
;;   :init
;;   (require 'consult-org-roam)
;;   ;; Activate the minor mode
;;   (consult-org-roam-mode 1)
;;   :custom
;;   ;; Use `ripgrep' for searching with `consult-org-roam-search'
;;   (consult-org-roam-grep-func #'consult-ripgrep)
;;   ;; Configure a custom narrow key for `consult-buffer'
;;   (consult-org-roam-buffer-narrow-key ?r)
;;   ;; Display org-roam buffers right after non-org-roam buffers
;;   ;; in consult-buffer (and not down at the bottom)
;;   (consult-org-roam-buffer-after-buffers t)
;;   :config
;;   ;; Eventually suppress previewing for certain functions
;;   (consult-customize
;;    consult-org-roam-forward-links
;;    :preview-key (kbd "M-."))
;;   :bind
;;   ;; Define some convenient keybindings as an addition
;;   ("C-c n e" . consult-org-roam-file-find)
;;   ("C-c n b" . consult-org-roam-backlinks)
;;   ("C-c n l" . consult-org-roam-forward-links)
;;   ("C-c n r" . consult-org-roam-search))
























(provide 'k8x1d-notes-taking)
