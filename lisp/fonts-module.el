;; Fonts
(custom-set-faces
 '(default ((t (:inherit nil :height 120 :family "Iosevka Nerd Font"))))
 '(fixed-pitch ((t (:inherit nil :height 1.0 :family "Iosevka Nerd Font"))))
 '(variable-pitch ((t (:inherit nil :height 1.0 :family "Arimo Nerd Font" :weight light))))
 )


;; TODO: adjust sequence, not loaded when launched in daemon-mode
(use-package org-modern
  :config
  (setq org-modern-todo-faces
	`(("TODO" :background ,(doom-color 'red) :foreground "#1c1f2b" :family "Iosevka Nerd Font")
	  ("NEXT" :background ,(doom-color 'green) :foreground "#1c1f2b" :family "Iosevka Nerd Font")
	  ("WAIT" :background ,(doom-color 'yellow) :foreground "#1c1f2b" :family "Iosevka Nerd Font")))
  )

(provide 'fonts-module)
