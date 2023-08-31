(use-package tab-bar
  :hook (emacs-startup . tab-bar-mode)
  :config
  (setq tab-bar-show nil)
  (setq tab-bar-new-tab-choice "*scratch*")
  ;;(setq tab-bar-new-tab-choice "*dashboard*")
  (setq tab-bar-select-tab-modifiers '(alt))
  )

(use-package tabspaces
  :init
  ;; Included Buffers
  (defun k8x1d/tabspace-setup ()
    "Set up tabspace at startup."
    ;; Add *Messages* and *startup* to Tab \`Home\'
    (tabspaces-mode 1)
    (progn
      (tab-bar-rename-tab "Home")
      (when (get-buffer "*Messages*")
	(set-frame-parameter nil
			     'buffer-list
			     (cons (get-buffer "*Messages*")
				   (frame-parameter nil 'buffer-list))))
      (when (get-buffer "*startup*")
	(set-frame-parameter nil
			     'buffer-list
			     (cons (get-buffer "*startup*")
				   (frame-parameter nil 'buffer-list))))))
  :general
  (k8x1d/leader-keys
    "TAB" '(:keymap tabspaces-command-map
		    :which-key "Workspaces")
    )
  :hook ((after-init . tabspaces-mode)
	 (after-init . k8x1d/tabspace-setup))
  :config
  (setq tabspaces-use-filtered-buffers-as-default t)
  (setq tabspaces-default-tab "Default")
  (setq tabspaces-remove-to-default t)
  (setq tabspaces-include-buffers '("*scratch*"))
  ;; Filter Buffers for Consult-Buffer
  (with-eval-after-load 'consult
    ;; hide full buffer list (still available with "b" prefix)
    (consult-customize consult--source-buffer :hidden t :default nil)
    ;; set consult-workspace buffer list
    (defvar consult--source-workspace
      (list :name     "Workspace Buffers"
	    :narrow   ?w
	    :history  'buffer-name-history
	    :category 'buffer
	    :state    #'consult--buffer-state
	    :default  t
	    :items    (lambda () (consult--buffer-query
				  :predicate #'tabspaces--local-buffer-p
				  :sort 'visibility
				  :as #'buffer-name)))

      "Set workspace buffer list for consult-buffer.")
    (add-to-list 'consult-buffer-sources 'consult--source-workspace))
  )

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


