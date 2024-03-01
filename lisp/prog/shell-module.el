


;; Notebook support (via org-babel)
  (use-package org
    :config
      (add-to-list 'org-babel-load-languages '(shell . t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
      )

(provide 'shell-module)
