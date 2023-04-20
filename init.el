;;
;; Startup time
;;

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

;;;; Use a hook so the message doesn't get clobbered by other messages.
;;(add-hook 'emacs-startup-hook
;;          (lambda ()
;;            (message "Emacs ready in %s with %d garbage collections."
;;                     (format "%.2f seconds"
;;                             (float-time
;;                              (time-subtract after-init-time before-init-time)))
;;                     gcs-done)))



;; Define time-mesurement require function 
(require 'benchmark)
(defun timed-require (feat)
  (if (featurep feat)
      (progn (message "erraneous usage: '%s'" feat) nil)
    (message "'%s' loaded in %.2fs" feat
        (benchmark-elapse (load-library (symbol-name feat))))))

;; Add modules to path
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))

(use-package all-the-icons
  :if (display-graphic-p))


(timed-require 'k8x1d-packages)
(timed-require 'k8x1d-dashboard)
;;(timed-require 'k8x1d-dashboard-alt)
;;(timed-require 'lem-setup-splash.el)
(timed-require 'k8x1d-evil)
(timed-require 'k8x1d-modeline)
(timed-require 'k8x1d-completion)

;; Project management
(timed-require 'k8x1d-workspaces)
(timed-require 'k8x1d-gtd)
(timed-require 'k8x1d-vc)

;; Writing support
(timed-require 'k8x1d-org)
(timed-require 'k8x1d-biblio)
(timed-require 'k8x1d-corrector)

;; Programation support
(timed-require 'k8x1d-julia)
(timed-require 'k8x1d-python)
(timed-require 'k8x1d-R)
(timed-require 'k8x1d-lisp)


(timed-require 'k8x1d-multimedia)




;;
;; Frames characteristics
;;


;; Set initial transparency
(if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
    (progn
    (set-frame-parameter nil 'alpha-background 80) ; For current frame
    (add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth
      )
  (progn
   (set-frame-parameter (selected-frame) 'alpha '(90 . 90)) ; For current frame
   (add-to-list 'default-frame-alist '(alpha . (90 . 90))) ; For all new frames henceforth
    ))

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha-background value))

;;
;; Esthetics
;;

;; Fonts
;;(set-face-attribute 'default nil :font "Fira Code" :height 150)
(set-face-attribute 'default nil :font "Hack" :height 100)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
		    :font "Hack"
		    ;;:font "Fira Code"
		    :weight 'light
		    :height 100)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
		    ;; :font "Cantarell"
		    :font "Iosevka Aile"
		    ;;:font "DejaVu Sans"
		    :height 130
		    :weight 'light)

(use-package mixed-pitch
  :hook
  ;; If you want it in all text modes:
  (text-mode . mixed-pitch-mode))

;;
;; Set Theme
;; 


(setq dark-theme 'doom-gruvbox)
(setq light-theme 'doom-gruvbox-light)
(setq actual-theme dark-theme) 

(defun switch-theme (theme)
  (disable-theme actual-theme)
  (setq actual-theme theme)
  (load-theme actual-theme t)
  (custom-set-faces
   `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :weight bold :underline nil :height 1.5))))
   `(tab-bar-tab-inactive ((t (:inherit nil :foreground ,(doom-color 'base6) :height 1.5)))))
   ;;`(org-inline-src-block ((t (:background ,(doom-color 'base3)))))
  )

(defun k8x1d/dark-light-theme-switch ()
  (interactive)
  (if (equal actual-theme dark-theme)
      (switch-theme light-theme)
    (switch-theme dark-theme)
    ))

(global-set-key (kbd "<f5>") 'k8x1d/dark-light-theme-switch)

(add-hook 'after-init-hook (lambda ()
			     ;;(load-theme 'modus-vivendi)
			     (load-theme dark-theme t)
			     (custom-set-faces
			      `(tab-bar ((t (:inherit nil :background "#000000"))))
			      `(tab-bar-tab ((t (:foreground ,(doom-color 'fg) :underline nil :height 1.5))))
			      ;;`(tab-bar-tab-inactive ((t (:inherit nil :background ,(doom-color 'base1) :foreground ,(doom-color 'base6) :height 1.5))))
			      `(tab-bar-tab-inactive ((t (:inherit nil :background "#000000" :foreground ,(doom-color 'base6) :height 1.5))))
			      )
			     ))
;;(load-theme 'modus-operandi)


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
(add-hook 'after-init-hook #'global-hl-line-mode)
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

;;;; Show git info in dired
;;;; Prone to error
;;(add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable)



;;
;; Native compilation
;;
(setq warning-minimum-level :error)


(add-hook 'after-init-hook (lambda ()
				  (evil-mode 1)
				  (evil-collection-init)))

;; TODO: adjust, set evil-mode when doc ess
;;(evil-set-initial-state 'inferior-ess-mode 'emacs)

;;
;; Teach emacs to be clean!
;; From: https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-Tips-Cleaning.org 
;;


(setq user-emacs-directory (expand-file-name "~/.k8x1d-emacs.d"))

(setq user-emacs-cache-directory (expand-file-name "~/.cache/emacs"))

;; Backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-cache-directory))))

;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-cache-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-cache-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-cache-directory) t)))


;; Custom file location
(setq custom-file (concat user-emacs-cache-directory "/custom.el"))

;;
;; Completion
;;



;;
;; Utilities
;;

;; Better buffer manager
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Pdf support
(pdf-loader-install)
(add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode) ;; dark mode by default

;; Terminal
(global-set-key (kbd "C-c o t") 'vterm-toggle)
(add-hook 'vterm-mode-hook #'visual-line-mode)

;; File explorer

;; Pass interation
(global-set-key (kbd "C-c o p") 'pass)

;; Guix packages management
(global-set-key (kbd "C-c o g") 'guix)



;;
;; Project management
;;
(setq multi-vterm-dedicated-window-height 18)
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))

;;(add-hook 'dired-sidebar-mode #'dired-git-info-mode)

(global-set-key (kbd "C-x p o t") 'multi-vterm-dedicated-toggle)
(global-set-key (kbd "C-x p o e") 'dired-sidebar-toggle-sidebar)
;;(global-set-key (kbd "C-x p o e") 'sidebar-toggle) ;; bug with ibuffer-sidebar upd



;; Pomodoro
(setq org-pomodoro-length 50)
(setq org-pomodoro-short-break-length 10)
(setq org-pomodoro-long-break-length 30)











;;
;; Latex support
;; 

;; Reftex (toc and references)
(setq reftex-toc-split-windows-horizontally t)
(setq reftex-toc-max-level 3)
(setq reftex-toc-split-windows-fraction 0.2)

(add-hook 'LaTeX-mode-hook  #'turn-on-reftex)
(add-hook 'LaTeX-mode-hook  #'eglot-ensure)

;; Default pdf viewer
(setq TeX-view-program-selection '((output-pdf "PDF Tools")))

;; Wrap text 
(add-hook 'LaTeX-mode-hook #'visual-line-mode)


;; OLD ;;
;;(use-package reftex
;;  :hook
;;  (reftex-mode . visual-line-mode)
;;  :config
;;  (setq reftex-toc-split-windows-horizontally t)
;;  (setq reftex-toc-max-level 3)
;;  (setq reftex-toc-split-windows-fraction 0.2)
;;  )
;;
;;
;;(use-package auctex
;;  :init
;;  (setq TeX-parse-self t ; parse on load
;;	TeX-auto-save t  ; parse on save
;;	;; Use hidden directories for AUCTeX files.
;;	TeX-auto-local ".auctex-auto"
;;	TeX-style-local ".auctex-style"
;;	TeX-source-correlate-mode t
;;	TeX-source-correlate-method 'synctex
;;	;; Don't start the Emacs server when correlating sources.
;;	TeX-source-correlate-start-server nil
;;	;; Automatically insert braces after sub/superscript in `LaTeX-math-mode'.
;;	TeX-electric-sub-and-superscript t
;;	;; Just save, don't ask before each compilation.
;;	TeX-save-query nil
;;
;;	TeX-source-correlate-start-server t
;;	TeX-PDF-mode t
;;	;; Set pdf viewer
;;	TeX-view-program-selection '((output-pdf "PDF Tools"))
;;	reftex-plug-into-AUCTeX t)
;;  (add-hook 'TeX-after-compilation-finished-functions
;;	    #'TeX-revert-document-buffer)
;;  (custom-set-faces
;;   `(font-latex-slide-title-face ((t (:inherit (variable-pitch font-lock-type-face) :weight bold :height 0.8))))
;;   )
;;  :hook
;;  ((LaTeX-mode . eglot-ensure)
;;   (LaTeX-mode . LaTeX-math-mode)
;;   (LaTeX-mode . turn-on-reftex))
;;  ;;(add-hook 'LaTeX-mode-hook 'eglot-ensure)
;;  ;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;;  ;;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;  )
;;
;;(use-package auctex-latexmk
;;  :defer t
;;  :after auctex
;;  :init
;;  ;; Pass the -pdf flag when TeX-PDF-mode is active.
;;  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
;;  ;; Set LatexMk as the default.
;;  :config
;;  (setq TeX-command-default "LatexMk")
;;  ;; Add LatexMk as a TeX target.
;;  (auctex-latexmk-setup))


;;
;; Org-roam
;;
(setq org-roam-directory (concat org-directory "/roam"))
(setq find-file-visit-truename t)
(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

;; Ui
(setq org-roam-ui-sync-theme t
      org-roam-ui-follow t
      org-roam-ui-update-on-save t
      org-roam-ui-open-on-start t)

(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
;;(global-set-key (kbd "C-c n g") 'org-roam-graph)
(global-set-key (kbd "C-c n g") 'org-roam-ui-open)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(global-set-key (kbd "C-c n c") 'org-roam-capture)
(global-set-key (kbd "C-c n j") 'org-roam-dailies-capture-today)


;; Upd database
(add-hook 'org-mode-hook #'org-roam-db-autosync-mode)
;;;; Web visualization network
;;(add-hook 'org-roam-db-autosync-mode-hook #'org-roam-ui-mode)
;; Integration with citar

(with-eval-after-load 'citar
  (citar-org-roam-mode 1))

(with-eval-after-load 'org-roam
  (citar-org-roam-mode 1))


;;(use-package consult-org-roam
;;   :ensure t
;;   :after org-roam
;;   :init
;;   (require 'consult-org-roam)
;;   ;; Activate the minor mode
;;   (consult-org-roam-mode 1)
;;   :custom
;;   ;; Use `ripgrep' for searching with `consult-org-roam-search'
;;   (consult-org-roam-grep-func #'consult-ripgrep)
;;   ;; Configure a custom narrow key for `consult-buffer'
;;   (consult-org-roam-buffer-narrow-key ?r)
;;   ;; Display org-roam buffers right after non-org-roam buffers
;;   ;; in consult-buffer (and not down at the bottom)
;;   (consult-org-roam-buffer-after-buffers t)
;;   :config
;;   ;; Eventually suppress previewing for certain functions
;;   (consult-customize
;;    consult-org-roam-forward-links
;;    :preview-key (kbd "M-."))
;;   :bind
;;   ;; Define some convenient keybindings as an addition
;;   ("C-c n e" . consult-org-roam-file-find)
;;   ("C-c n b" . consult-org-roam-backlinks)
;;   ("C-c n l" . consult-org-roam-forward-links)
;;   ("C-c n r" . consult-org-roam-search))


;;;;
;;;; File explorer
;;;; 




;;(use-package treemacs
;;  :config
;;  (treemacs-follow-mode 1)
;;  (treemacs-filewatch-mode 1)
;;  (treemacs-project-follow-mode 1)
;;  :bind
;;  ("C-x p o e"   . treemacs)
;;  )
;;
;;(use-package treemacs-evil
;;  :after (treemacs evil)
;;  )
;;
;;(use-package treemacs-magit
;;  :after (treemacs magit)
;;  )

;;
;; Geiser support
;;


;;
;; Keybinding
;;

;; ESC Cancels All
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;
;; Create leader keybinding
;;
					
(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer k8x1d/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))


(k8x1d/leader-key-def
  "f"  '(:ignore t :which-key "Find")
  "ff" '(find-file :which-key "File")
  "fs" '(save-some-buffers :which-key "Save")
  "o"  '(:ignore t :which-key "Open")
  "oa" '(org-agenda :which-key "Agenda")
  "ot" '(multi-vterm-project :which-key "Terminal")
  "os" '(dired-sidebar-toggle-sidebar :which-key "Sidebar")
  "w" '(:ignore t :which-key "Window")
  "wc" '(evil-window-delete :which-key "Delete")
  "ws" '(evil-window-split :which-key "Split")
  "wv" '(evil-window-vsplit :which-key "Vsplit")
  "wh" '(evil-window-left :which-key "Left")
  "wj" '(evil-window-down :which-key "Down")
  "wk" '(evil-window-up :which-key "Up")
  "wl" '(evil-window-right :which-key "Right")
  "wH" '(evil-window-move-far-left :which-key "Move Left")
  "wJ" '(evil-window-move-very-bottom :which-key "Move Down")
  "wK" '(evil-window-move-very-top :which-key "Move Up")
  "wL" '(evil-window-move-far-right :which-key "Move Right")
 ;; ;; TODO: add workspaces keys
  "<tab>" '(:ignore t :which-key "Tabspaces")
  "<tab> C" '(tabspaces-clear-buffers :which-key "clear-buffers")
  "<tab> b" '(tabspaces-switch-to-buffer :which-key "switch-to-buffer")
  "<tab> d" '(tabspaces-close-workspace :which-key "close-workspace")
  "<tab> k" '(tabspaces-kill-buffers-close-workspace :which-key "kill-buffers-close-workspace")
  "<tab> o" '(tabspaces-open-or-create-project-and-workspace :which-key "open-or-create-project-and-workspace")
  "<tab> r" '(tabspaces-remove-current-buffer :which-key "remove-current-buffer")
  "<tab> R" '(tabspaces-remove-selected-buffer :which-key "remove-selected-buffer")
  "<tab> s" '(tabspaces-switch-or-create-workspace :which-key "switch-or-create-workspace")
  "<tab> t" '(tabspaces-switch-buffer-and-tab :which-key "switch-buffer-and-tab")

  ;; TODO: add project keys
  ;; TODO: add bookmark keys

  "RET" '(bookmark-jump :which-key "Bookmarks")
  ;;
  "q" '(:ignore t :which-key "Quit")
  "qq" '(save-buffers-kill-terminal :which-key "Emacs")
  )
