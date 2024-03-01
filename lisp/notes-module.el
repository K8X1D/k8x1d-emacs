;; Notes manager
(use-package org-roam
  :custom
  (org-roam-directory (file-truename (concat org-directory "/roam/")))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ;; ("C-c n g" . org-roam-graph)
	 ("C-c n g" . org-roam-ui-open)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ;; Dailies
	 ("C-c n j" . org-roam-dailies-capture-today))
  :hook (org-roam-mode . visual-line-mode)
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol

  (require 'org-roam-protocol)

  ;; Content of org roam buffer
  (setq org-roam-mode-sections
	(list #'org-roam-backlinks-section
	      #'org-roam-reflinks-section
	      ;; #'org-roam-unlinked-references-section
	      ))
  ;; postion of buffer display
  (add-to-list 'display-buffer-alist
	       '("\\*org-roam\\*"
		 (display-buffer-in-direction)
		 (direction . left)
		 (window-width . 0.25)
		 (window-height . fit-window-to-buffer)))

  ;; Completion
  (setq org-roam-completion-everywhere t)
  )


;; Ui node visualization
(use-package websocket
  :after org-roam)

(use-package org-roam-ui
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

;; Consult integration
(use-package consult-org-roam
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key (kbd "M-."))
  :bind
  ;; Define some convenient keybindings as an addition
  ("C-c n e" . consult-org-roam-file-find)
  ("C-c n b" . consult-org-roam-backlinks)
  ("C-c n L" . consult-org-roam-forward-links)
  ("C-c n r" . consult-org-roam-search))

;; Integration with citar
(use-package citar-org-roam
  :after (citar org-roam)
  :config (citar-org-roam-mode))

;; Automatic timestamps
(use-package org-roam-timestamps
  :after org-roam
  :config (org-roam-timestamps-mode))


;; QL query in org-roam
(use-package org-roam-ql
  :after (org-roam)
  :bind ((:map org-roam-mode-map
               ;; Have org-roam-ql's transient available in org-roam-mode buffers
               ("v" . org-roam-ql-buffer-dispatch)
               :map minibuffer-mode-map
               ;; Be able to add titles in queries while in minibuffer.
               ;; This is similar to `org-roam-node-insert', but adds
               ;; only title as a string.
               ("C-c n i" . org-roam-ql-insert-node-title))))


(provide 'notes-module)
