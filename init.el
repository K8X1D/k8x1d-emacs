
(load-theme 'modus-vivendi t)

;; Remove ui elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq use-file-dialog nil)
(setq use-dialog-box nil)

(setq use-short-answers t) ;; y-or-p insteat of yes-or-no

;;; Garbage collection
(setq gc-cons-threshold most-positive-fixnum) ;; Increase gc threshold at start
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))  ;; Decrease gc threshold after start

;;; Performance

(setq load-prefer-newer t) ;; Prefer loading newer compiled files
(setq read-process-output-max (* 512 1024))  ;; Increase how much is read from processes in a single chunk (default is 4kb).
;; Reduce rendering/line scan work by not rendering cursors or regions in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Disable warnings from the legacy advice API. They aren't useful.
(setq ad-redefinition-action 'accept)
(setq warning-suppress-types '((lexical-binding)))

(setq ffap-machine-p-known 'reject) ;; Don't ping things that look like domain names.
(setq idle-update-delay 1.0) ;; By default, Emacs "updates" its ui more often than it needs to
;; Font compacting can be very resource-intensive, especially when rendering
;; icon fonts on Windows. This will increase memory usage.
(setq inhibit-compacting-font-caches t)


;; Package.el
(setq package-enable-at-startup nil)
(setq package-quickstart nil)


;; Add personal modules to load-path 
(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(keymap-global-set "C-x C-b" #'ibuffer)

(require 'evil-module)
(require 'file-explorer-module)
(require 'icons-module)
(require 'completion-module)
(require 'lsp-module)
(require 'checker-module)
(require 'terminal-module)
(require 'r-module)
(require 'julia-module)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values '((eval tab-rename "Journal") (lsp-ltex-language . "fr"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
