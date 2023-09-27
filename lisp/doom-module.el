;;; package --- Summary

;;; Commentary:

;;; Code:


(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (modus-themes--disable-themes)
  (load-theme 'doom-palenight t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Modeline
(use-package doom-modeline
  :init
  :hook ((after-init . doom-modeline-mode)
	 (doom-modeline-mode . (lambda ()
				 (doom-modeline-set-modeline 'custom-modeline 'default))))
  :config
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-state-icon nil)
  ;; Define your custom doom-modeline
  (doom-modeline-def-modeline 'custom-modeline
    '(eldoc bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl checker lsp minor-modes input-method indent-info buffer-encoding process vcs time major-mode))
  )

;; Remove tab-bar
(use-package tab-bar
  :config
  (setq tab-bar-show 'never)
  )

(provide 'doom-module)
;;; doom-module.el ends here
