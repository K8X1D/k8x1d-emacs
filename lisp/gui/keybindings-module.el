;; Show keybindings 
(use-package which-key
  :hook (after-init . which-key-mode)
  :config 
  ;; (setq which-key-separator ": ")
  ;; From doom emacs
  (setq which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10)
  )

;; Which-Key popup in posframe
(use-package whick-key-posframe
  :if k8x1d/posframe-support
  :hook (which-key-mode . which-key-posframe-mode)
  :config
  (setq which-key-posframe-poshandler 'posframe-poshandler-frame-center)
  (setq which-key-posframe-parameters
	'((left-fringe . 10)
	  (right-fringe . 10)
	  (alpha-background . 100) ;; no transparency
	  ))
  )

(use-package general
  :if k8x1d/use-general-keybindings
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

  ;;;; Open
  ;;(k8x1d/leader-keys
  ;;  "o"  '(:ignore t :which-key "Open")
  ;;  "oa" '(org-agenda :which-key "Agenda")
  ;;  "op"  '(pass :which-key "Pass")
  ;;  "og"  '(guix :which-key "Guix")
  ;;  ;; "ot"  '(eat-vertical :which-key "Terminal")
  ;;  "oT"  '(transmission :which-key "Transmission")
  ;;  "oB"  '(bluetooth-list-devices :which-key "Bluetooth")
  ;;  "ob"  '(citar-open :which-key "Bibliography")
  ;;  "oD"  '(dashboard-open :which-key "Dashboard")
  ;;  "oc" '(org-clock-goto :which-key "Clocked Task")
  ;;  )

  ;;;; Notes
  ;;(k8x1d/leader-keys
  ;;  "n"  '(:ignore t :which-key "Notes")
  ;;  "nl" '(org-roam-buffer-toggle :which-key "List")
  ;;  "nf" '(org-roam-node-find :which-key "Find")
  ;;  "ng" '(org-roam-ui-open :which-key "Graph")
  ;;  "ni" '(org-roam-node-insert :which-key "Insert")
  ;;  "nc" '(org-roam-capture :which-key "Create")
  ;;  "nj" '(org-roam-dailies-capture-today :which-key "Journal")
  ;;  )
  ;;;; Org
  ;;(k8x1d/local-leader-keys
  ;;  :keymaps 'flymake-mode-map
  ;;  "D" '(:ignore t :which-key "Diagnostic")
  ;;  "Db" '(flymake-show-buffer-diagnostics :which-key "List")
  ;;  "Dn" '(flymake-goto-next-error :which-key "Next")
  ;;  "Dp" '(flymake-goto-prev-error :which-key "Previous")
  ;;  "Ds" '(consult-flymake :which-key "Search")
  ;;  )

  ;;;; Org
  ;;(k8x1d/local-leader-keys
  ;;  :keymaps 'org-mode-map
  ;;  "i" '(:ignore t :which-key "Insert")
  ;;  "if" '(org-footnote-new :which-key "Footnote")
  ;;  "il" '(org-insert-link :which-key "Link")
  ;;  "it" '(org-insert-structure-template :which-key "Template")
  ;;  "ic" '(org-cite-insert :which-key "Citation")
  ;;  "id" '(:ignore t :which-key "Date")
  ;;  "idd" '(org-deadline :which-key "Deadline")
  ;;  "ids" '(org-schedule t :which-key "Schedule")
  ;;  "id." '(org-time-stamp t :which-key "Timestamp")
  ;;  "ip" '(org-property-action :which-key "Property")
  ;;  "t" '(org-todo :which-key "Todo")
  ;;  "o" '(org-open-at-point :which-key "Open")
  ;;  "e" '(org-export-dispatch :which-key "Export")
  ;;  "c" '(:ignore t  :which-key "Clock")
  ;;  "ci" '(org-clock-in :which-key "In")
  ;;  "co" '(org-clock-out :which-key "Out")
  ;;  )

  ;;(k8x1d/local-leader-keys
  ;;  :keymaps 'LaTeX-mode-map
  ;;  "m" '(TeX-command-master :which-key "Master")
  ;;  "c" '(TeX-clean :which-key "Clean")
  ;;  "v" '(TeX-view :which-key "View")
  ;;  "i" '(:ignore t :which-key "Insert")
  ;;  "ie" '(LaTeX-environment :which-key "Environment")
  ;;  "ii" '(k8x1d/insert-latex-item-below :which-key "Item")
  ;;  "ic" '(citar-insert-citation :which-key "Citation")
  ;;  "s" '(:ignore t :which-key "Set")
  ;;  "sm" '(TeX-master-file-ask :which-key "Master file")
  ;;  )

  ;;;; Bibtex
  ;;(k8x1d/local-leader-keys
  ;;  :keymaps 'bibtex-mode-map
  ;;  "i" '(:ignore t :which-key "Insert")
  ;;  "ir" '(citar-insert-bibtex :which-key "Reference")
  ;;  )


  ;;;; Scheme
  ;;(k8x1d/local-leader-keys
  ;;  :keymaps 'scheme-mode-map
  ;;  "'" '(geiser-repl-switch :which-key "REPL")
  ;;  "b" '(geiser-eval-buffer :which-key "Eval buffer")
  ;;  )

  )


(provide 'keybindings-module)
