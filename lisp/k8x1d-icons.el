




(use-package all-the-icons
  :if (display-graphic-p)
      :config
      ;; Make sure the icon fonts are good to go
      (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append))



;; Add icons to ibuffer
(use-package all-the-icons-ibuffer
  :hook
  (ibuffer-mode . all-the-icons-ibuffer-mode))


;; add icons to completion
(use-package all-the-icons-completion
  :hook
  (vertico-mode . all-the-icons-completion-mode))


;; Icons support for corfu
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


;; add icon to dired
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))




(provide 'k8x1d-icons)
