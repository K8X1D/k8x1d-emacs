;;; package --- Summary

;;; Commentary:

;;; Code:

;;
;; Leader key management
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
    "h" '(:keymap help-map :which-key "Help")
    "f"  '(:ignore t :which-key "Find")
    "ff" '(find-file :which-key "File")
    "fs" '(save-buffer :which-key "Save")
    "q" '(:ignore t :which-key "Quit")
    "qq" '(save-buffers-kill-terminal :which-key "Emacs")
    )



  ;; Buffers
  (k8x1d/leader-keys
    "b"  '(:ignore t :which-key "Buffers")
    "bn" '(next-buffer :which-key "Next")
    "bp"  '(previous-buffer :which-key "Previous")
    "bs"  '(consult-buffer :which-key "Search")
    "bk"  '(kill-buffer :which-key "Kill")
    "bl"  '(ibuffer :which-key "List")
    )


  ;; Open
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "oa" '(org-agenda :which-key "Agenda")
    "op"  '(pass :which-key "Pass")
    "og"  '(guix :which-key "Guix")
    "ot"  '(vterm-toggle-cd :which-key "Terminal")
    "oT"  '(transmission :which-key "Transmission")
    "od"  '(dashboard-refresh-buffer :which-key "Dashboard")
    "or"  '(:ignore t :which-key "REPL")
    "orr"  '(R-vterm-repl t :which-key "R")
    "orj"  '(julia-vterm-repl t :which-key "Julia")
    "orp"  '(python-vterm-repl t :which-key "Python")
    )

  ;; Lsp
  (k8x1d/local-leader-keys
    "L" '(:keymap lsp-command-map
		  :package lsp-mode
		  :which-key "LSP")
    )
  ;; Project
  (k8x1d/leader-keys
    "p" '(:keymap project-prefix-map
		  :which-key "Project")
    "pb" '(consult-project-buffer :which-key "Switch to buffer")
    "po" '(:ignore t :which-key "Open")
    ;; "pt" '(multi-vterm-project :which-key "Terminal")
    "pt" '(eat-project-other-window :which-key "Terminal")
    "pe" '(treemacs :which-key "File explorer")
    )

  ;; Workspace
  (k8x1d/leader-keys
    "TAB" '(:keymap tab-prefix-map
		    :which-key "Workspace")
    )

  ;; Checker
  (k8x1d/local-leader-keys
    :keymaps 'flymake-mode-map
    "D" '(:ignore t :which-key "Diagnostic")
    "Db" '(flymake-show-buffer-diagnostics :which-key "List")
    "Dn" '(flymake-goto-next-error :which-key "Next")
    "Dp" '(flymake-goto-prev-error :which-key "Previous")
    "Ds" '(consult-flymake :which-key "Search")
    )

  ;; Evil
  (k8x1d/leader-keys
    "w" '(:keymap evil-window-map
		  :package evil
		  :which-key "Window")
    )

  ;; Multimedia
  (k8x1d/leader-keys
    "v" '(:keymap empv-map
		  :which-key "Video player")
    "M" '(:keymap mpdel-core-map
		  :package mpdel
		  :which-key "Music player")
    )

  ;; GTD
  (k8x1d/leader-keys
    "d"  '(:ignore t :which-key "GTD")
    "dc" '(org-gtd-capture :which-key "Capture")
    "de" '(org-gtd-engage :which-key "Engage")
    "dp"  '(org-gtd-process-inbox :which-key "Process")
    "dn"  '(org-gtd-show-all-next :which-key "Show next")
    )

  ;; GTD
  (k8x1d/leader-keys
    "g"  '(:ignore t :which-key "Git")
    "gg" '(magit :which-key "Status")
    )

  )

(provide 'keybindings-module)
;;; keybindings-module.el ends here
