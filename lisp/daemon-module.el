;; Correct color for daemon-mode
(add-hook 'after-make-frame-functions 
	  (lambda (frame) 
	    (with-selected-frame frame
	      (k8x1d/set-org-modern-colors)
	      (k8x1d/set-tab-bar-colors)
	      (k8x1d/set-window-divider-colors)
	      )))

;; Daemon set-up
(if (daemonp)
    (setq use-package-always-demand t)
  (setq use-package-always-defer t))

(provide 'daemon-module)
