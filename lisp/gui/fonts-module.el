;; Font
(use-package emacs
  :custom-face  (default ((t (:inherit nil :height 120 :family "Iosevka Nerd Font"))))
		 (fixed-pitch ((t (:inherit nil :height 1.0 :family "Iosevka Nerd Font"))))
		 (variable-pitch ((t (:inherit nil :height 1.0 :family "Arimo Nerd Font" :weight light)))
		 ))


;; TODO: adjust sequence, not loaded when launched in daemon-mode
(use-package org-modern
  :custom-face (org-modern-done ((t (:family "Iosevka Nerd Font"))))
  :config
  ;; (setq org-modern-todo-faces nil)
  (setq org-modern-todo-faces
	`(("TODO" :background ,(doom-color 'red) :foreground ,(doom-color 'bg) :family "Iosevka Nerd Font")
	  ("NEXT" :background ,(doom-color 'green) :foreground ,(doom-color 'bg)  :family "Iosevka Nerd Font")
	  ("WAIT" :background ,(doom-color 'yellow) :foreground ,(doom-color 'bg)  :family "Iosevka Nerd Font")))
  )

(provide 'fonts-module)
