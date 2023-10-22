;;; package --- Summary
;;; Commentary:

;;; Code:

(use-package org-present
  :config
  (eval-after-load "org-present"
    '(progn
       (add-hook 'org-present-mode-hook
		 (lambda ()
                   (org-present-big)
                   (org-display-inline-images)
		   (org-fold-hide-sublevels)
                   (org-present-show-cursor)
                   ;; (org-present-hide-cursor)
                   ;; (org-present-read-only)
		   ))
       (add-hook 'org-present-mode-quit-hook
		 (lambda ()
                   (org-present-small)
                   (org-remove-inline-images)
                   ;; (org-present-show-cursor)
                   ;; (org-present-read-write)
		   ))))
  )

(provide 'presentation-module)
;;; project-module.el ends here
