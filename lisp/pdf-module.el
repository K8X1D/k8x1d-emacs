(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  ;; (pdf-loader-install)
  (setq-default pdf-view-display-size 'fit-page)
  ;; Enable hiDPI support, but at the cost of memory! See politza/pdf-tools#51
  (setq pdf-view-use-scaling t
        pdf-view-use-imagemagick nil)
  )

(provide 'pdf-module)
