;;; package --- Summary

;;; Commentary:

;;; Code:

;; Syntax highlight
(use-package ess
  
  :config
  (setq ess-use-company nil)
  (setq mode-line-process nil)
  (defun my-inferior-ess-init2 ()
    "Workaround for https://github.com/emacs-ess/ESS/issues/1159"
    (setq-local mode-line-process nil))
  (add-hook 'ess-mode-hook #'my-inferior-ess-init2)
  )

;; REPL
(use-package R-vterm
  :vc (:url "https://gitlab.com/K8X1D/r-vterm"
	    :branch "main")
  :init
  (setq R-vterm-repl-program "radian") ;; Use radian instead of R
  (defun k8x1d/open-R-repl-at-bottom ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (R-vterm-repl)
    (evil-insert-state)
    )
  :hook ((ess-r-mode . R-vterm-mode))
  :general
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "or"  '(:ignore t :which-key "REPL")
    "orr"  '(k8x1d/open-R-repl-at-bottom t :which-key "R")
    )
  (k8x1d/local-leader-keys
    :keymaps 'R-vterm-mode-map
    "'" '(k8x1d/open-R-repl-at-bottom :which-key "REPL")
    "b" '(R-vterm-send-buffer :which-key "Send buffer")
    "RET" '(R-vterm-send-region-or-current-line :which-key "Eval buffer")
    "f" '(R-vterm-send-include-buffer-file :which-key "Eval file")
    )
  :config
  (setq vterm-kill-buffer-on-exit nil)
  (require 'bind-key)
  (unbind-key "C-c TAB" R-vterm-mode-map)
  )

;; LSP
(use-package eglot
  :if (equal lsp-framework "eglot")
  :hook (ess-r-mode . eglot-ensure)
  )

(use-package lsp-mode
  :if (equal lsp-framework "lsp-mode")
  :hook (ess-r-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-language-id-configuration '(R-mode . "r"))
  )

(provide 'r-module)
;;; r-module.el ends here
