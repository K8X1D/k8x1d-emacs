;;; package --- Summary

;;; Commentary:

;;; Code:

;; Cheker
(use-package flymake
  :hook (prog-mode . flymake-mode))

(use-package flymake-collection
  :hook (after-init . flymake-collection-hook-setup))

(provide 'checker-module)
;;; checker-module.el ends here
