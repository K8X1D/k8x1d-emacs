


;; Notes management
(use-package denote
  :config
  (setq denote-directory (concat org-directory "/notes"))
  (setq denote-directory k8x1d/denote-directory)
  (setq denote-known-keywords '("arts" "methodics" "theoretics"))
  )

;; Show links and backlinks in Denote notes
(use-package denote-refs)

;; View denote files in a tabulated list.
(use-package denote-menu)

;; Explorer for notes
(use-package denote-explore
  :after denote
  :custom
  ;; Location of graph files
  (denote-explore-network-directory (concat denote-directory "/graphs/"))
  (denote-explore-network-filename "denote-network")
  ;; Output format
  (denote-explore-network-format 'graphviz)
  (denote-explore-network-graphviz-filetype "svg")
  ;; Exlude keywords or regex
  (denote-explore-network-keywords-ignore '("bib")))

;; Citar integration
(use-package citar-denote)


;; Keybindings
(use-package denote 
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "d"  '(:ignore t :which-key "Denote")
   "dc"  '(denote-create-note :which-key "Create note")
   "dl"  '(denote-menu-list-notes :which-key "List notes")
   )
  )


(provide 'denote-module)
