;;
;; Startup time
;;

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;
;; Frames characteristics
;;

(set-frame-parameter nil 'alpha-background 80) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha-background value))

;;
;; Esthetics
;;

;; Fonts
(set-face-attribute 'default nil :font "Fira Code" :height 150)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
		    ;;:font "JetBrains Mono"
		    :font "Fira Code"
		    :weight 'light
		    :height 150)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
		    ;; :font "Cantarell"
		    :font "Iosevka Aile"
		    :height 150
		    :weight 'light)


(add-hook 'after-init-hook (lambda ()
			     (defalias 'yes-or-no-p 'y-or-n-p)))


;; Tab configuration
;;(setq tab-bar-show nil)
(setq tab-bar-new-tab-choice "*scratch*")


;; Highlight whole line
(add-hook 'after-init-hook #'hl-line-mode)
;; Better scrolling effects
(add-hook 'after-init-hook #'pixel-scroll-precision-mode)
;; Show line number for programming mode 
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; Show which key
(add-hook 'after-init-hook #'which-key-mode)
;; Per buffer exposition
(add-hook 'after-init-hook #'solaire-global-mode)
;; add icons to ibuffer 
(add-hook 'ibuffer-mode-hook #'all-the-icons-ibuffer-mode)
;; add icons to dired
(add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
;; Highlights "TODOs"  
(add-hook 'after-init-hook #'global-hl-todo-mode)

;; Modeline
;; Don't work..
;;(setq mood-line-glyph-alist mood-line-glyphs-fira-code)
;;(setq mood-line-glyph-alist mood-line-glyphs-unicode)
(add-hook 'after-init-hook #'mood-line-mode)


;;
;; Native compilation
;;
(setq warning-minimum-level :error)


;;
;; Evil keybindings
;;
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(add-hook 'after-init-hook (lambda ()
				  (evil-mode 1)
				  (evil-collection-init)))

;;
;; Teach emacs to be clean!
;; From: https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-Tips-Cleaning.org 
;;

;; Backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(setq user-emacs-directory (expand-file-name "~/.cache/emacs"))

;;
;; Completion
;;
(setq completion-styles '(substring orderless basic)) ;; allow partial completion
(setq tab-always-indent 'complete) ;; tab to start completion

;; Show completion box under cursor
(add-hook 'after-init-hook #'global-corfu-mode)
;; Vertical display of buffer choice
(add-hook 'after-init-hook #'vertico-mode)


;;
;; Utilities
;;

;; Better buffer manager
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Pdf support
(pdf-loader-install)

;; Terminal
(global-set-key (kbd "C-c o t") 'vterm-toggle)
(add-hook 'vterm-mode-hook #'visual-line-mode)

;; File explorer

;;
;; Project management
;;
(setq multi-vterm-dedicated-window-height 18)
(global-set-key (kbd "C-c p t") 'multi-vterm-dedicated-toggle)
(global-set-key (kbd "C-c p e") 'dired-sidebar-toggle-sidebar)

;;
;; Org Mode 
;;
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Org directory
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; Indent bullets
(add-hook 'org-mode-hook #'org-indent-mode)
;; Better look
(add-hook 'org-mode-hook #'org-modern-mode)
;; Evil compatibility
(add-hook 'org-mode-hook #'evil-org-mode)
;; Add "#+auto_tangle: t" option for header
(add-hook 'org-mode-hook 'org-auto-tangle-mode)



;;
;; Julia support
;; 
(setq vterm-kill-buffer-on-exit nil)
(add-hook 'julia-mode-hook (lambda ()
			     (julia-repl-mode 1)
			     (julia-repl-set-terminal-backend 'vterm)
			     ))


;;
;; Org babel
;;
(with-eval-after-load "org"
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t))))

;;
;; Git support
;;
(defun k8x1d/magit-status-w-forge-upd ()
  (interactive)
  (magit-todos-mode)
  (magit-status)
  (forge-pull))
(global-set-key (kbd "C-c g s") 'k8x1d/magit-status-w-forge-upd)
(global-set-key (kbd "C-c g t") 'magit-todos-list)
(setq auth-sources '("~/.authinfo.gpg")
;;(with-eval-after-load 'magit
;;  (require 'forge))
