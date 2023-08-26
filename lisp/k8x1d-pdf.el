;;; package --- Summary



;;; Commentary:

;;; Code:

(use-package pdf-tools
  :init
  (pdf-loader-install)
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode)
  )

(provide 'k8x1d-pdf)
;;; k8x1d-pdf.el ends here
