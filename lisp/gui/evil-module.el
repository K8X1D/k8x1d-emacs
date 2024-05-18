;; Vim layer emulation
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-echo-state nil)
  :hook (after-init . evil-mode)
  )
;; Evil extended support
(use-package evil-collection
;; correct for latex indent error from missing reftex autoload
  :hook (evil-mode . evil-collection-init))

;; Customizable key sequence to escape from insert state and everything else in Emacs.
(use-package evil-escape
  :bind ("<esc>" . evil-escape)
  :hook (evil-mode . evil-escape-mode))

;; Display visual hint on evil edit operations 
(use-package evil-goggles
  :hook (evil-mode . evil-goggles-mode)
  :config
  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

;; Motions and text objects for delimited arguments in Evil. 
(use-package evil-args
  :config
  ;; bind evil-args text objects
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

  ;; bind evil-forward/backward-args
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg)

  ;; bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args)
  )

;; A port of vim easymotion to Emacs' evil-mode 
(use-package evil-easymotion)

;; Surround operation
(use-package evil-surround
  :hook (after-init . global-evil-surround-mode))

;; Multi-cursor support
(use-package evil-mc
  :hook (evil-mode . global-evil-mc-mode)
  :config
  ;; Sample set-up
  (evil-define-local-var evil-mc-custom-paused nil
    "Paused functionality when there are multiple cursors active.")

  (defun evil-mc-pause-smartchr-for-mode (mode)
    "Temporarily disables the smartchr keys for MODE."
    (let ((m-mode (if (atom mode) mode (car mode)))
          (s-mode (if (atom mode) mode (cdr mode))))
      (let ((init (intern (concat "smartchr/init-" (symbol-name s-mode))))
            (undo (intern (concat "smartchr/undo-" (symbol-name s-mode)))))
        (when (eq major-mode m-mode)
          (funcall undo)
          (push `(lambda () (,init)) evil-mc-custom-paused)))))

  (defun evil-mc-before-cursors-setup-hook ()
    "Hook to run before any cursor is created.
  Can be used to temporarily disable any functionality that doesn't
  play well with `evil-mc'."
    (mapc 'evil-mc-pause-smartchr-for-mode
          '(web-mode js2-mode java-mode (enh-ruby-mode . ruby-mode) css-mode))
    (when (boundp 'whitespace-cleanup-disabled)
      (setq whitespace-cleanup-disabled t)
      (push (lambda () (setq whitespace-cleanup-disabled nil)) evil-mc-custom-paused)))

  (defun evil-mc-after-cursors-teardown-hook ()
    "Hook to run after all cursors are deleted."
    (dolist (fn evil-mc-custom-paused) (funcall fn))
    (setq evil-mc-custom-paused nil))

  (add-hook 'evil-mc-before-cursors-created 'evil-mc-before-cursors-setup-hook)
  (add-hook 'evil-mc-after-cursors-deleted 'evil-mc-after-cursors-teardown-hook)

  (defvar evil-mc-mode-line-prefix "ⓜ"
    "Override of the default mode line string for `evil-mc-mode'.")
  )

;; Preview effect of evil-ex
(use-package evil-traces
  :hook (evil-mode . evil-traces-mode)
  :config
  (evil-traces-use-diff-faces) ; if you want to use diff's faces
  )

;; Nerd Commenter emulation 
(use-package evil-nerd-commenter
  :bind ([remap comment-line] . evilnc-comment-or-uncomment-lines)
  )

;; Evil integration for anzu
(use-package evil-anzu
  :after (anzu evil)
  :bind
  ;; FIXME: don't work...
  (:map query-replace-map
	([remap query-replace] . anzu-query-replace)
	([remap query-replace-regexp] . anzu-query-replace-regexp))
  (:map isearch-mode-map
	([remap isearch-query-replace] . anzu-isearch-query-replace)
	([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  )

;; Org support
(use-package evil-org
  :after org
  :bind ([remap org-agenda-show-tags] . evil-tab-next)
  :hook ((org-mode . evil-org-mode)
         (org-agenda-mode . evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
  (evil-org-agenda-set-keys)
  )


;; General Keybindings
(use-package evil
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "w" '(:keymap evil-window-map
		  :package evil
		  :which-key "Window")
   )
  )

(provide 'evil-module)
