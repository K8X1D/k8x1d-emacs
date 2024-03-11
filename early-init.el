;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
;; Lower threshold back to 1 GB
(add-hook 'emacs-startup-hook
          (lambda ()
            ;;(setq gc-cons-threshold (* 1000 1024 1024)))) ;; Its value is 1048576000
            ;; (setq gc-cons-threshold (* 1024 1024 100)))) ;; Its value is 104857600
            (setq gc-cons-threshold (* 16 1024 1024)))) ;; doom-emacs value

;; Disable dialog boxes

  (setq use-file-dialog nil)
  (setq use-dialog-box nil)


(setq inhibit-startup-screen t) ;; no startup screen


(setq frame-inhibit-implied-resize t)
(setq frame-resize-pixelwise t) ;; take all the available space for window
(set-frame-parameter nil 'alpha-background 80) ;; initial transparency For current frame
(add-to-list 'default-frame-alist '(alpha-background . 80)) ;; initial transparency for all new frames henceforth



(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 5)       ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar



;; Add lisp module and subdirectory to path
(let ((default-directory  (concat user-emacs-directory "/lisp")))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))
(setq user-emacs-cache-directory (concat user-emacs-directory ".cache"))
(setq custom-theme-directory (concat user-emacs-directory "themes"))

;; Add guix package
;;(add-to-list 'load-path "/home/k8x1d/guix-extra-profiles/emacs-test/emacs-test/share/emacs/site-lisp")
;;(guix-emacs-autoload-packages)



;; Setup the user's custom settings file
(setq custom-file (expand-file-name "custom.el" user-emacs-cache-directory))
(load custom-file 'noerror)

;; Profile startup
(setq use-package-compute-statistics t)

;; Backup files management
;; TODO: add variable for path construction
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.config/k8x1d-emacs/.cache/backup/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; Compilations info
(setq byte-compile-warnings nil) ;; hide warnings

;; Simplify and uniformize prompting
(defalias 'yes-or-no-p 'y-or-n-p)

;; Stop enabling package
;; (setq package-enable-at-startup nil)

(require 'doom-themes)
(load-theme 'doom-palenight t)
