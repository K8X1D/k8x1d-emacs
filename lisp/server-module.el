;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package server
  :hook (after-init . (lambda ()
			(require 'server)))
  :config
  (unless (server-running-p)
    (server-start)))

(provide 'server-module)
;;; server-module.el ends here
