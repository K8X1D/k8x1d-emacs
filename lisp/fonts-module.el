;;; package --- Summary

;;; Commentary:

;;; Code:

;; Fonts
(use-package emacs
  :config
  (custom-set-faces
   '(default ((t (:inherit nil :height 120 :family "Iosevka Term Nerd Font"))))
   '(fixed-pitch ((t (:inherit nil :height 1.0 :family "Iosevka Term Nerd Font"))))
   '(variable-pitch ((t (:inherit nil :height 1.0 :family "Iosevka Nerd Font"))))
   )
  )

(provide 'fonts-module)
;;; fonts-module.el ends here
