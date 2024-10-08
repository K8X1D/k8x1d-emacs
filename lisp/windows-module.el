;; -*- lexical-binding: t; -*-

(use-package frame
  :ensure nil
  :hook
  (after-init . window-divider-mode)
  :config
  (setq window-divider-default-places t)
  (setq window-divider-default-right-width 2)
  (setq window-divider-default-bottom-width 2)
  )


(provide 'windows-module)
