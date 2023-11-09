;;; package --- Summary

;;; Commentary:

;;; Code:

;; Evil support
(use-package evil-markdown
  :vc (:url "https://github.com/Somelauw/evil-markdown"
	    :branch "main"))

;; Syntax highlight
(use-package markdown-mode
  :config
  (setq markdown-command "pandoc")
  )

;; Preview
(use-package markdown-preview-mode
  :bind (:map markdown-mode-map
	      ("C-c C-c p" . markdown-preview-open-browser)))

;; Checker
(use-package flymake-markdownlint
  :hook (markdown-mode . flymake-markdownlint-setup))

(provide 'markdown-module)
;;; markdown-module.el ends here
