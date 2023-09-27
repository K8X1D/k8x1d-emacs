;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package geiser-guile)

(use-package flymake-guile
  :hook (scheme-mode-hook . flymake-guile))

(provide 'scheme-module)
;;; scheme-module.el ends here
