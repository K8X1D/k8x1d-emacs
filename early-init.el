;;; package --- Summary

;;; Commentary:

;;; Code:


;; Inspirations:
;; - https://github.com/schmidthole/.emacs.d/blob/master/early-init.el
(require 'cl-lib)
;;
;; Garbage collection
;;

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

(setq load-prefer-newer noninteractive)

;; pre-compute an autoload file so that the activation of packages can be done much faster
;; (setq package-quickstart t)
;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

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
(add-to-list 'default-frame-alist '(background-color . "#292D3E"))
(add-to-list 'default-frame-alist '(foreground-color . "#EEFFFF"))
(setq frame-resize-pixelwise t) ;; take alle the available space for window

;; Stop emacs from littering the file system with backup files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Set user paths
(setq user-emacs-directory (expand-file-name "~/.k8x1d-emacs.d"))
(setq user-emacs-cache-directory (expand-file-name "~/.cache/emacs"))
(setq custom-theme-directory (concat user-emacs-directory "/themes"))

;; setup the user's custom settings file
(setq custom-file (expand-file-name "custom.el" user-emacs-cache-directory))
(load custom-file 'noerror)

;; load the directory that contains all custom modules
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))


;; Set initial transparency

(set-frame-parameter nil 'alpha-background 80) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth

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


;;; early-init.el ends here
