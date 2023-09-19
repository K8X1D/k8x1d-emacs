

;; Icons
(use-package all-the-icons
  :if (display-graphic-p))


;; Add icons to ibuffer
(use-package all-the-icons-ibuffer
  :hook
  (ibuffer-mode . all-the-icons-ibuffer-mode))


;; Add icons to completion
;; (use-package all-the-icons-completion
;; :hook
;; (vertico-mode . all-the-icons-completion-mode))
(use-package nerd-icons-completion
  :hook
  (vertico-mode . nerd-icons-completion-mode)
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))


;; Add icons to corfu
(use-package kind-icon
  :defer nil
  :after corfu
  :config
  (setq kind-icon-default-face 'corfu-default) ;; to compute blended backgrounds correctly
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Add icons to dired
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))




(provide 'k8x1d-icons)
