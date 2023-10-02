;;; package --- Summary

;;; Commentary:

;;; Code:


(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
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
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  ;; (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; Don't work, refreshing buffer ends on nil
;; (use-package ibuffer-sidebar
;; :commands (ibuffer-sidebar-toggle-sidebar)
;; :config
;; (setq ibuffer-sidebar-use-custom-font t)
;; (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140)))




(provide 'sidebar-module)
;;; sidebar-module.el ends here
