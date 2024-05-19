(use-package eglot-ltex
  :hook (text-mode . (lambda ()
                       (require 'eglot-ltex)
                       (eglot-ensure)))
  :init
  (setq eglot-ltex-server-path "/home/k8x1d/.config/k8x1d-emacs/.cache/ltex-ls-15.2.0")
  (setq eglot-connect-timeout 180)
  (setq eglot-ltex-communication-channel 'stdio)
  )



(provide 'corrector-module)