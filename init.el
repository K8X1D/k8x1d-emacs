;; -*- lexical-binding: t; -*-

;;
;; Startup time
;;


;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))


;; Add modules to path
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))

;;
;; Module to load
;;

(timed-require 'k8x1d-profile)
(timed-require 'k8x1d-packages)
(timed-require 'k8x1d-keybindings)
(timed-require 'k8x1d-evil)
(timed-require 'k8x1d-completion)
(timed-require 'k8x1d-file-explorer)
(timed-require 'k8x1d-buffers)
(timed-require 'k8x1d-frames)
(timed-require 'k8x1d-utilities)
(timed-require 'k8x1d-clean)
(timed-require 'k8x1d-ui)

;; Gui
(timed-require 'k8x1d-fonts)
(timed-require 'k8x1d-icons)
;; (timed-require 'k8x1d-dashboard) appear superflous
(timed-require 'k8x1d-modeline)
(timed-require 'k8x1d-theme)
;; ok

;; Project management
(timed-require 'k8x1d-project)
(timed-require 'k8x1d-workspaces)
(timed-require 'k8x1d-gtd)
(timed-require 'k8x1d-vc)

;; no time diff
;; Writing support
(timed-require 'k8x1d-org)
(timed-require 'k8x1d-biblio)
(timed-require 'k8x1d-corrector)
(timed-require 'k8x1d-notes-taking)
(timed-require 'k8x1d-markdown)

;; no time diff
;; Programation support
;;(timed-require 'k8x1d-treesitter)
(timed-require 'k8x1d-lsp)
(timed-require 'k8x1d-julia)
(timed-require 'k8x1d-python)
(timed-require 'k8x1d-R)
(timed-require 'k8x1d-lisp)
(timed-require 'k8x1d-latex)
(timed-require 'k8x1d-docker)

;; no time diff
;; Other
(timed-require 'k8x1d-terminal)
(timed-require 'k8x1d-multimedia)
(timed-require 'k8x1d-news)
(timed-require 'k8x1d-password)
(timed-require 'k8x1d-presentation)
(timed-require 'k8x1d-system)
(timed-require 'k8x1d-pdf)
