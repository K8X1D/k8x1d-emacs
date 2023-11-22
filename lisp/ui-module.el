;;; package --- Summary

;;; Commentary:

;;; Code:

;; Ui
(use-package emacs
  :bind
  ("<escape>" . keyboard-escape-quit)
  :hook (
	 (after-init . global-auto-revert-mode) ;; Update buffer when file change
	 (after-init . pixel-scroll-precision-mode) ;; Better scrolling effects
	 (after-init . (lambda () (blink-cursor-mode 0))) ;; stop cursor from blicking
	 ;; Programming ui
	 (prog-mode . hl-line-mode) ;; Highlight whole line
	 )
  :config
  (setq vc-follow-symlinks t)
  ;; Defaults browser
  (setq browse-url-browser-function 'browse-url-generic
	browse-url-generic-program "firefox")
  ;; native compil log level
  (setq warning-minimum-level :error)

  ;; Scrolling
  ;;(setq scroll-step 1)
  (setq scroll-conservatively 10000)
  (setq inhibit-compacting-font-caches t)
  ;; Keybindings
  ;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; ESC Cancels All
  )

;; Line number
(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode) ;; Show line number for programming mode
  :config
  (setq display-line-numbers 'relative)
  )

;; Theme
(use-package modus-themes
  :if (equal theme-framework "modus")
  :ensure nil
  :custom
  (modus-themes-org-blocks 'tinted-background)
  (modus-themes-markup t)
  (modus-themes-org-blocks 'tinted-background)
  (org-fontify-quote-and-verse-blocks t)
  (org-src-fontify-natively t)
  (modus-themes-mixed-fonts t)
  ;; (modus-themes-variable-pitch-ui t)
  (modus-themes-completions t)
  :init
  (load-theme 'modus-vivendi t)
  ;; :hook
  ;; (after-init . (lambda ()
  ;; 		  (load-theme 'modus-vivendi t)
  ;; 		  ;; (add-to-list 'org-src-block-faces '("julia" modus-themes-nuanced-magenta))
  ;; 		  ))
  :bind ("<f5>" . modus-themes-toggle)
  :config
  (with-eval-after-load 'org
    (add-to-list 'org-src-block-faces '("julia" modus-themes-nuanced-magenta))
    )
  ;; Adjust faces
  (custom-set-faces
   '(tab-bar ((t (:inherit t :box nil))))
   '(tab-bar-tab ((t (:inherit t :box nil)))))
  )


;; Highlights "TODOs"
(use-package hl-todo
  :hook
  (after-init . global-hl-todo-mode)
  )

;; Show keybindings
(use-package which-key
  :hook (after-init . which-key-mode))

(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



;; Window divider
(use-package emacs
  :hook (after-init . window-divider-mode)
  :config
  (setq window-divider-default-right-width 1)
  (setq window-divider-default-places 'right-only)
  )

;; Differentiate color for buffer
(use-package solaire-mode
  :if (equal theme-framework "modus")
  ;; :hook (after-init . solaire-global-mode)
  )

(provide 'ui-module)
;;; ui-module.el ends here
