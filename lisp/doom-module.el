;;; package --- Summary

;;; Commentary:

;;; Code:


(use-package doom-themes
  :if (equal theme-framework "doom")
  :hook (after-init . (lambda ()
			(load-theme 'doom-palenight t)
			(solaire-global-mode +1)
			))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)

  ;; Customizations
  ;; Must be used *after* the theme is loaded
  (custom-set-faces
   ;; `(org-block ((t (:background "#45034d"))))
   `(org-block-begin-line ((t (:foreground ,(doom-color 'green)))))
   `(org-block-end-line ((t (:foreground ,(doom-color 'green)))))
   `(org-modern-bracket-line ((t (:foreground ,(doom-color 'green)))))
   ;; `(treemacs-hl-line-face ((t (:background ,(doom-color 'base4)))))
   `(window-divider ((t (:foreground ,(doom-color 'blue)))))
   `(corfu-current ((t (:foreground ,(doom-color 'green) :weight bold))))
   `(corfu-default ((t (:foreground ,(doom-color 'blue)))))
   `(orderless-match-face-0 ((t (:foreground ,(doom-color 'green) :background nil))))
   `(doom-modeline-bar ((t (:foreground ,(doom-color 'blue)))))

   ;; Flycheck
   '(flycheck-info ((t (:underline (:color "#c3e88d" :style line)))))
   )
  )

;; Modeline
(use-package doom-modeline
  :if (equal theme-framework "doom")
  :hook ((after-init . doom-modeline-mode)
	 (doom-modeline-mode . (lambda ()
				 (doom-modeline-set-modeline 'custom-modeline 'default)))
	 )
  :config
  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-state-icon nil)
  (setq doom-modeline-lsp nil)
  ;; (setq doom-modeline-major-mode-icon nil)
  ;; (setq doom-modeline-vcs-max-length 3)
  (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-bar-width 1)
  (setq doom-modeline-buffer-file-name-style 'file-name)
  ;; (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  ;; Define your custom doom-modeline
  (doom-modeline-def-modeline 'custom-modeline
    ;; '(modals eldoc workspace-name window-number matches follow buffer-info vcs remote-host word-count parrot selection-info)
    ;; '(time battery compilation objed-state misc-info grip irc mu4e gnus github debug repl checker lsp minor-modes input-method indent-info buffer-encoding process major-mode))
    ;; '(modals workspace-name matches follow buffer-info checker vcs remote-host word-count parrot selection-info)
    ;; '(compilation objed-state misc-info grip irc mu4e gnus github debug repl input-method indent-info buffer-encoding process time battery))
    '(modals workspace-name buffer-info vcs checker)
    '(battery compilation lsp major-mode minor-modes))
  )


;; Buffer differientate color
(use-package solaire-mode
  :if (equal theme-framework "doom")
  :config
  ;; (setq solaire-mode-themes-to-face-swap 'doom-palenight)
  ;; Customization
  (custom-set-faces
   ;; `(org-block ((t (:background "#45034d"))))
   ;; `(solaire-default-face ((t (:background ,(doom-color 'base0)))))
   ;; `(solaire-default-face ((t (:background "gray2"))))
   ;; `(solaire-default-face ((t (:background "gray6"))))
   `(solaire-default-face ((t (:background "gray11"))))
   )
  )

(provide 'doom-module)
;;; doom-module.el ends here
