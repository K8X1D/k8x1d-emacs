;; Syntax highlight + REPL
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


(provide 'scheme-module)
