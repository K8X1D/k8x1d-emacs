;;; package --- Summary

;;; Commentary:

;;; Code:


;; Evil
(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :hook ((after-init . evil-mode)
	 (with-editor-mode . evil-insert-state)
	 (org-capture-mode . evil-insert-state))
  :config
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :after org
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
  (evil-org-agenda-set-keys))



(provide 'evil-module)
;;; evil-module.el ends here
