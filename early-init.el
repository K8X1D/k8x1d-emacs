;;; early-init.el -*- lexical-binding: t; -*-

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; pre-compute an autoload file so that the activation of packages can be done much faster
(setq package-quickstart t)
;;(setq package-enable-at-startup nil)

;; Initial Gui
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(scroll-bar-mode -1)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-message t)


;; Initial colors
(add-to-list 'default-frame-alist '(background-color . "#282828"))
(add-to-list 'default-frame-alist '(foreground-color . "#ebdbb2"))
(push '(mouse-color . "#ebdbb2") default-frame-alist)

;; Initial frame parameters
;;(set-frame-parameter (selected-frame) 'alpha 90)
;;(add-to-list 'default-frame-alist '(alpha .  90))
;;(set-frame-parameter nil 'alpha-background 80)
;;(add-to-list 'default-frame-alist '(alpha-background . 80))

(if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
    (progn
      (set-frame-parameter nil 'alpha-background 80)
      (add-to-list 'default-frame-alist '(alpha-background . 80)))
  (progn
    (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
    (add-to-list 'default-frame-alist '(alpha . (90 . 90)))))


(setq frame-inhibit-implied-resize t)

;; Initial frame
(customize-set-variable 'initial-major-mode 'fundamental-mode)

;; Stop emacs from littering the file system with backup files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Limit message to error
(setq warning-minimum-level :error)

;; Separate customizatio in a particular file
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

;;; early-init.el ends here
