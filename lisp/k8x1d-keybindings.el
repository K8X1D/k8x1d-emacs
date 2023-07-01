

;; ESC Cancels All
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;;
;; Create leader keybinding
;;
					
(use-package general
  :config
  (general-evil-setup)

  (general-create-definer k8x1d/leader-keys
			  :states '(normal insert visual emacs)
			  :keymaps 'override
			  :prefix "SPC"
			  :global-prefix "C-SPC")

  (general-create-definer k8x1d/local-leader-keys
			  :states '(normal visual)
			  :keymaps 'override
			  :prefix ","
			  :global-prefix "SPC m")

  (k8x1d/leader-keys
   "<escape>" 'keyboard-escape-quit
   "f"  '(:ignore t :which-key "Find")
   "ff" '(find-file :which-key "File")
   "fs" '(save-buffer :which-key "Save")
   "o"  '(:ignore t :which-key "Open")
   "ot" '(multi-vterm-project :which-key "Terminal")
   "os" '(dired-sidebar-toggle-sidebar :which-key "Sidebar")
   "q" '(:ignore t :which-key "Quit")
   "qq" '(save-buffers-kill-terminal :which-key "Emacs")
   ))


(provide 'k8x1d-keybindings)
