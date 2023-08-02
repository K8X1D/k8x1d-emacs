;; Inspirations:
;; - https://www.adventuresinwhy.com/post/eglot/

;; Open python files in tree-sitter mode.
;;(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

(use-package python-mode
  :general
  (k8x1d/local-leader-keys
   :keymaps 'python-mode-map
   "'" '(run-python :which-key "Open REPL")
   "l" '(python-shell-send-statement :which-key "Send line")
   "b" '(python-shell-send-buffer :which-key "Send buffer")
   "f" '(python-shell-send-file :which-key "Send file")
   "r" '(python-shell-send-region :which-key "Send region")
   )
  (k8x1d/local-leader-keys
   :keymaps 'python-ts-mode-map
   "'" '(run-python :which-key "Open REPL")
   "l" '(python-shell-send-statement :which-key "Send line")
   "b" '(python-shell-send-buffer :which-key "Send buffer")
   "f" '(python-shell-send-file :which-key "Send file")
   "r" '(python-shell-send-region :which-key "Send region")
   )
  ;;:bind (:map python-mode-map
  ;;	      ("C-c C-z" . run-python))
  ;;:hook (python-mode . eglot-ensure)
  )


(provide 'k8x1d-python)
