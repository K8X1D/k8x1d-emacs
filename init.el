;;; package --- Summary

;;; Commentary:

;;; Code:

;;
;; Utilities
;;

(require 'k8x1d-utilities)

;;
;; General config
;;
(defvar k8x1d-lsp-module "lsp-mode")
(defvar k8x1d-consult-integration t)
(defvar week-aims-path "~/org/objectifs_hebdomadaires.txt")

;; ID
(setq user-full-name "Kevin Kaiser"
      user-mail-address "k8x1d@proton.me")
(defvar k8x1d-default-bibliography '("~/Zotero/k8x1d.bib"))

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

;; Writing support
(timed-require 'k8x1d-org)
(timed-require 'k8x1d-biblio)
(timed-require 'k8x1d-corrector)
(timed-require 'k8x1d-notes-taking)
(timed-require 'k8x1d-markdown)

;; Programation support
(timed-require 'k8x1d-treesitter)
(timed-require 'k8x1d-lsp)
(timed-require 'k8x1d-julia)
(timed-require 'k8x1d-lua)
(timed-require 'k8x1d-python)
(timed-require 'k8x1d-R)
(timed-require 'k8x1d-lisp)
(timed-require 'k8x1d-latex)
(timed-require 'k8x1d-docker)
;; (timed-require 'k8x1d-repl)
(timed-require 'k8x1d-ssh)
(timed-require 'k8x1d-template)

;; Other
(timed-require 'k8x1d-terminal)
(timed-require 'k8x1d-multimedia)
(timed-require 'k8x1d-news)
(timed-require 'k8x1d-password)
(timed-require 'k8x1d-presentation)
(timed-require 'k8x1d-system)
(timed-require 'k8x1d-pdf)



;; cleanup and reset after startup
(add-hook 'emacs-startup-hook
	  (lambda () (setq gc-cons-threshold 16777216 gc-cons-percentage 0.1)))

(setq gc-cons-threshold (* 2 1000 1000))


;;
;; Set theme
;;

(load-theme 'k8x1d-dark t)
;; (load-theme 'lambda-dark t)
;; (load-theme k8x1d/actual-theme t)
;; (k8x1d/adjust-theme)
;;(doom-modeline-mode 1)
;;(lambda-line-mode 1)





 ;;; init.el ends here
