;;; package --- Summary
;;; Commentary:
;;; Code:


;;
;; Project management
;;


;; Project
(use-package project
  :general
  (k8x1d/leader-keys
   "p" '(:keymap project-prefix-map
		 :which-key "Project"))
  (k8x1d/leader-keys
    "po" '(:ignore t :which-key "Open")
    "pb" '(consult-project-buffer :which-key "Switch to buffer")
   )
  :config
  ;; Expand project root identification, see https://blog.jmthornton.net/p/emacs-project-override
  (setq project-vc-extra-root-markers '(".project.el" ".projectile" ))

  ;; Prettify compilation buffer
  ;; See https://www.reddit.com/r/emacs/comments/kbwkca/compile_buffer_show_weird_symbols/
  ;; See https://stackoverflow.com/questions/20663005/why-does-shell-mode-display-some-rubbish-code
  ;; Still some left over... e.g. [[K...
  ;;(require 'ansi-color)
  ;; (defun colorize-compilation-buffer ()
  ;;   (ansi-color-apply-on-region compilation-filter-start (point)))
  ;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  ;; More up to date
  ;; https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
  (require 'ansi-color)
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  )



;; Project simple file explorer
(use-package dired-sidebar
  :after project
  :general
  (k8x1d/leader-keys
    "poe" '(dired-sidebar-toggle-sidebar :which-key "Explorer")
   )
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config

  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  ;;(setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(provide 'k8x1d-project)
;;; k8x1d-project.el ends here
