
;;
;; Disable package.el in favor of guix
;;
(setq package-enable-at-startup nil)

;;
;;; UI configuration
;;
;; Remove some unneeded UI elements (the user can turn back on anything they wish)
;; https://github.com/SystemCrafters/crafted-emacs/blob/master/early-init.el
(setq inhibit-startup-message t)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(mouse-color . "white") default-frame-alist)


;; Initial colors
;; Prevent white flash
(add-to-list 'default-frame-alist '(background-color . "#282828"))
(add-to-list 'default-frame-alist '(foreground-color . "#ebdbb2"))
(push '(mouse-color . "#ebdbb2") default-frame-alist)
