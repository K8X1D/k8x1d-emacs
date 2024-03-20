(use-package treesit-auto
  :hook (after-init . global-treesit-auto-mode)
  :custom
  (treesit-auto-install 'prompt)
  (treesit--install-language-grammar-out-dir-history (concat user-emacs-directory "tree-sitter"))
  :config

;; Its value is ("~/.config/emacs-test/tree-sitter")
  (treesit-auto-add-to-auto-mode-alist 'all))

(provide 'tree-sitter-module)
