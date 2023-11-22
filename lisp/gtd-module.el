;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package org-gtd
  :init
  (setq org-gtd-update-ack "3.0.0")
  (require 'org-gtd)
  :general
  (k8x1d/leader-keys
    "d"  '(:ignore t
		   :package org-gtd
		   :which-key "GTD")
    "dc" '(org-gtd-capture :which-key "Capture")
    "de" '(org-gtd-engage :which-key "Engage")
    "dp"  '(org-gtd-process-inbox :which-key "Process")
    "dn"  '(org-gtd-show-all-next :which-key "Show next")
    "da"  '(org-gtd-archive-completed-items :which-key "Archive completed")
    "dr"  '(org-gtd-review-area-of-focus :which-key "Review Area")
    )
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
