;; (use-package evil
;;   :init
;;   (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;;   (setq evil-want-keybinding nil)
;;   (setq evil-want-C-u-scroll t)
;;   :config
;;   (evil-mode 1))

;; (use-package evil-collection
;;   :diminish evil-collection-unimpaired-mode
;;   :after evil
;;   :config
;;   (evil-collection-init))


;; from https://github.com/jamescherti/minimal-emacs.d/tree/main?tab=readme-ov-file#how-to-configure-vim-keybindings-using-evil


;; evil-want-keybinding must be declared before Evil and Evil Collection
(setq evil-want-keybinding nil)

(use-package evil
  :general
  (k8x1d/leader-keys
   "w" '(:keymap evil-window-map
		  :package evil
		  :which-key "Window")
   )
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :custom
  (evil-want-Y-yank-to-eol t)
  :hook
  (after-init . evil-mode)
  (git-commit-mode . evil-insert-state)
  :config
  (evil-select-search-module 'evil-search-module 'evil-search)
  (setq evil-mode-line-format nil) ;; managed manually
  )

(use-package evil-collection
  :hook
  (evil-mode . evil-collection-init) 
  (evil-collection-unimpaired-mode . (lambda ()
				  (diminish 'evil-collection-unimpaired-mode) ;; :diminish keyword don't work...

				  ))
  )

(use-package undo-fu
  :commands (undo-fu-only-undo
             undo-fu-only-redo
             undo-fu-only-redo-all
             undo-fu-disable-checkpoint)
  :custom
  ;; 3 times the default values
  (undo-limit (* 3 160000))
  (undo-strong-limit (* 3 240000)))

(use-package undo-fu-session
  :config
  (undo-fu-session-global-mode))

;; give the built-in Emacs tab-bar a style similar to Vim's tabbed browsing interface:
;; (use-package vim-tab-bar
;;   :commands vim-tab-bar-mode
;;   :hook (after-init . vim-tab-bar-mode))

;; You can also add vdiff, a package that provides Vimdiff-like functionality to Emacs:
(use-package vdiff
  :commands (vdiff-buffers
             vdiff-buffers3
             vdiff-quit
             vdiff-files
             vdiff-files3)
  :custom
  (vdiff-auto-refine t)
  (vdiff-only-highlight-refinements t))

;; The evil-visualstar package allows using * or # search from the visual selection:
(use-package evil-visualstar
  :after evil
  :commands global-evil-visualstar-mode
  :hook (after-init . global-evil-visualstar-mode))

;; The evil-surround package simplifies handling surrounding characters, such as parentheses, brackets, quotes, etc. It provides key bindings to easily add, change, or delete these surrounding characters in pairs. For instance, you can surround the currently selected text with double quotes in visual state using S" or gS":
(use-package evil-surround
  :after evil
  :commands global-evil-surround-mode
  :custom
  (evil-surround-pairs-alist
   '((?\( . ("(" . ")"))
     (?\[ . ("[" . "]"))
     (?\{ . ("{" . "}"))

     (?\) . ("(" . ")"))
     (?\] . ("[" . "]"))
     (?\} . ("{" . "}"))

     (?< . ("<" . ">"))
     (?> . ("<" . ">"))))
  :hook (after-init . global-evil-surround-mode))



;; You can also add the following code to enable commenting and uncommenting by pressing gcc in normal mode and gc in visual mode (thanks you to the Reddit user u/mistakenuser for this contribution, which replaces the evil-commentary package):
(with-eval-after-load "evil"
  (evil-define-operator my-evil-comment-or-uncomment (beg end)
    "Toggle comment for the region between BEG and END."
    (interactive "<r>")
    (comment-or-uncomment-region beg end))
  (evil-define-key 'normal 'global (kbd "gc") 'my-evil-comment-or-uncomment))


 ;; Org integration
(use-package evil-org
  :diminish
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
  (evil-org-agenda-set-keys)
  (require 'org-agenda)
  (keymap-set org-agenda-mode-map "<remap> <org-agenda-show-tags>" #'tab-bar-switch-to-next-tab)
  )

;; Multi-cursor support
(use-package evil-mc
  :diminish
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

;; One key to escape them all ;; in test
(use-package evil-escape
  :diminish
  :bind
  ([remap evil-force-normal-state] . evil-escape)
  :hook
  (after-init . evil-escape-mode)
  )


(provide 'evil-module)
