;;; package --- Summary
;;; Commentary:

;;; Code:


;;
;; Project interaction
;;
(use-package project
  :config
  ;; Expand project root identification, see https://blog.jmthornton.net/p/emacs-project-override
  (setq project-vc-extra-root-markers '(".project.el" ".projectile" ))
  (add-to-list 'project-switch-commands '(eat-project-other-window "Terminal")) ;; add terminal to option list when switching project

  ;; Prettify compilation buffer
  ;; https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
  (require 'ansi-color)
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  )

;; Enhance compilation buffer
(use-package fancy-compilation
  :commands (fancy-compilation-mode)
  :config
  (with-eval-after-load 'compile
    (fancy-compilation-mode)))


;;
;; Window configuration
;;
(use-package tab-bar
  :hook (emacs-startup . tab-bar-mode)
  :config
  ;;(setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-select-tab-modifiers '(alt))
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-show 'never)
  )

;;
;; Workspaces management
;;
(use-package tabspaces
  :hook (after-init . tabspaces-mode)
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  (tabspaces-initialize-project-with-todo t)
  (tabspaces-todo-file-name "project-todo.org")
  ;; sessions
  (tabspaces-session t)
  (tabspaces-session-auto-restore t))
  
(provide 'project-management-module)
;;; project-management-module.el ends here
