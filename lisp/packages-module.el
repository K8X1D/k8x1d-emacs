(use-package emacs
  :if (not (string=  k8x1d/package "straight"))
  :init
  (require 'use-package-ensure)
  (setq use-package-always-ensure nil)
  )

(provide 'packages-module)
