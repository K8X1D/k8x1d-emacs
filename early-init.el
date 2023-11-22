;;; package --- Summary "-*- lexical-binding: t -*-"

;;; Commentary:

;;; Code:

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

;; get rid of ui elements immediately so they don't linger
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)       ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

;; disable any sort of startup messaging
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message user-login-name)
(setq initial-major-mode 'fundamental-mode)

;; disable dialog boxes
(setq use-file-dialog nil)
(setq use-dialog-box nil)

;; Initial frame parameters
(setq frame-inhibit-implied-resize t)
(add-to-list 'default-frame-alist '(background-color . "#282828"))
(add-to-list 'default-frame-alist '(foreground-color . "#ebdbb2"))
(setq frame-resize-pixelwise t) ;; take alle the available space for window
(set-frame-parameter nil 'alpha-background 80) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth

;; Stop emacs from littering the file system with backup files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Set user paths
(setq user-emacs-directory (expand-file-name "~/.k8x1d-emacs.d"))
(setq user-emacs-cache-directory (concat user-emacs-directory "/.cache"))
(setq custom-theme-directory (concat user-emacs-directory "/themes"))

;; load the directory that contains all custom modules
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))

;; setup the user's custom settings file
(setq custom-file (expand-file-name "custom.el" user-emacs-cache-directory))
(load custom-file 'noerror)

;; Set fonts
(custom-set-faces
 '(default ((t (:inherit nil :height 120 :family "Iosevka Term Nerd Font"))))
 '(fixed-pitch ((t (:inherit nil :height 1.0 :family "Iosevka Term Nerd Font"))))
 '(variable-pitch ((t (:inherit nil :height 1.0 :family "Iosevka Nerd Font"))))
 )

;; Simplify and uniformize proomting
(defalias 'yes-or-no-p 'y-or-n-p)

(print "loading early-init.el done")
