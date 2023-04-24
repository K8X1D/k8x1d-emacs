;;
;; Extensible VI Layer (EVIL) for Emacs
;;

;;;; Install required packages
;;(dolist (package '(evil
;;		   evil-collection
;;		   evil-org))
;;  (unless (package-installed-p package)
;;    (package-install package)))


;; Redo system
(use-package undo-fu
  :defer t)



;; Base evil
(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-fu)
  :hook
  ((after-init . evil-mode)
   (org-capture-mode . evil-insert-state))
;;(setq evil-undo-system 'undo-redo) ;; test native option, create problems...
)

;; Extended evil
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Org support
(use-package evil-org
  :init
  ;; bug fix, https://github.com/Somelauw/evil-org-mode/issues/93
  (fset 'evil-redirect-digit-argument 'ignore) ;; before evil-org loaded
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(provide 'evil-module)
