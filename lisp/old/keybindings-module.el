



;; ESC Cancels All
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;;
;; Create leader keybinding
;;
					
(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer k8x1d/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))


(k8x1d/leader-key-def
  "f"  '(:ignore t :which-key "Find")
  "ff" '(find-file :which-key "File")
  "fs" '(save-some-buffers :which-key "Save")
  "o"  '(:ignore t :which-key "Open")
  "oa" '(org-agenda :which-key "Agenda")
  "ot" '(multi-vterm-project :which-key "Terminal")
  "os" '(dired-sidebar-toggle-sidebar :which-key "Sidebar")
  "w" '(:ignore t :which-key "Window")
  "wc" '(evil-window-delete :which-key "Delete")
  "ws" '(evil-window-split :which-key "Split")
  "wv" '(evil-window-vsplit :which-key "Vsplit")
  "wh" '(evil-window-left :which-key "Left")
  "wj" '(evil-window-down :which-key "Down")
  "wk" '(evil-window-up :which-key "Up")
  "wl" '(evil-window-right :which-key "Right")
  "wH" '(evil-window-move-far-left :which-key "Move Left")
  "wJ" '(evil-window-move-very-bottom :which-key "Move Down")
  "wK" '(evil-window-move-very-top :which-key "Move Up")
  "wL" '(evil-window-move-far-right :which-key "Move Right")
  )



(provide 'keybindings-module)
