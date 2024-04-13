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

(provide 'workspaces-management-module)
