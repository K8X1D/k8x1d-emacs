;; -*- lexical-binding: t; -*-


(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative))




(provide 'line-number-module)
