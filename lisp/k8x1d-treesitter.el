;; From https://www.masteringemacs.org/article/how-to-get-started-tree-sitter

;; Set source for treesitter
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    ;; (go "https://github.com/tree-sitter/tree-sitter-go")
     (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
     (html "https://github.com/tree-sitter/tree-sitter-html")
   ;;  (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (julia "https://github.com/tree-sitter/tree-sitter-julia")
     (make "https://github.com/alemuller/tree-sitter-make")
     ;;(markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (r "https://github.com/r-lib/tree-sitter-r")
    ;; (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
    ;; (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Automatic install
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
(dolist (ts-language (mapcar #'car treesit-language-source-alist))
  (unless (treesit-language-available-p ts-language)
    (treesit-install-language-grammar ts-language)))



(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
	(bash-mode . bash-ts-mode)
	;; (js2-mode . js-ts-mode)
	;; (typescript-mode . typescript-ts-mode)
	;;(ess-r-mode . r-ts-mode)
	(json-mode . json-ts-mode)
	(css-mode . css-ts-mode)
	(julia-mode . julia-ts-mode)
	(python-mode . python-ts-mode)))

(provide 'k8x1d-treesitter)
