

;; ESC Cancels All
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; esc break windowing, try alternative  
;;(global-set-key (kbd "<escape>") 'keyboard-quit)

;;
;; Create leader keybinding
;;
					
(use-package general
  :config
  (general-evil-setup)

  (general-create-definer k8x1d/leader-keys
			  :states '(normal insert visual emacs motion)
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
   "B"  '(:ignore t :which-key "Bookmarks")
   "Bg"  '(bookmark-jump :which-key "Goto")
   "Bm"  '(bookmark-set :which-key "Set")
   "Br"  '(bookmark-delete :which-key "Remove")
   "h" '(:keymap help-map
		  :which-key "Help")
   ;; "h"  '(:ignore t :which-key "Help")
   ;; "hv"  '(describe-variable :which-key "Variable")
   ;; "hf"  '(describe-function :which-key "Function")
   ;; "hF"  '(describe-face :which-key "Face")
   "f"  '(:ignore t :which-key "Find")
   "ff" '(find-file :which-key "File")
   "fs" '(save-buffer :which-key "Save")
   "o"  '(:ignore t :which-key "Open")
   "os" '(dired-sidebar-toggle-sidebar :which-key "Sidebar")
   "or"  '(:ignore t :which-key "REPL")
   "q" '(:ignore t :which-key "Quit")
   "qq" '(save-buffers-kill-terminal :which-key "Emacs")
   ))


(provide 'k8x1d-keybindings)
