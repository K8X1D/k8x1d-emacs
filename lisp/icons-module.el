;;; package --- Summary

;;; Commentary:

;;; Code:


;; Icons
(use-package nerd-icons-completion
  :after marginalia
  :hook (vertico-mode . nerd-icons-completion-mode) 
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; (use-package kind-icon
;;   :defer nil
;;   :after corfu
;;   :custom
;;   (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
;;   ;; correction for wrong icon size, see https://github.com/jdtsmith/kind-icon/issues/22
;;   (setq kind-icon-default-style 
;; 	'(:padding -1 :stroke 0 :margin 0 :radius 0 :height 0.8 :scale 1))
;;   )

(use-package nerd-icons-corfu 
  :defer nil
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  ;; Optionally:
  (setq nerd-icons-corfu-mapping
	'((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
	  (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
	  ;; ...
	  (t :style "cod" :icon "code" :face font-lock-warning-face)))
  ;; Remember to add an entry for `t', the library uses that as default.
  )




(provide 'icons-module)
;;; icons-module.el ends here
