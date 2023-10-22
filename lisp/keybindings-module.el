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
    "bk"  '(k8x1d/kill-buffer-and-window :which-key "Kill")
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
    "oD"  '(dashboard-open :which-key "Dashboard")
    "od"  '(dirvish :which-key "Dirvish")
    "or"  '(:ignore t :which-key "REPL")
    "orr"  '(R-vterm-repl t :which-key "R")
    "orj"  '(julia-vterm-repl t :which-key "Julia")
    "orp"  '(python-vterm-repl t :which-key "Python")
    "oc" '(org-clock-goto :which-key "Clocked Task")
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
    "pm" '(minimap-mode :which-key "Minimap")
    ;; "pe" '(treemacs :which-key "File explorer")
    "pe" '(dirvish-side :which-key "File explorer")
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

  ;; Org
  (k8x1d/local-leader-keys
    :keymaps 'flymake-mode-map
    "D" '(:ignore t :which-key "Diagnostic")
    "Db" '(flymake-show-buffer-diagnostics :which-key "List")
    "Dn" '(flymake-goto-next-error :which-key "Next")
    "Dp" '(flymake-goto-prev-error :which-key "Previous")
    "Ds" '(consult-flymake :which-key "Search")
    )

  ;; Org
  (k8x1d/local-leader-keys
   :keymaps 'org-mode-map
   "i" '(:ignore t :which-key "Insert")
   "if" '(org-footnote-new :which-key "Footnote")
   "il" '(org-insert-link :which-key "Link")
   "it" '(org-insert-structure-template :which-key "Template")
   "ic" '(org-cite-insert :which-key "Citation")
   "id" '(:ignore t :which-key "Date")
   "idd" '(org-deadline :which-key "Deadline")
   "ids" '(org-schedule t :which-key "Schedule")
   "id." '(org-time-stamp t :which-key "Timestamp")
   "ip" '(org-set-property :which-key "Property")
   "t" '(org-todo :which-key "Todo")
   "o" '(org-open-at-point :which-key "Open")
   "e" '(org-export-dispatch :which-key "Export")
   "c" '(:ignore t  :which-key "Clock")
   "ci" '(org-clock-in :which-key "In")
   "co" '(org-clock-out :which-key "Out")
   )

  ;; Latex
  (k8x1d/local-leader-keys
   :keymaps 'LaTeX-mode-map
   "m" '(TeX-command-master :which-key "Master")
   "c" '(TeX-clean :which-key "Clean")
   "v" '(TeX-view :which-key "View")
   "s" '(:ignore t :which-key "Set")
   "sm" '(TeX-master-file-ask :which-key "Master file")
   )


  ;; Scheme
  (k8x1d/local-leader-keys
   :keymaps 'scheme-mode-map
   "'" '(geiser-repl-switch :which-key "REPL")
   "b" '(geiser-eval-buffer :which-key "Eval buffer")
   )

  ;; Bibliography
  (k8x1d/leader-keys
    "b"  '(:ignore t :which-key "Bibliography")
    "bf"  '(citar-open-files :which-key "File")
    "bn"  '(citar-open-note :which-key "Note")
    "bc"  '(citar-create-note :which-key "Create note")
    )

  )





(provide 'keybindings-module)
;;; keybindings-module.el ends here
