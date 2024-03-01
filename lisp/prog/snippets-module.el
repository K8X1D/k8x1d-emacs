;; Snippet manager
(use-package yasnippet 
  :hook ((prog-mode . yas-reload-all) 
	 (prog-mode . yas-minor-mode)))

;; Snippet collection
(use-package yasnippet-snippets)

;; consult integration collection
(use-package consult-yasnippet)

;; Cape integration
(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(provide 'snippets-module)
