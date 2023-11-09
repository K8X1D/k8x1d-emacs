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
    "qs" '(k8x1d/server-shutdown :which-key "Server")
    )

  ;; Buffers
  (k8x1d/leader-keys
    "b"  '(:ignore t :which-key "Buffers")
    "bn" '(next-buffer :which-key "Next")
    "bp"  '(previous-buffer :which-key "Previous")
    "bs"  '(consult-buffer :which-key "Search")
    "bk"  '(k8x1d/kill-buffer-and-window :which-key "Kill")
    "bi"  '(ibuffer :which-key "List")
    )

  ;; Open
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "oa" '(org-agenda :which-key "Agenda")
    "op"  '(pass :which-key "Pass")
    "og"  '(guix :which-key "Guix")
    "ot"  '(eat-vertical :which-key "Terminal")
    "oT"  '(transmission :which-key "Transmission")
    "oB"  '(bluetooth-list-devices :which-key "Bluetooth")
    "ob"  '(citar-open :which-key "Bibliography")
    "oD"  '(dashboard-open :which-key "Dashboard")
    "or"  '(:ignore t :which-key "REPL")
    "orr"  '(k8x1d/open-R-repl-at-bottom t :which-key "R")
    "orj"  '(k8x1d/open-julia-repl-at-bottom t :which-key "Julia")
    "orp"  '(k8x1d/open-python-repl-at-bottom t :which-key "Python")
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
    "pt" '(eat-project-vertical :which-key "Terminal")
    "pm" '(minimap-mode :which-key "Minimap")
    )

  ;; Workspace
  (k8x1d/leader-keys
    "TAB" '(:keymap tabspaces-command-map
		    :package tabspaces
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
    "d"  '(:ignore t
		   :package org-gtd
		   :which-key "GTD")
    "dc" '(org-gtd-capture :which-key "Capture")
    "de" '(org-gtd-engage :which-key "Engage")
    "dp"  '(org-gtd-process-inbox :which-key "Process")
    "dn"  '(org-gtd-show-all-next :which-key "Show next")
    "da"  '(org-gtd-archive-completed-items :which-key "Archive completed")
    "dr"  '(org-gtd-review-area-of-focus :which-key "Review Area")
    )


  ;; Notes
  (k8x1d/leader-keys
    "n"  '(:ignore t :which-key "Notes")
    "nl" '(org-roam-buffer-toggle :which-key "List")
    "nf" '(org-roam-node-find :which-key "Find")
    "ng" '(org-roam-ui-open :which-key "Graph")
    "ni" '(org-roam-node-insert :which-key "Insert")
    "nc" '(org-roam-capture :which-key "Create")
    "nj" '(org-roam-dailies-capture-today :which-key "Journal")
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

  (k8x1d/local-leader-keys
    :keymaps 'LaTeX-mode-map
    "m" '(TeX-command-master :which-key "Master")
    "c" '(TeX-clean :which-key "Clean")
    "v" '(TeX-view :which-key "View")
    "i" '(:ignore t :which-key "Insert")
    "ie" '(LaTeX-environment :which-key "Environment")
    "ii" '(k8x1d/insert-latex-item-below :which-key "Item")
    "ic" '(citar-insert-citation :which-key "Citation")
    "s" '(:ignore t :which-key "Set")
    "sm" '(TeX-master-file-ask :which-key "Master file")
    )

  ;; Bibtex
  (k8x1d/local-leader-keys
    :keymaps 'bibtex-mode-map
    "i" '(:ignore t :which-key "Insert")
    "ir" '(citar-insert-bibtex :which-key "Reference")
    )


  ;; Scheme
  (k8x1d/local-leader-keys
    :keymaps 'scheme-mode-map
    "'" '(geiser-repl-switch :which-key "REPL")
    "b" '(geiser-eval-buffer :which-key "Eval buffer")
    )


  ;; Julia
  (k8x1d/local-leader-keys
    :keymaps 'julia-vterm-mode-map
    "'" '(k8x1d/open-julia-repl-at-bottom :which-key "REPL")
    "b" '(julia-vterm-send-buffer :which-key "Send buffer")
    "RET" '(julia-vterm-send-region-or-current-line :which-key "Eval buffer")
    "f" '(julia-vterm-send-include-buffer-file :which-key "Eval file")
    )




  )





(provide 'keybindings-module)
;;; keybindings-module.el ends here
