;;; package --- Summary

;;; Commentary:

;;; Code:

;; Snippet provider
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  )

;; Collection of snippets
(use-package yasnippet-snippets
  :defer t)


;; Consult support
(use-package consult-yasnippet
  :bind ("M-g s" . consult-yasnippet))

;; Capf support
(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))


(provide 'snippets-module)
;;; snippets-module.el ends here
