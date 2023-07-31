;;; early-init.el -*- lexical-binding: t; -*-
;; Inspirations:
;; - https://github.com/schmidthole/.emacs.d/blob/master/early-init.el

;; (setq gc-cons-threshold most-positive-fixnum
;;       gc-cons-percentage 0.6)

;; ;; pre-compute an autoload file so that the activation of packages can be done much faster
;; (setq package-quickstart t)

;; (setq inhibit-startup-message t)

;; ;; Clean initial Gui
;; (scroll-bar-mode -1)        ; Disable visible scrollbar
;; (tool-bar-mode -1)          ; Disable the toolbar
;; (tooltip-mode -1)           ; Disable tooltips
;; (set-fringe-mode 10)       ; Give some breathing room
;; (menu-bar-mode -1)            ; Disable the menu bar


;; (setq use-file-dialog nil)
;; (setq use-dialog-box nil)
;; (setq inhibit-startup-message t)


;; ;; Initial colors
;; (add-to-list 'default-frame-alist '(background-color . "#282828"))
;; (add-to-list 'default-frame-alist '(foreground-color . "#ebdbb2"))
;; (push '(mouse-color . "#ebdbb2") default-frame-alist)

;; ;; Initial frame parameters
;; (setq frame-inhibit-implied-resize t)

;; ;; Initial frame
;; (customize-set-variable 'initial-major-mode 'fundamental-mode)

;; ;; Stop emacs from littering the file system with backup files
;; (setq make-backup-files nil
;;       auto-save-default nil
;;       create-lockfiles nil)

;; ;; Limit message to error
;; (setq warning-minimum-level :error)


;;
;; New version
;;
(setq gc-cons-threshold (* 50 1000 1000))

(setq load-prefer-newer noninteractive)

;; pre-compute an autoload file so that the activation of packages can be done much faster
(setq package-quickstart t)

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
(push '(mouse-color . "#ebdbb2") default-frame-alist)
(setq frame-resize-pixelwise t) ;; take alle the available space for window

;; Stop emacs from littering the file system with backup files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Set user paths
(setq user-emacs-directory (expand-file-name "~/.k8x1d-emacs.d"))
(setq user-emacs-cache-directory (expand-file-name "~/.cache/emacs"))

;; setup the user's custom settings file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; load the directory that contains all custom modules
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))

;;; early-init.el ends here
