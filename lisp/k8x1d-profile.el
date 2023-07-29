;; -*- lexical-binding: t; -*-

(use-package emacs
  :hook (emacs-startup .
		       (lambda ()
			 (message "*** Emacs loaded in %s seconds with %d garbage collections."
				  (emacs-init-time "%.2f")
				  gcs-done))) ;; Profile emacs startup
  :config
  ;; Define time-mesurement require function 
  (require 'benchmark)
  (defun timed-require (feat)
    (if (featurep feat)
	(progn (message "erraneous usage: '%s'" feat) nil)
      (message "'%s' loaded in %.2fs" feat
	       (benchmark-elapse (load-library (symbol-name feat))))))
  )

(provide 'k8x1d-clean)
