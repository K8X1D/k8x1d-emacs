;; -*- lexical-binding: t -*-

(use-package markdown-mode
  :mode "\\.md\\'"
  :config
  (setq markdown-enable-highlighting-syntax t)
  )


;; Evil integration
;; (use-package evil-markdown
;;   :hook
;;   (markdown-mode . evil-markdown-mode)
;;   )

(provide 'markdown-module)
