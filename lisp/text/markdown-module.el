;; Markdown support
(use-package markdown-mode
  :mode "\\.md\\'"
  :hook (markdown-mode . hl-todo-mode)
  :config
  (setq markdown-command "pandoc")
  (setq markdown-asymmetric-header t)
  )

;; Preview in browser
(use-package markdown-preview-mode
  :init
  (defun k8x1d/markdown-preview ()
    (mardown-preview-mode 1)
    (markdown-preview-cleanup)
    )
  :bind (:map markdown-mode-map
              ("C-c C-c p" . markdown-preview-open-browser)))


;; Automatic toc management
(use-package toc-org
  :after markdown
  ;; :requires toc-org
  :hook (markdown-mode . toc-org-mode)
  :bind (:map markdown-mode-map
	      ("C-c C-o" . toc-org-markdown-follow-thing-at-point)))

;; Citar integration
(use-package citar
  :after markdown
  :config
  (require 'citar-markdown)
  )

(provide 'markdown-module)
