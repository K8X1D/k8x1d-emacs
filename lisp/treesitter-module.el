;; ;; -*- lexical-binding: t -*-
;; 
;; ;; see https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
;; (use-package treesit-auto
;;   :hook (after-init . global-treesit-auto-mode) 
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (setq treesit-auto-install 'prompt)
;; 
;;   ;; Latex
;;   ;; Don't work, written in java...
;;   ;; (setq my-tex-tsauto-config
;;   ;;       (make-treesit-auto-recipe
;;   ;;        :lang 'latex
;;   ;;        :ts-mode 'latex-ts-mode
;;   ;;        :remap '(latex-mode LaTeX-mode tex-mode)
;;   ;;        :url "https://github.com/latex-lsp/tree-sitter-latex"
;;   ;;        :revision "master"
;;   ;;        :source-dir "src"
;;   ;;        :ext "\\.tex\\'"))
;; 
;; ;; (add-to-list 'treesit-auto-recipe-list my-tex-tsauto-config)
;;   )

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  ;; Transfer hook
  (setq python-ts-mode-hook python-mode-hook)
  (setq julia-ts-mode-hook julia-mode-hook)

  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))


(provide 'treesitter-module)
