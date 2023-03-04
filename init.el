;;; init.el -*- lexical-binding: t; -*-

;; Show start-up time
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded in %s."
                     (emacs-init-time))))

;; Change gc threshold
(setq gc-cons-threshold most-positive-fixnum)

;; Define time-mesurement require function 
(require 'benchmark)
(defun timed-require (feat)
  (if (featurep feat)
      (progn (message "erraneous usage: '%s'" feat) nil)
    (message "'%s' loaded in %.2fs" feat
        (benchmark-elapse (load-library (symbol-name feat))))))



;; User identification
(setq user-full-name "Kevin Kaiser"
      user-mail-address "k8x1d@proton.me")


;; Set initial transparency
(if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
    (progn
    (set-frame-parameter nil 'alpha-background 80)
    (add-to-list 'default-frame-alist '(alpha-background . 80))
      )
  (progn
   (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
   (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
    ))


;; Add modules to path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Load modules of interest
(timed-require 'packages-module)
(timed-require 'keybindings-module)
(timed-require 'org-module)
(timed-require 'evil-module)
(timed-require 'gui-module)
(timed-require 'completion-module)
(timed-require 'file-explorer-module)
(timed-require 'utilities-module)
(timed-require 'git-module)
(timed-require 'prog-module)
(timed-require 'text-module)




;;
;; Helper functions
;;

;; Change opacity
(defun k8x1d/set-opacity (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (if (eq window-system 'pgtk)
      (set-frame-parameter (selected-frame) 'alpha-background value)
    (set-frame-parameter (selected-frame) 'alpha value)))

;; Test if pgtk
(defun k8x1d/test-pgtk ()
  (interactive)
  (if (eq window-system 'pgtk)
      (print "yes")
    (print "no")))





