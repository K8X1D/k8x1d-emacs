;;
;; Startup time
;;

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

;; Define time-mesurement require function 
(require 'benchmark)
(defun timed-require (feat)
  (if (featurep feat)
      (progn (message "erraneous usage: '%s'" feat) nil)
    (message "'%s' loaded in %.2fs" feat
        (benchmark-elapse (load-library (symbol-name feat))))))

;; Add modules to path
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))

;;
;; Module to load
;;

(timed-require 'k8x1d-packages)
(timed-require 'k8x1d-evil)
(timed-require 'k8x1d-completion)
(timed-require 'k8x1d-file-explorer)
(timed-require 'k8x1d-buffers)

;; Gui
(timed-require 'k8x1d-fonts)
(timed-require 'k8x1d-icons)
(timed-require 'k8x1d-dashboard)
(timed-require 'k8x1d-modeline)
(timed-require 'k8x1d-theme)

;; Project management
(timed-require 'k8x1d-project)
(timed-require 'k8x1d-workspaces)
(timed-require 'k8x1d-gtd)
(timed-require 'k8x1d-vc)

;; Writing support
(timed-require 'k8x1d-org)
(timed-require 'k8x1d-biblio)
(timed-require 'k8x1d-corrector)
(timed-require 'k8x1d-notes-taking)

;; Programation support
;;(timed-require 'k8x1d-treesitter)
(timed-require 'k8x1d-julia)
(timed-require 'k8x1d-python)
(timed-require 'k8x1d-R)
(timed-require 'k8x1d-lisp)
(timed-require 'k8x1d-latex)
(timed-require 'k8x1d-docker)

;; Other
(timed-require 'k8x1d-multimedia)
(timed-require 'k8x1d-news)
(timed-require 'k8x1d-password)
(timed-require 'k8x1d-presentation)




;;
;; Frames characteristics
;;

;; Scratch message 
(setq initial-scratch-message
      ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.")



;; Test if pgtk

(defun k8x1d/test-if-pgtk ()
  (interactive)
(if (eq window-system 'pgtk)
    (message "pgtk version in use")
  (message "non-pgtk version in use"))
)

;; Set initial transparency
;;;; FIXME: daemon mode lacks color, seem to use non emacs 29 config
(if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
    (progn
      (set-frame-parameter nil 'alpha-background 80) ; For current frame
      (add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth
      )
  (progn
    (set-frame-parameter (selected-frame) 'alpha '(90 . 90)) ; For current frame
    (add-to-list 'default-frame-alist '(alpha . (90 . 90))) ; For all new frames henceforth
    ))

;;(set-frame-parameter nil 'alpha-background 80) ; For current frame
;;(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth


;; Set transparency of emacs
(defun k8x1d/transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
      (set-frame-parameter (selected-frame) 'alpha-background value)
  (set-frame-parameter (selected-frame) 'alpha value)))



;;
;; Esthetics
;;

;;
;; Emacs characteristics
;;
(add-hook 'after-init-hook (lambda ()
			     (defalias 'yes-or-no-p 'y-or-n-p)
			     (setq vc-follow-symlinks t)
			     ))
;; Update buffer when file change
(add-hook 'after-init-hook 'global-auto-revert-mode)


;; Highlight whole line
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)

;; Better scrolling effects
(add-hook 'after-init-hook #'pixel-scroll-precision-mode)
;; Show line number for programming mode 
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'display-line-numbers-mode-hook (lambda()
					    (setq display-line-numbers 'relative)
					    ))

;; Show which key
(add-hook 'after-init-hook #'which-key-mode)

;; Per buffer exposition
(use-package solaire-mode
  :hook (after-init . solaire-global-mode))


;; Highlights "TODOs"  
(add-hook 'after-init-hook #'global-hl-todo-mode)


;;
;; Native compilation
;;
(setq warning-minimum-level :error)


;;
;; Teach emacs to be clean!
;; From: https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-Tips-Cleaning.org 
;;



;; Backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-cache-directory))))

;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-cache-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-cache-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-cache-directory) t)))


;; Custom file location
(setq custom-file (concat user-emacs-cache-directory "/custom.el"))


;;
;; Utilities
;;

;; Defaults browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; Pdf support
(pdf-loader-install)
(add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode) ;; dark mode by default



;; Guix packages management
(global-set-key (kbd "C-c o g") 'guix)


;; Pomodoro
(setq org-pomodoro-length 50)
(setq org-pomodoro-short-break-length 10)
(setq org-pomodoro-long-break-length 30)













;;;;;;
;;;;;; File explorer
;;;;;; 
;;
;;
;;
;;
;;;;(use-package treemacs
;;;;  :config
;;;;  (treemacs-follow-mode 1)
;;;;  (treemacs-filewatch-mode 1)
;;;;  (treemacs-project-follow-mode 1)
;;;;  :bind
;;;;  ("C-x p o e"   . treemacs)
;;;;  )
;;;;
;;;;(use-package treemacs-evil
;;;;  :after (treemacs evil)
;;;;  )
;;;;
;;;;(use-package treemacs-magit
;;;;  :after (treemacs magit)
;;;;  )
;;
;;;;
;;;; Geiser support
;;;;
;;
;;

;;
;; Keybinding
;;

;; ESC Cancels All
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;;;
;;;; Create leader keybinding
;;;;
;;					
;;(use-package general
;;  :config
;;  (general-evil-setup t)
;;
;;  (general-create-definer k8x1d/leader-key-def
;;    :keymaps '(normal insert visual emacs)
;;    :prefix "SPC"
;;    :global-prefix "C-SPC"))
;;
;;
;;(k8x1d/leader-key-def
;;  "f"  '(:ignore t :which-key "Find")
;;  "ff" '(find-file :which-key "File")
;;  "fs" '(save-some-buffers :which-key "Save")
;;  "o"  '(:ignore t :which-key "Open")
;;  "oa" '(org-agenda :which-key "Agenda")
;;  "ot" '(multi-vterm-project :which-key "Terminal")
;;  "os" '(dired-sidebar-toggle-sidebar :which-key "Sidebar")
;;  "w" '(:ignore t :which-key "Window")
;;  "wc" '(evil-window-delete :which-key "Delete")
;;  "ws" '(evil-window-split :which-key "Split")
;;  "wv" '(evil-window-vsplit :which-key "Vsplit")
;;  "wh" '(evil-window-left :which-key "Left")
;;  "wj" '(evil-window-down :which-key "Down")
;;  "wk" '(evil-window-up :which-key "Up")
;;  "wl" '(evil-window-right :which-key "Right")
;;  "wH" '(evil-window-move-far-left :which-key "Move Left")
;;  "wJ" '(evil-window-move-very-bottom :which-key "Move Down")
;;  "wK" '(evil-window-move-very-top :which-key "Move Up")
;;  "wL" '(evil-window-move-far-right :which-key "Move Right")
;; ;; ;; TODO: add workspaces keys
;;  "<tab>" '(:ignore t :which-key "Tabspaces")
;;  "<tab> C" '(tabspaces-clear-buffers :which-key "clear-buffers")
;;  "<tab> b" '(tabspaces-switch-to-buffer :which-key "switch-to-buffer")
;;  "<tab> d" '(tabspaces-close-workspace :which-key "close-workspace")
;;  "<tab> k" '(tabspaces-kill-buffers-close-workspace :which-key "kill-buffers-close-workspace")
;;  "<tab> o" '(tabspaces-open-or-create-project-and-workspace :which-key "open-or-create-project-and-workspace")
;;  "<tab> r" '(tabspaces-remove-current-buffer :which-key "remove-current-buffer")
;;  "<tab> R" '(tabspaces-remove-selected-buffer :which-key "remove-selected-buffer")
;;  "<tab> s" '(tabspaces-switch-or-create-workspace :which-key "switch-or-create-workspace")
;;  "<tab> t" '(tabspaces-switch-buffer-and-tab :which-key "switch-buffer-and-tab")
;;
;;  ;; TODO: add project keys
;;  ;; TODO: add bookmark keys
;;
;;  "RET" '(bookmark-jump :which-key "Bookmarks")
;;  ;;
;;  "q" '(:ignore t :which-key "Quit")
;;  "qq" '(save-buffers-kill-terminal :which-key "Emacs")
;;  )


