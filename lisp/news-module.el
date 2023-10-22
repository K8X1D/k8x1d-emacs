;;; package --- Summary "-*- lexical-binding: t -*-"

;;; Commentary:

;;; Code:

(use-package elfeed
  
  :custom
  (elfeed-db-directory
   (expand-file-name "elfeed" user-emacs-directory))
  (elfeed-show-entry-switch 'display-buffer)
  :bind
  ("C-c w e" . elfeed )
  :config
  (setq elfeed-feeds
	'(("https://bx1.be/rss/podcast/bruxellesvit/?theme=classic" test)
	  )))

;; ;; Configure Elfeed with org mode
;; (use-package elfeed-org
;;   :after org
;;   :config
;;   (elfeed-org)
;;   :custom
;;   (rmh-elfeed-org-files (list ews-elfeed-config-file)))

;; ;; Easy insertion of weblinks
;; (use-package org-web-tools
;;   :after org
;;   :bind
;;   (("C-c w w" . org-web-tools-insert-link-for-url)))



(provide 'news-module)
;;; news-module.el ends here
