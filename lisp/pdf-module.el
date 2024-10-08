;; -*- lexical-binding: t -*-

(use-package pdf-tools
             :mode "\\.pdf\\'"
             :init
             (pdf-loader-install)
             (setq pdf-view-display-size 'fit-page)
             :hook 
             (pdf-view-mode . pdf-view-fit-page-to-window)
             )

;; Zathura
;; (use-package latex
;;   :hook
;;   (TeX-after-compilation-finished-functions . TeX-revert-document-buffer)
;;   :config
;;   (setq TeX-view-program-selection '((output-pdf "Zathura"))
;; 	TeX-source-correlate-start-server t)
;;   )

;; Save last place 
(use-package saveplace-pdf-view
  :hook (pdf-view-mode . save-place-mode))


(provide 'pdf-module)
