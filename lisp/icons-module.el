

;; Icons
(use-package nerd-icons
  :config
  (setq nerd-icons-font-family "Iosevka Nerd Font")
  )

;; Icons support for dired
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; Icons support for ibuffer
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; Icons support for corfu
(use-package nerd-icons-corfu
  :after corfu
  :init
  ;; Optionally:
  (setq nerd-icons-corfu-mapping
	'((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
          (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
          ;; ...
          (t :style "cod" :icon "code" :face font-lock-warning-face)))
  ;; Remember to add an entry for `t', the library uses that as default.
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  )

;; Add icon to mini-buffer
(use-package nerd-icons-completion
  :after marginalia
  :hook ((after-init . nerd-icons-completion-mode)
	 (marginalia-mode  . nerd-icons-completion-marginalia-setup)))

(provide 'icons-module)
