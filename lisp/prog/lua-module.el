;; Syntax highlight
(use-package lua-mode)


;; Checker
(use-package flymake-lua
  :hook (lua-mode . flymake-lua-load))


(provide 'lua-module)
