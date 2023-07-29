;; -*- lexical-binding: t; -*-


(use-package pdf-tools
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode)
  :config
  (pdf-loader-install)
  )

(provide 'k8x1d-pdf)



