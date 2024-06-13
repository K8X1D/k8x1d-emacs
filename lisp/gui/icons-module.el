

;; Icons
(use-package nerd-icons
  :if (display-graphic-p)
  :config
  (setq nerd-icons-font-family "Iosevka Nerd Font")
  )

;; Icons support for dired
(use-package nerd-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . nerd-icons-dired-mode))

;; Icons support for ibuffer
(use-package nerd-icons-ibuffer
  :if (display-graphic-p)
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))


;; Icons support for corfu
(use-package nerd-icons-corfu
  :if (and (string= k8x1d/completion "corfu") (display-graphic-p))
  :after corfu
  :config
  ;; Optionally:
  (setq nerd-icons-corfu-mapping
	'((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
          (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
          ;; ...
          (t :style "cod" :icon "code" :face font-lock-warning-face)))
  ;; Remember to add an entry for `t', the library uses that as default.
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  )

;; Add icon to mini-buffer
(use-package nerd-icons-completion
  :if (display-graphic-p)
  :after marginalia
  :hook ((after-init . nerd-icons-completion-mode)
	 (marginalia-mode  . nerd-icons-completion-marginalia-setup)))


;; Add icons to magit
(use-package magit-file-icons
  :after magit
  :hook (magit-mode . magit-file-icons-mode)
  :custom
  ;; These are the default values:
  (magit-file-icons-enable-diff-file-section-icons t)
  (magit-file-icons-enable-untracked-icons t)
  (magit-file-icons-enable-diffstat-icons t))




(use-package org
  :config
  (require 'nerd-icons)
  ;; adapted from https://blog.gpkb.org/posts/org-agenda-nerd-icons/
  (defun gk-nerd-agenda-icons (fun prefix alist)
    "Makes an org agenda alist"
    (mapcar (pcase-lambda (`(,category . ,icon))
	      `(,category
		(,(funcall fun (concat prefix icon) :height 1.0))))
	    alist))
  (setq org-agenda-category-icon-alist
	(append
	 (gk-nerd-agenda-icons #'nerd-icons-mdicon "nf-md-"
			       '(("Inbox" . "email")
				 ("Emplois" . "purse")
				 ("Recherches" . "atom")
				 ("Impli" . "leaf")
				 ("Admin" . "broom")
				 ("Revenu" . "cash")
				 ("Développements" . "dev_to")
				 ;; template
				 ("Sprint" . "run_fast")
				 ("Database" . "database")
				 ("ELT" . "pipe")
				 ("Devops" . "gitlab")
				 ("Blog" . "fountain_pen_tip")
				 ("FOSS" . "code_braces")
				 ("Tool" . "tools")
				 ("Todo" . "list_status")))
	 (gk-nerd-agenda-icons #'nerd-icons-sucicon "nf-custom-"
			       '(("Emacs" . "emacs")
				 ("Org" . "orgmode")))
	 '(("" '(space . (:width (11)))))))
  )




(provide 'icons-module)
