;; -*- lexical-binding: t; -*-

(use-package emacs
  :hook (emacs-startup .
		       (lambda ()
			 (message "*** Emacs loaded in %s seconds with %d garbage collections."
				  (emacs-init-time "%.2f")
				  gcs-done))) ;; Profile emacs startup
  )

(provide 'k8x1d-clean)
