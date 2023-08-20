;; Inspirations:
;; - https://www.adventuresinwhy.com/post/eglot/

;; Open python files in tree-sitter mode.
;;(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

(use-package python-mode
  ;; :general
  ;; (k8x1d/local-leader-keys
  ;;  :keymaps 'python-mode-map
  ;;  "'" '(run-python :which-key "Open REPL")
  ;;  "l" '(python-shell-send-statement :which-key "Send line")
  ;;  "b" '(python-shell-send-buffer :which-key "Send buffer")
  ;;  "f" '(python-shell-send-file :which-key "Send file")
  ;;  "r" '(python-shell-send-region :which-key "Send region")
  ;;  )
  ;; (k8x1d/local-leader-keys
  ;;  :keymaps 'python-ts-mode-map
  ;;  "'" '(run-python :which-key "Open REPL")
  ;;  "l" '(python-shell-send-statement :which-key "Send line")
  ;;  "b" '(python-shell-send-buffer :which-key "Send buffer")
  ;;  "f" '(python-shell-send-file :which-key "Send file")
  ;;  "r" '(python-shell-send-region :which-key "Send region")
  ;;  )
  ;;:bind (:map python-mode-map
  ;;	      ("C-c C-z" . run-python))
  ;;:hook (python-mode . eglot-ensure)
  :config
  (setq python-indent-offset 4)
  )

(use-package python-ts-mode
  :config
  (setq python-indent-offset 4))

(use-package python-vterm
  :load-path "~/.k8x1d-emacs.d/lisp/python-vterm.el"
  :init
  (defun k8x1d/open-python-repl-at-bottom ()
    (interactive)
    (require 'python-vterm)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (python-vterm-repl)
    (evil-insert-state)
    )
  :general
  (k8x1d/local-leader-keys
    :keymaps 'python-mode-map
    ;;"'" '(julia-vterm-switch-to-repl-buffer :which-key "Open REPL")
    "'" '(k8x1d/open-python-repl-at-bottom :which-key "Open REPL")
    "l" '(python-vterm-send-region-or-current-line :which-key "Send line")
    "b" '(python-vterm-send-buffer :which-key "Send buffer")
    "f" '(python-vterm-send-include-buffer-file :which-key "Send file")
    "r" '(python-vterm-send-region-or-current-line :which-key "Send region")
    )
  (k8x1d/local-leader-keys
    :keymaps 'python-ts-mode-map
    ;;"'" '(julia-vterm-switch-to-repl-buffer :which-key "Open REPL")
    "'" '(k8x1d/open-python-repl-at-bottom :which-key "Open REPL")
    "l" '(python-vterm-send-region-or-current-line :which-key "Send line")
    "b" '(python-vterm-send-buffer :which-key "Send buffer")
    "f" '(python-vterm-send-include-buffer-file :which-key "Send file")
    "r" '(python-vterm-send-region-or-current-line :which-key "Send region")
    )
  :hook ((python-mode . python-vterm-mode)
	 (python-ts-mode . python-vterm-mode))
  )


(provide 'k8x1d-python)
