;; Syntax highlight + REPL
(use-package geiser-mode
  :bind (:map scheme-mode-map
	      ("C-c '" . geiser))
  :config
  ;; Clean keybindings
  (require 'bind-key)
  (unbind-key "C-c C-i" geiser-mode-map) 
  )

(use-package geiser-guile)


;; Notebook support (via org-babel)
(use-package org
  :config
  (add-to-list 'org-babel-load-languages '(scheme . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  )


;; Documentation
(use-package eldoc
  :hook (geiser-mode . eldoc-mode))


;; Keybindings
(use-package geiser-mode 
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/local-leader-keys
   :keymaps 'scheme-mode-map
   "'" '(geiser :which-key "REPL")
   "b" '(geiser-eval-buffer :which-key "Eval buffer")
   "r" '(geiser-eval-region :which-key "Eval region")
   )
  )


(provide 'scheme-module)
