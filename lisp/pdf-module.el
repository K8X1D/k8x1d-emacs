;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package pdf-tools
  :init
  (pdf-loader-install)
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode)
  )

(provide 'pdf-module)
;;; pdf-module.el ends here
