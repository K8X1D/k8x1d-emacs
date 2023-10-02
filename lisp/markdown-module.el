;;; package --- Summary

;;; Commentary:

;;; Code:

;; Evil support
(use-package evil-markdown
  :vc (:fetcher "github"  :repo "Somelauw/evil-markdown"))

;; Syntax highlight
(use-package markdown-mode)

;; Preview
(use-package markdown-preview-mode
  :hook (markdown-mode . markdown-preview-mode))

;; Checker
(use-package flymake-markdownlint
  :hook (markdown-mode . flymake-markdownlint-setup))

(provide 'markdown-module)
;;; markdown-module.el ends here
