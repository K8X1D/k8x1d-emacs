


;; Notes management
(use-package denote
  :config
  (setq denote-directory (concat org-directory "/notes"))
  (setq denote-knows-keywords '("arts" "methodics" "theoretics"))
  )


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
   )
  )


(provide 'denote-module)
