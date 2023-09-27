;;; package --- Summary

;;; Commentary:

;;; Code:

(use-package eglot-ltex
 :vc (:fetcher "github"  :repo "emacs-languagetool/eglot-ltex")
  :hook (text-mode . (lambda ()
                       (require 'eglot-ltex)
                       (eglot-ensure)))
  :init
 ;; (setq eglot-languagetool-server-path "/home/k8x1d/.nix-profile/") ;; don't work properly, slow to start if it start
 (setq eglot-languagetool-server-path "/home/k8x1d/.cache/emacs/ltex-ls-15.2.0/")
  )




(provide 'corrector-module)
;;; corrector-module.el ends here
