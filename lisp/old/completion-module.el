
;;;;
;;;; Completion
;;;;

;; Enable vertico
(use-package vertico
  :hook
  (after-init . vertico-mode)
  :config
  ;; Show more candidates
  (setq vertico-count 20)
  ;; Grow and shrink the Vertico minibuffer
   (setq vertico-resize t)
  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  ;; Ignore case
  (setq read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-ignore-case t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :hook
  (after-init . savehist-mode))
;;
;;
;;;; A few more useful configurations...
;;(use-package emacs
;;  :init
;;  ;; Add prompt indicator to `completing-read-multiple'.
;;  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
;;  (defun crm-indicator (args)
;;    (cons (format "[CRM%s] %s"
;;                  (replace-regexp-in-string
;;                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
;;                   crm-separator)
;;                  (car args))
;;          (cdr args)))
;;  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
;;
;;  ;; Do not allow the cursor in the minibuffer prompt
;;  (setq minibuffer-prompt-properties
;;        '(read-only t cursor-intangible t face minibuffer-prompt))
;;  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
;;
;;  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;;  ;; Vertico commands are hidden in normal buffers.
;;  ;; (setq read-extended-command-predicate
;;  ;;       #'command-completion-default-include-p)
;;
;;  ;; Enable recursive minibuffers
;;  (setq enable-recursive-minibuffers t))
;;
;;
(use-package orderless
  :config
  ;; Include orderless in completion
  (setq completion-styles '(orderless basic)
	completion-category-overrides '((file (styles basic partial-completion))))
  )


;; Enable Corfu completion UI
(use-package corfu
  :custom
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-auto nil)
  (corfu-on-exact-match nil)
  (corfu-quit-no-match 'separator)
  (corfu-preselect-first nil)
  :hook
  (after-init . global-corfu-mode)
  :bind (:map corfu-map
         ("SPC" . corfu-insert-separator)
         ("TAB" . corfu-next)
         ([tab] . corfu-next)
         ("S-TAB" . corfu-previous)
         ([backtab] . corfu-previous))
  :config
;; Enable indentation+completion using the TAB key.
(setq tab-always-indent 'complete)
(setq completion-cycle-threshold 1)
  )

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package cape
  :defer t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file-capf)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev-capf)
  (add-to-list 'completion-at-point-functions #'cape-keyword-capf))


(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))


;;
;; In test
;;

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(provide 'completion-module)
