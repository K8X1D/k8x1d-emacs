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
  (custom-set-faces
   `(langtool-errline ((nil (:foreground "#ff5f59"))))
  ))

;;(use-package eglot-ltex
;;  :straight (:type git :host github :repo "emacs-languagetool/eglot-ltex") 
;;  :ensure t
;;  :hook (text-mode . (lambda ()
;;                       (require 'eglot-ltex)
;;                       (eglot-ensure)))
;;  :init
;;  (setq eglot-languagetool-server-path (concat user-emacs-directory "/ltex-ls-16.0.0/")))

;;
;; Spell checking
;;
(use-package flyspell
  :hook (text-mode . flyspell-mode)
  :config
  ;; Aspell compatibility
  ;; see https://www.emacswiki.org/emacs/FlySpell#h5o-8
  (setq ispell-program-name "aspell"
	ispell-extra-args '("--sug-mode=ultra"
			    "--run-together"))
  )

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map
	      ("C-c $" . flyspell-correct-at-point))
  :config
  ;; Speedup flyspell
  (setq flyspell-issue-welcome-flag nil
	flyspell-issue-message-flag nil)
  ;; leave duplication evaluation to langtool
  (setq flyspell-mark-duplications-flag nil))

(use-package auto-dictionary-mode
  :hook (flyspell-mode . auto-dictionary-mode))

;;
;; Good writing
;;

(use-package writegood-mode
  :bind
  (("C-c e g" . writegood-grade-level)
   ("C-c e r" . writegood-reading-ease))
  :hook (text-mode . writegood-mode))

(provide 'k8x1d-corrector)
