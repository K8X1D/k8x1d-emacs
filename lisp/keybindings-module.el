;; -*- lexical-binding: t -*-

;; Contextual interaction
(use-package embark
  :bind
  ("C-." . embark-act)         ;; pick some comfortable binding
  ("C-;" . embark-dwim)        ;; good alternative: M-.
  ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult integration
(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


;; UI to show keys
(use-package which-key
  :ensure nil
  :diminish which-key-mode
  :hook
  (after-init . which-key-mode)
  :config
  (setq which-key-min-display-lines 10)
  )

;; Keybinding management
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

  ;; Non specific keybindings
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
   "qs" '(k8x1d/server-shutdown :which-key "Emacs server")
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
