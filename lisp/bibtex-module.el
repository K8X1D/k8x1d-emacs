;;; package --- Summary  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Managing Bibliographies
(use-package bibtex
  :config
  (setq bibtex-contline-indentation 0)
  (setq bibtex-text-indentation 10)
  (setq bibtex-field-indentation 10)
  :custom
  (bibtex-dialect 'biblatex)
  (bibtex-user-optional-fields
   '(("keywords" "Keywords to describe the entry" "")
     ("file" "Link to a document file." "" )))
  (bibtex-align-at-equal-sign t))

(provide 'bibtex-module)
;;; bibtex-module.el ends here
