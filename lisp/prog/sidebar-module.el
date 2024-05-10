;; Project sidebar
(use-package dired-sidebar
    :bind (:map project-prefix-map
                ("e" . dired-sidebar-toggle-sidebar))
    :commands (dired-sidebar-toggle-sidebar)
    :init
    (add-hook 'dired-sidebar-mode-hook
              (lambda ()
                (unless (file-remote-p default-directory)
                  (auto-revert-mode))))
    ;; (defun sidebar-toggle ()
    ;; "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
    ;; (interactive)
    ;; (dired-sidebar-toggle-sidebar)
    ;; (ibuffer-sidebar-toggle-sidebar))
    ;; :hook (dired-sidebar-mode . visual-line-mode)
    :custom-face  (dired-sidebar-face ((t (:weight bold))))
    :config
    (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
    (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

    (setq dired-sidebar-subtree-line-prefix "__")
    ;; (setq dired-sidebar-theme 'vscode)
    (setq dired-sidebar-use-term-integration t)
    ;; (setq dired-sidebar-use-custom-font t)
    )

(use-package minimap
  :bind (:map project-prefix-map
	      ("m" . minimap-mode))
  :config
  (setq minimap-window-location 'right)
  (setq minimap-update-delay 0)
  (setq minimap-width-fraction 0.09)
  (setq minimap-minimum-width 15)
  )

(provide 'sidebar-module)
