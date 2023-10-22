;;; package --- Summary

;;; Commentary:

;;; Code:


;; Icons
(use-package nerd-icons-completion
  :after marginalia
  :hook (vertico-mode . nerd-icons-completion-mode) 
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package kind-icon
  :defer nil
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'icons-module)
;;; icons-module.el ends here
