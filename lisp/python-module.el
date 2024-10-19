;; Syntax highlight
(use-package python-mode
  :ensure nil)

;; REPL
(use-package python-vterm
  :vc (:url "https://github.com/shg/python-vterm.el"
            :branch "main")
  :diminish
  :hook
  (python-mode . python-vterm-mode)
  :config
  (setq-default python-vterm-repl-program "ipython")
  )

;; LSP
(use-package lsp-mode
  :hook (python-mode . lsp-deferred))

;; Diagnostic
(use-package flycheck
  :hook
  (python-mode . flycheck-mode))

;; ;; Notebook
(use-package ob-python-vterm
  :vc (:url "https://github.com/shg/ob-python-vterm.el" :branch "main"))

(use-package org
  :config
  (require 'ob-python-vterm)
  (add-to-list 'org-babel-load-languages '(python-vterm . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (defalias 'org-babel-execute:python 'org-babel-execute:python-vterm)
  (defalias 'org-babel-variable-assignments:python 'org-babel-variable-assignments:python-vterm)
  )


(provide 'python-module)
