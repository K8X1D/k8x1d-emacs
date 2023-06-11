
;; Main typeface

;; Fonts
;;(set-face-attribute 'default nil :font "Fira Code" :height 150)
(set-face-attribute 'default nil :font "Hack" :height 120)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
		    :font "Hack"
		    ;;:font "Fira Code"
		    :weight 'light
		    :height 1.0)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
		    ;; :font "Cantarell"
		    :font "Iosevka Aile"
		    ;;:font "DejaVu Sans"
		    :height 1.0
		    :weight 'light)


(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))



(provide 'k8x1d-fonts)
