;;; package --- Summary

;;; Commentary:

;;; Code:

;; Python
(use-package python
  :hook (python-mode . eglot-ensure)
  :config
  (setq python-indent-offset 4)
  (setq python-indent-guess-indent-offset-verbose nil)
)

(provide 'python-module)
;;; python-module.el ends here
