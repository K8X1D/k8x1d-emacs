;; No matter which completion mode is used:
(customize-set-variable 'tab-always-indent 'complete)

;; Minibuffer configuration
(use-package minibuffer
  :ensure nil
  :config
  (setq completion-cycle-threshold 3)
  (setq completion-category-overrides
        '((file (styles . (partial-completion)))))
  (setq completions-detailed t)
  )

;; Vertical completion in minibuffer
(use-package vertico
  :hook
  (after-init . vertico-mode)
  :config
  (setq vertico-cycle t) ;; Cycle back to top/bottom result when the edge is reached
  (setq vertico-count 10)
  :bind
  (:map vertico-map
	("C-j" . vertico-next)
	("C-k" . vertico-previous)
	("M-h" . vertico-directory-up))
  )

;; Description in minibuffer
(use-package marginalia
  :hook (after-init . marginalia-mode)
  :config
  (setq marginalia-annotators '(marginalia-annotators-heavy
				marginalia-annotators-light
				nil))
  )

;; Save minibuffer history
(use-package savehist
  :hook (after-init . savehist-mode))

;; Order completion suggestion
(use-package orderless
  :init
  ;; (setq completion-styles '(basic partial-completion emacs22))
  (add-to-list 'completion-styles 'orderless)
  )

;; Completion suggestions in box 
(use-package company
  :disabled
  :diminish
  :hook
  (after-init . global-company-mode)
  :config
  (define-key company-mode-map (kbd "<tab>") 'company-complete)
  (define-key company-active-map
	      (kbd "TAB")
	      #'company-complete-common-or-cycle)
  (define-key company-active-map
	      (kbd "<backtab>")
	      (lambda ()
		(interactive)
		(company-complete-common-or-cycle -1)))
  )

;;; Completion suggestions through minibuffer
(use-package consult)
(use-package vertico
  :if (not (string= k8x1d/lsp "lsp-bridge"))
  :config
  ;; Completion suggestion in minibuffer
  (require 'consult)
  (setq completion-in-region-function
	(lambda (&rest args)
	  (apply (if vertico-mode
		     #'consult-completion-in-region
		   #'completion--in-region)
		 args)))
  )


(provide 'completion-module)
