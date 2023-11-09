;;; package --- Summary

;;; Commentary:


;;; Code:

(use-package emacs
  :config
  (setq byte-compile-warnings nil)
  )

(use-package async
  :hook (after-init . async-bytecomp-package-mode)
  :config
  (setq async-bytecomp-allowed-packages '(all))
  )



(provide 'byte-compile-module)
;;; async-module-module.el ends here
