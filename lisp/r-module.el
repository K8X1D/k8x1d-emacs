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
  :vc (:fetcher "gitlab"  :repo "K8X1D/r-vterm")
  :init
  (defun k8x1d/open-R-repl-at-bottom ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (R-vterm-repl)
    (evil-insert-state)
    )
  :hook ((ess-r-mode . R-vterm-mode))
  :bind
  (("C-c o r r" . R-vterm-repl)
   :map R-vterm-mode-map
   ("C-c i" . R-vterm-send-include-buffer-file))
  :config
  (setq vterm-kill-buffer-on-exit nil)
  ;; Use radian instead of R
  (setq R-vterm-repl-program "radian")
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
  :hook (ess-r-mode . lsp-deferred))

(provide 'r-module)
;;; r-module.el ends here
