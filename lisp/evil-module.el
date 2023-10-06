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

(use-package evil-goggles
  :hook (evil-mode . evil-goggles-mode)
  :config
  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

(provide 'evil-module)
;;; evil-module.el ends here
