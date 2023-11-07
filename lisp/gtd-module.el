;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package org-gtd
  :init
  (setq org-gtd-update-ack "3.0.0")
  (require 'org-gtd)
  :after org
  :custom
  (org-gtd-directory "~/org/gtd")
  (org-edna-use-inheritance t)
  (org-gtd-organize-hooks '(org-gtd-set-area-of-focus org-set-tags-command))
  (org-gtd-areas-of-focus '("Administratif" "Implications" "Recherches" "Developpements" "Entretien" "Emplois" "Social"))
  :config
  (org-edna-mode)
  :bind
  (:map org-gtd-clarify-map
	("C-c c" . org-gtd-organize)))

(provide 'gtd-module)
;;; gtd-module.el ends here
