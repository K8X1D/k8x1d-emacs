;;; package --- Summary "-*- lexical-binding: t -*-"


;;; Commentary:

;;; Code:

;; Evil
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-echo-state nil)
  :hook (after-init . evil-mode)
  )

;; Extended evil support
(use-package evil-collection
  :hook (evil-mode . evil-collection-init)
  :bind ([remap magit-jump-to-tracked] . evil-tab-next)
  :config
  (add-to-list 'evil-insert-state-modes 'eat-mode)
  (add-to-list 'evil-insert-state-modes 'vterm-mode)
  (add-to-list 'evil-insert-state-modes 'with-editor-mode)
  (add-to-list 'evil-insert-state-modes 'org-capture-mode)

  ;; TODO: find magit commit buffer mode
  ;; (add-to-list 'evil-insert-state-modes 'magit-mode)
  )

(use-package evil-goggles
  :hook (evil-mode . evil-goggles-mode)
  :config
  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

;; Multiple cursur
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


;; Evil motion and text objects
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

(use-package evil-easymotion
  ;; :config
  ;; (evilem-default-keybindings "SPC e")
  )


(provide 'evil-module)
;;; evil-module.el ends here
