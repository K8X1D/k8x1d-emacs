;;
;; Languagetool
;;

;; Replaced by ltex
;; (use-package langtool
;;   :bind
;;   (("C-c h w" . 'langtool-check)
;;    ("C-c h W" . 'langtool-check-done)
;;    ("C-c h l" . 'langtool-switch-default-language)
;;    ("C-c h 4" . 'langtool-show-message-at-point)
;;    ("C-c h c" . 'langtool-interactive-correction))
;;   :config
;;   (setq langtool-http-server-host "localhost"
;; 	langtool-http-server-port 8081)
;;   (custom-set-faces
;;    `(langtool-errline ((nil (:foreground "#ff5f59"))))
;;   ))

;;
;; Spell checking
;;
;; Doesn't work well with ltex (e.g. two language definition procedure, two different way of interacting, etc), try without it.
;; (use-package flyspell
;;   :hook ((org-mode . flyspell-mode)
;; 	 (markdown-mode . flyspell-mode))
;;   :config
;;   ;; Aspell compatibility
;;   ;; see https://www.emacswiki.org/emacs/FlySpell#h5o-8
;;   (setq ispell-program-name "aspell"
;; 	ispell-extra-args '("--sug-mode=ultra"
;; 			    "--run-together"))
;;   )

;; (use-package flyspell-correct
;;   :after flyspell
;;   :bind (:map flyspell-mode-map
;; 	      ("C-c $" . flyspell-correct-at-point))
;;   :config
;;   ;; Speedup flyspell
;;   (setq flyspell-issue-welcome-flag nil
;; 	flyspell-issue-message-flag nil)
;;   ;; leave duplication evaluation to langtool
;;   (setq flyspell-mark-duplications-flag nil))

;; (use-package auto-dictionary-mode
;;   :hook (flyspell-mode . auto-dictionary-mode))

;;
;; Good writing
;;

(use-package writegood-mode
  :bind
  (("C-c e g" . writegood-grade-level)
   ("C-c e r" . writegood-reading-ease))
  :hook (text-mode . writegood-mode))

(use-package format-all
  :hook ((prog-mode . format-all-ensure-formatter)
	 (prog-mode . format-all-mode)))

(provide 'k8x1d-corrector)
