;;; package --- Summary

;;; Commentary:

;;; Code:

;; Workspaces
(use-package tab-bar
  :hook (emacs-startup . tab-bar-mode)
  :config
  ;;(setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-select-tab-modifiers '(alt))
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  )

(provide 'workspace-module)
;;; workspace-module.el ends here
