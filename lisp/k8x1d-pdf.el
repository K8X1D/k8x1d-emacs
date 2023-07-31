;; -*- lexical-binding: t; -*-


(use-package pdf-tools
  :init
  (pdf-loader-install)
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode)
  )

(provide 'k8x1d-pdf)



