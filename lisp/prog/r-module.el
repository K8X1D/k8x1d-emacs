;; Syntax highlight + REPL
(use-package ess
    :init
    (defun k8x1d/ess-switch-to-inferior-or-script-buffer ()
      (interactive)
      (require 'ess)
      (ess-switch-to-inferior-or-script-buffer)
      )
    :config
    (setq ess-use-company nil)
    (setq mode-line-process nil)
    (setq ess-offset-continued 'straight)
    (setq ess-nuke-trailing-whitespace-p t)
    (setq ess-style 'DEFAULT)
    (setq ess-history-file nil)
    (setq ess-use-eldoc t)
    :hook (ess-r-mode . (lambda () (read-only-mode -1)))
    )

;; LSP
  (use-package ess
    :hook (ess-r-mode . eglot-ensure)
    )

;; Data viewer
  (use-package ess-view-data
    :hook (ess-r-mode . ess-view-data-mode)
    :bind
    (:map ess-r-mode-map
          ("C-c C-v" . ess-view-data-print))
    )

;; Notebook support (via org-babel)
  (use-package org
    :config
      (add-to-list 'org-babel-load-languages '(R . t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
      )


;; Curtom export to R markdown
  (use-package ox-gfm
    :config
    (defun org-gfm-export-to-Rmarkdown (&optional async subtreep visible-only)
      "Export current buffer to a Github Flavored Markdown file.

      If narrowing is active in the current buffer, only export its
      narrowed part.

      If a region is active, export that region.

      A non-nil optional argument ASYNC means the process should happen
      asynchronously.  The resulting file should be accessible through
      the `org-export-stack' interface.

      When optional argument SUBTREEP is non-nil, export the sub-tree
      at point, extracting information from the headline properties
      first.

      When optional argument VISIBLE-ONLY is non-nil, don't export
      contents of hidden elements.

      Return output file's name."
      (interactive)
      (let ((outfile (org-export-output-file-name ".Rmd" subtreep)))
        (org-export-to-file 'gfm outfile async subtreep visible-only)))

    )

;; Checker
  (use-package ess 
    :config
    (setq ess-use-flymake t)
    ;;(setq ess-r-flymake-linters '("line_length_linter = NULL" "indentation_linter(indent = 4L)"))
    (setq ess-r-flymake-linters '("line_length_linter = line_length_linter(120)"))
    )

(provide 'r-module)
