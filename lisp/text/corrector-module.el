
(if (string= k8x1d/package-management "straight")
    (straight-use-package
     '(eglot-ltex :type git :host github :repo "emacs-languagetool/eglot-ltex"))
  )
(use-package eglot-ltex
  :hook ((LaTeX-mode message-mode) . (lambda ()
			(require 'eglot-ltex)
			(eglot-ensure)))
  ;; FIXME: org agenda open a lot of file at the same time. Eglot force change focus when server is activated which is really bothering. Also, their is an initial performance cost at processing all thoses files. Find a way to exclude org files in org-agenda list. Removing org-mode from file type is costly in terms of feature desirability
  ;; :hook (text-mode . (lambda ()
			;; (require 'eglot-ltex)
			;; (eglot-ensure)))
  :init
  (setq eglot-ltex-server-path "/home/k8x1d/.config/k8x1d-emacs/.cache/ltex-ls-15.2.0")
  ;; Fix me, don't work, see https://github.com/valentjn/ltex-ls/issues/262
  ;; (setq eglot-ltex-server-path "/home/k8x1d/.config/k8x1d-emacs/.cache/ltex-ls-16.0.0")
  (setq eglot-connect-timeout 180)
  (setq eglot-ltex-communication-channel 'stdio)
  (defun k8x1d/launch-corrector ()
    (interactive)
    (require 'eglot-ltex)
    (eglot-ensure))
  )





(provide 'corrector-module)
