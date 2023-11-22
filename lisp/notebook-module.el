
;;; package --- Summary

;;; Commentary:

;;; Code:


;; Org-babel
(use-package org
  :config
  (setq org-babel-python-command "python3")
  (add-to-list 'org-src-lang-modes '("python" . python))
  (add-to-list 'org-src-lang-modes '("r" . ess-r))
  (add-to-list 'org-src-lang-modes '("r" . R))
  (add-to-list 'org-src-lang-modes '("r" . r))
  (add-to-list 'org-src-lang-modes '("R" . ess-r))
  (add-to-list 'org-src-lang-modes '("R" . R))
  (add-to-list 'org-src-lang-modes '("R" . r))
  (add-to-list 'org-src-lang-modes '("ess-r" . ess-r))
  (add-to-list 'org-src-lang-modes '("ess-r" . R))
  (add-to-list 'org-src-lang-modes '("ess-r" . r))
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (shell . t)
     (julia . t)
     (scheme . t)
     (R . t)
     (python . t)
     (jupyter . t)))
  )


(use-package jupyter)

(provide 'notebook-module)
;;; notebook-module.el ends here
