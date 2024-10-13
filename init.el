;; Source
;; - https://medium.com/@danielorihuelarodriguez/optimize-emacs-start-up-time-ae314201e04f
;; - https://tychoish.com/post/towards-faster-emacs-start-times/
;; - https://arne.me/blog/emacs-from-scratch-part-one-foundations


;; Print start-up time
(add-to-list 'after-init-hook
          (lambda ()
            (message (concat "emacs (" (number-to-string (emacs-pid)) ") started in " (emacs-init-time)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Common variables ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar k8x1d/bibliography '("~/Zotero/k8x1d.bib")) ;; Defaults bibliography
;; TODO: add choice of value
(defvar k8x1d/checker "flycheck")
(defvar k8x1d/lsp "lsp-mode")
(defvar k8x1d/theme "doom")
(defvar k8x1d/org-gui "custom")
(defvar k8x1d/package-manager "package.el")
(defvar k8x1d/terminal "vterm")
;; (defvar k8x1d/terminal "shell") ;; julia support is bad
;; (defvar k8x1d/journal-directory "/extension/Data/Cloud/facil/journal")
(defvar k8x1d/org-directory "~/org")
(defvar k8x1d/notes-directory (concat k8x1d/org-directory "/Notes"))
(defvar k8x1d/inbox-directory (concat k8x1d/org-directory "/Inbox"))
(defvar k8x1d/journal-directory (concat k8x1d/org-directory "/Journals"))
(defvar k8x1d/calendars-directory (concat k8x1d/org-directory "/Calendars"))
(defvar k8x1d/org-agenda-files (list (concat k8x1d/org-directory "/Projects")
				     k8x1d/calendars-directory
				     k8x1d/inbox-directory)) 
;; (defvar k8x1d/package-manager "elpaca")
;; (defvar k8x1d/checker "flymake")
;; (defvar k8x1d/lsp "eglot")
;; (defvar k8x1d/checker "")
;; (defvar k8x1d/lsp "lsp-bridge")


(with-timer "package setup"
	    (require 'packages-module)
	    )


(with-timer "base set-up setup"
	    (require 'keybindings-module)
	    (require 'evil-module)
	    (require 'encoding-module)
	    )

(with-timer "UI set-up"
	    (require 'file-explorer-module)
	    (require 'highlight-module)
	    (require 'modeline-module)
	    (require 'icons-module)
	    (require 'windows-module)
	    (require 'tab-module)
	    (require 'fonts-module)
	    (require 'files-module)
	    (require 'themes-module)
	    (require 'documentation-module)
	    (require 'line-number-module)
	    (require 'buffers-module)
	    (require 'cursor-module)
	    )

(with-timer "Utilities set-up"
	    (require 'terminal-module)
	    (require 'bluetooth-module)
	    (require 'multimedia-module)
	    (require 'pdf-module)
	    )

(with-timer "Work set-up"
	    (require 'completion-module)
	    (require 'lsp-module)
	    (require 'checker-module)
	    (require 'notebook-module)
	    (require 'compilation-module)
	    (require 'vc-module)
	    (require 'projects-module)
	    (require 'corrector-module)
	    (require 'treesitter-module)
	    )


(with-timer "Prog set-up"
	    (require 'r-module)
	    (require 'julia-module)
	    (require 'shell-module)
	    (require 'scheme-module)
	    )

(with-timer "Text set-up"
	    (require 'text-module)
	    (require 'notes-taking-module)
	    (require 'csv-module)
	    (require 'org-module)
	    (require 'markdown-module)
	    (require 'latex-module)
	    )

(with-timer "System set-up"
	    (require 'guix-module)
	    (require 'process-manager-module)
	    )

(with-timer "Utilities set-up"
	    (require 'social-module)
	    (require 'torrents-module)
	    (require 'bibliography-module)
	    (require 'password-module)
	    (require 'chatbot-module)
	    (require 'rss-module)
	    (require 'calendar-module)
	    )
