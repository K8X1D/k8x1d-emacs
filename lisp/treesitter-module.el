

(use-package treesit-auto
  :hook (after-init . global-treesit-auto-mode)
  :config
  ;; Hook replacemetn
  ;; (setq python-ts-mode-hook python-mode-hook)
  ;; Prompt for install
  (setq treesit-auto-install 'prompt))



(provide 'treesitter-module)
