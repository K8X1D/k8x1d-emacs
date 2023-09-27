;;; package --- Summary

;;; Commentary:

;;; Code:

;; Fonts
(use-package emacs
  :config
  ;; Main typeface
  (set-face-attribute 'default nil
		      :font "Iosevka Term Nerd Font"
		      :height 120
		      )
  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil
		      :font "Iosevka Term Nerd Font"
		      :weight 'light
		      :height 1.0
		      )
  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil
		      :font "Iosevka Nerd Font"
		      :weight 'light
		      :height 1.0
		      )
  )

(provide 'fonts-module)
;;; fonts-module.el ends here
