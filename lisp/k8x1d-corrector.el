;;
;; Languagetool
;;

(use-package langtool
  :bind 
  (("C-c h w" . 'langtool-check)
   ("C-c h W" . 'langtool-check-done)
   ("C-c h l" . 'langtool-switch-default-language)
   ("C-c h 4" . 'langtool-show-message-at-point)
   ("C-c h c" . 'langtool-interactive-correction))
  :config
  (setq langtool-http-server-host "localhost"
	langtool-http-server-port 8081)
  )

;;(use-package eglot-ltex
;;  :straight (:type git :host github :repo "emacs-languagetool/eglot-ltex") 
;;  :ensure t
;;  :hook (text-mode . (lambda ()
;;                       (require 'eglot-ltex)
;;                       (eglot-ensure)))
;;  :init
;;  (setq eglot-languagetool-server-path (concat user-emacs-directory "/ltex-ls-16.0.0/")))




(provide 'k8x1d-corrector)
