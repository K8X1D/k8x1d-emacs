;; Use native project.el and tab-bar to isolate workspaces
(use-package tabspaces
    :hook (after-init . tabspaces-mode)
    :commands (tabspaces-switch-or-create-workspace
               tabspaces-open-or-create-project-and-workspace)
    :custom
    (tabspaces-use-filtered-buffers-as-default t)
    (tabspaces-default-tab "default")
    (tabspaces-remove-to-default t)
    (tabspaces-include-buffers '("*scratch*"))
    (tabspaces-initialize-project-with-todo nil)
    (tabspaces-todo-file-name "todo.org")
    ;; sessions
    (tabspaces-session t)
    ;; (tabspaces-session-auto-restore t)
    :init
    (defun k8x1d/tabspaces-switch-or-create-workspace (&optional workspace)
      "Switch to tab if it exists, otherwise create a new tabbed workspace."
      (interactive
       (let ((tabs (tabspaces--list-tabspaces)))
	 (cond ((eq tabs nil)
		(tab-new)
		(tab-rename (format " %s " (completing-read "Workspace name: " tabs))))
	       (t
		(list
		 (completing-read "Select or create tab: " tabs nil nil))))))
      (cond ((member workspace (tabspaces--list-tabspaces))
	     (tab-bar-switch-to-tab workspace))
	    (t
	     (tab-new)
	     (tab-rename workspace))))
    :bind (:map tabspaces-mode-map
		([remap tabspaces-switch-or-create-workspace] . k8x1d/tabspaces-switch-or-create-workspace)
		)
    )

;; Consult integration
(use-package tabspaces
  :config
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



;; General Keybindings
(use-package tabspaces
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "TAB" '(:keymap tabspaces-command-map
		   :package tabspaces
		   :which-key "Workspace")
   )
  )



(provide 'workspaces-management-module)
