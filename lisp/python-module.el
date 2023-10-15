;;; package --- Summary

;;; Commentary:

;;; Code:

;; Syntax highlight
(use-package python
  :config
  (setq python-indent-offset 4)
  (setq python-indent-guess-indent-offset-verbose nil)
  )

;; REPL
(use-package python-vterm
  :vc (:fetcher "gitlab"  :repo "K8X1D/python-vterm")
  :init
  (defun k8x1d/open-python-repl-at-bottom ()
    (interactive)
    (evil-window-split)
    (evil-window-down 1)
    (evil-window-set-height 17)
    (python-vterm-repl)
    (evil-insert-state)
    )
  :hook ((python-mode . python-vterm-mode))
  :bind
  (("C-c o r p" . python-vterm-repl)
   :map python-vterm-mode-map
   ("C-c i" . python-vterm-send-include-buffer-file))
  :config
  (setq vterm-kill-buffer-on-exit nil)
  ;; Use radian instead of R
  (setq python-vterm-repl-program "bpython")
  (require 'bind-key)
  (unbind-key "C-c TAB" python-vterm-mode-map)
  )


;; LSP
(use-package eglot
  :if (equal lsp-framework "eglot")
  :hook (python-mode . eglot-ensure)
  )

(use-package lsp-mode
  :if (equal lsp-framework "lsp-mode")
  :hook (python-mode . lsp-deferred))

(provide 'python-module)
;;; python-module.el ends here
