;; -*- lexical-binding: t -*-


(use-package tab-bar
  :general
  (k8x1d/leader-keys
    "t" '(:keymap tab-prefix-map
		  :package evil
		  :which-key "Tabs")
   )
  :init
  ;; TODO: implement string triming
  (defvar k8x1d/org-clock-module-max-length 60)
  (defun tab-bar-org-clock-module ()
    (require 'org-clock)
    (when (org-clocking-p)
      (if (> (string-width org-mode-line-string) k8x1d/org-clock-module-max-length)
	  (format "%s)... " (string-limit org-mode-line-string k8x1d/org-clock-module-max-length))
	org-mode-line-string
	)
    ))
  :hook
  (after-init . tab-bar-mode)
  :config
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-format-align-right tab-bar-org-clock-module))
  (setq tab-bar-select-tab-modifiers '(meta))

  ;; Name adjustment
  (setq tab-bar-auto-width t)
  (setq tab-bar-auto-width-max '((100) 50))
  )








(provide 'tab-module)
