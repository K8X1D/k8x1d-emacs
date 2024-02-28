(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :hook (after-init . evil-mode ))

(use-package evil-collection
  :hook (evil-mode . evil-collection-init))


(provide 'evil-module)
