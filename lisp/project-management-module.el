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
  (add-to-list 'project-switch-commands '(eat-project-other-window "Terminal" "t")) ;; add terminal to option list when switching project

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

;; Bookmark per project
(use-package bookmark-in-project
  :commands (bookmark-in-project-jump
             bookmark-in-project-jump-next
             bookmark-in-project-jump-previous
             bookmark-in-project-delete-all)

  ;; Example key bindings.
  :bind (("M-n" . bookmark-in-project-jump-next)
         ("M-p" . bookmark-in-project-jump-previous)
         ("M-*" . bookmark-in-project-toggle)
         ("M-o" . bookmark-in-project-jump)))



;;
;; Window configuration
;;
(use-package tab-bar
  :init
  ;; add space arount name in tab
  (defun k8x1d/tab-bar-tab-name-format (tab i)
    (let ((name (copy-sequence (alist-get 'name tab))))
      (run-hook-wrapped 'tab-bar-tab-name-format-functions
			(lambda (fun)
                          ;; (setq name (funcall fun name tab i))
                          (setq name (concat " " (funcall fun name tab i) " "))
			  nil))
      name))
  :hook (emacs-startup . tab-bar-mode)
  :config
  (setq tab-bar-select-tab-modifiers '(alt))
  (setq tab-bar-new-tab-choice "*scratch*")
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-show 'never)
  (setq tab-bar-tab-name-format-function #'k8x1d/tab-bar-tab-name-format)

  ;; tab show config
  ;; (setq tab-bar-show t)
  ;; (setq tab-bar-separator "")
  ;; (setq tab-bar-auto-width-max '(100 10))
  )

;;
;; workspaces management
;;
(use-package tabspaces
  :hook (after-init . tabspaces-mode)
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  (tabspaces-initialize-project-with-todo t)
  (tabspaces-todo-file-name "project-todo.org")
  ;; sessions
  ;; (tabspaces-session t)
  ;; (tabspaces-session-auto-restore t)
  )

;;
;; echo workspace 
;;
(use-package tab-bar-echo-area
  :init
  (defun k8x1d/tab-bar-echo-area-format-tab-name-for-joining (name type _tab index count)
    "Format NAME according to TYPE, INDEX and COUNT."
    (format (cond ((eq type 'current-group) "%s ")
		  ((eq index (1- count)) "%s")
		  (t "%s "))
	    name))
  :hook (tab-bar-mode . tab-bar-echo-area-mode)
  :config
  (setq tab-bar-echo-area-format-tab-name-functions '(k8x1d/tab-bar-echo-area-format-tab-name-for-joining))
  (setq tab-bar-echo-area-display-tab-names-format-string "%s")
  )

;;
;; Direnv support
;;
(use-package envrc
  :general
  (k8x1d/leader-keys
    "e" '(:keymap envrc-command-map
		  :package envrc
		  :which-key "Environment")
    )
  :hook (after-init . envrc-global-mode))



(provide 'project-management-module)
;;; project-management-module.el ends here
