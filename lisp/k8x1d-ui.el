;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package emacs
  :hook (
	 (after-init . global-hl-todo-mode) ;; Highlights "TODOs" 
	 (after-init . global-auto-revert-mode) ;; Update buffer when file change
	 (after-init . global-hl-line-mode) ;; Highlight whole line
	 (after-init . pixel-scroll-precision-mode) ;; Better scrolling effects
	 ;; Show line number for programming mode 
	 (prog-mode . display-line-numbers-mode)
	 (display-line-numbers-mode .  (lambda()
					 (setq display-line-numbers 'relative)
					 ))
	 )
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq vc-follow-symlinks t)
  ;; Defaults browser
  (setq browse-url-browser-function 'browse-url-generic
	browse-url-generic-program "firefox")
  ;; native compil log level
  (setq warning-minimum-level :error)

  ;; Scrolling
  ;;(setq scroll-step 1)
  (setq scroll-conservatively 10000)
  )

(use-package which-key
  :hook (after-init . which-key-mode))


;; Per buffer exposition
(use-package solaire-mode
  :hook (after-init . solaire-global-mode)
  )

(provide 'k8x1d-ui)
;;; k8x1d-ui.el ends here
