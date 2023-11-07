;;; package --- Summary

;;; Commentary:

;;; Code:

;; Syntax highlight
(use-package python
  :config
  (setq python-indent-offset 4)
  (setq python-indent-guess-indent-offset-verbose nil)
  (setq python-shell-interpreter "python3")
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

;; Checker
(use-package flycheck
  :if (equal lsp-framework "lsp-mode")
  :hook (python-mode . flycheck-mode)
  :config
  (setq flycheck-python-pylint-executable "pylint")
  (setq flycheck-python-pycompile-executable "python3")
  )

;; Conda support
(use-package conda
  :after python
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t)
  (add-to-list 'global-mode-string
	       '(conda-env-current-name (" conda:" conda-env-current-name " "))
	       'append)
  )


;; Env support
(use-package pyvenv
  )
(use-package auto-virtualenv
  
  :hook ((python-mode . auto-virtualenv-set-virtualenv)
	 (window-configuration-change . auto-virtualenv-set-virtualenv)
	 (focus-in . auto-virtualenv-set-virtualenv))
  ;; :config
  ;; (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
  ;; ;; Activate on changing buffers
  ;; (add-hook 'window-configuration-change-hook 'auto-virtualenv-set-virtualenv)
  ;; ;; Activate on focus in
  ;; (add-hook 'focus-in-hook 'auto-virtualenv-set-virtualenv)
  )


(provide 'python-module)
;;; python-module.el ends here
