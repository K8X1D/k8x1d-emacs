(use-package tab-bar
  :after project
  :config
  (setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  ;;(setq tab-bar-new-tab-choice "*dashboard*")
  (setq tab-bar-select-tab-modifiers '(alt))
  )

(use-package tabspaces
  :general
  (k8x1d/leader-keys
   "TAB"  '(:ignore t :which-key "Workspaces")
   "TAB o" '(tabspaces-open-or-create-project-and-workspace :which-key "Open project")
   "TAB d" '(tabspaces-kill-buffers-close-workspace :which-key "Close")
   "TAB s" '(tabspaces-switch-to-buffer :which-key "Select/Create")
   "TAB n" '(tab-new :which-key "Create")
   "TAB r" '(tab-rename :which-key "Rename")
    )
  :hook (after-init . tabspaces-mode) 
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  ;;:bind (:map project-prefix-map
  ;;       ("p" . tabspaces-open-or-create-project-and-workspace))
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  ;;;; sessions
  ;;(tabspaces-session t)
  ;;(tabspaces-session-auto-restore t)
  )

;; FIXME: Ispell message is covering tab bar name for text file...
(use-package tab-bar-echo-area
  :config
  ;; prevent ispell message covering tab bar name
  (setq inhibit-message-regexps '("ispell"))
  (setq set-message-functions '(inhibit-message))
  :hook
  (after-init . tab-bar-echo-area-mode)
 ;; :config
 ;; ;; Stop ispell message covering tab-bar 
 ;; (defun message-off-advice (oldfun &rest args)
 ;;   "Quiet down messages in adviced OLDFUN."
 ;;   (let ((message-off (make-symbol "message-off")))
 ;;     (unwind-protect
 ;;	  (progn
 ;;	    (advice-add #'message :around #'ignore (list 'name message-off))
 ;;	    (apply oldfun args))
 ;;	(advice-remove #'message message-off))))
 ;; (advice-add #'ispell-init-process :around #'message-off-advice)
  )

(inhibit-message "ispell")




(provide 'k8x1d-workspaces)


