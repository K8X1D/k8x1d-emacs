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

(timed-require 'k8x1d-dashboard)
(timed-require 'k8x1d-evil)
(timed-require 'k8x1d-modeline)
(timed-require 'k8x1d-julia)
(timed-require 'k8x1d-python)
(timed-require 'k8x1d-workspaces)
(timed-require 'k8x1d-biblio)
(timed-require 'k8x1d-corrector)





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
(set-face-attribute 'default nil :font "Fira Code" :height 150)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
		    :font "JetBrains Mono"
		    ;;:font "Fira Code"
		    :weight 'light
		    :height 150)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
		    ;; :font "Cantarell"
		    :font "Iosevka Aile"
		    ;;:font "DejaVu Sans"
		    :height 150
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

;; Tab configuration
;;(setq tab-bar-show nil)
(setq tab-bar-new-tab-choice "*scratch*"
      tab-bar-close-button-show t
      tab-bar-new-button-show nil
      tab-bar-auto-width t
      tab-bar-separator " "
      )

tab-bar-close-button

(custom-set-faces
 '(tab-bar ((t (:inherit nil :foreground "#928374" :height 1.0))))
 '(tab-bar-tab ((t (:foreground "#ebdbb2":weight bold :underline nil))))
)

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
;; Show git info in dired
(add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable)



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
(add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode) ;; dark mode by default

;; Terminal
(global-set-key (kbd "C-c o t") 'vterm-toggle)
(add-hook 'vterm-mode-hook #'visual-line-mode)

;; File explorer

;; Pass interation
(global-set-key (kbd "C-c o p") 'pass)

;; Guix packages management
(global-set-key (kbd "C-c o g") 'guix)

;; Multimedia player
(emms-minimalistic)
(setq emms-player-list '(emms-player-mpv)
      emms-info-functions '(emms-info-native))

;;
;; Project management
;;
(setq multi-vterm-dedicated-window-height 18)
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))


(global-set-key (kbd "C-x p o t") 'multi-vterm-dedicated-toggle)
;;(global-set-key (kbd "C-x p o e") 'dired-sidebar-toggle-sidebar)
(global-set-key (kbd "C-x p o e") 'sidebar-toggle)



;;
;; Org Mode 
;;

(global-set-key (kbd "C-c l") #'org-store-link)

;; Indent bullets
(add-hook 'org-mode-hook #'org-indent-mode)

;; Modern look to org
;; TODO: explore doc for org-modern
;; Must be set after org-indent-mode, if not, coloring problem occurs (invisible level-2 bullets)
;;(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-indent-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
;;(global-org-modern-mode)


(setq org-image-actual-width nil)

;; Org directory
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "/gtd/inbox.org"))


;; Add "#+auto_tangle: t" option for header
(add-hook 'org-mode-hook #'org-auto-tangle-mode)
;; Wrap text by default
(add-hook 'org-mode-hook #'visual-line-mode)


;; Pomodoro
(setq org-pomodoro-length 50)
(setq org-pomodoro-short-break-length 10)
(setq org-pomodoro-long-break-length 30)


;; Bibliography
(setq org-cite-global-bibliography '("~/Zotero/k8x1d.bib"))


;; Esthetics
(setq org-insert-heading-respect-content t)

;; Visibility of hidden elements only when in insert mode
;; from https://github.com/awth13/org-appear
(add-hook 'org-mode-hook #'org-appear-mode)
(setq org-hide-emphasis-markers t
      org-appear-trigger 'manual
      org-appear-autoemphasis t
      org-appear-autolinks t)

(add-hook 'org-mode-hook (lambda ()
                           (add-hook 'evil-insert-state-entry-hook
                                     #'org-appear-manual-start
                                     nil
                                     t)
                           (add-hook 'evil-insert-state-exit-hook
                                     #'org-appear-manual-stop
                                     nil
                                     t)))




;; GTD
;; From https://lucidmanager.org/productivity/getting-things-done-with-emacs/
;; From https://members.optusnet.com.au/~charles57/GTD/orgmode.html
;; https://hamberg.no/gtd
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))


(global-set-key (kbd "C-c a") #'org-agenda)
(setq org-agenda-files (file-expand-wildcards (concat org-directory "/gtd/*.org")))
;;(setq org-agenda-files 
;;      '((concat org-directory "/todo.org") 
;;	(concat org-directory "/notes.org")
;;	(concat org-directory "/projects.org")))


;;
;; Org babel
;;
(with-eval-after-load "org"
  (setq org-confirm-babel-evaluate nil)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (julia-vterm . t))))

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
(setq auth-sources '("~/.authinfo.gpg"))
;;(with-eval-after-load 'magit
;;  (require 'forge))


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

