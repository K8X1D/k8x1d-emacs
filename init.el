;;; package --- Summary

;;; Commentary:

;;; Code:


(defvar default-bibliography '("~/Zotero/k8x1d.bib"))
(defvar org-directory "~/org")
(defvar lsp-framework "lsp-bridge")

(require 'packages-module)

;; Managements
(require 'buffer-module)
(require 'workspace-module)

;; UI
(require 'ui-module)
(require 'evil-module)
(require 'completion-module)
(require 'modeline-module)
(require 'fonts-module)
(require 'icons-module)

;; Utilities
(require 'org-module)
(require 'password-module)
(require 'terminal-module)
(require 'system-module)
(require 'ssh-module)
(require 'pdf-module)
(require 'multimedia-module)

;; Programming support
(require 'lsp-module)
(require 'checker-module)
(require 'formatter-module)
(require 'version-control-module)
(require 'sidebar-module)

;; Writting support
(require 'corrector-module)
(require 'bibliography-module)
(require 'notes-taking-module)

;; Support modules
(require 'latex-module)
(require 'python-module)
(require 'r-module)
(require 'julia-module)
(require 'qml-module)
(require 'scheme-module)
(require 'markdown-module)

;; Doom look
(require 'doom-module)
(require 'dashboard-module)

(print "loading init.el done")
;;; init.el ends here
