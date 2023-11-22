;;; package --- Summary "-*- lexical-binding: t -*-"

;;; Commentary:

;;; Code:


(defvar default-bibliography '("~/Zotero/k8x1d.bib"))
(defvar org-directory "~/org")
(defvar lsp-framework "lsp-mode")
(defvar file-explorer "dirvish")
;; (defvar theme-framework "modus")
(defvar theme-framework "doom")
(defvar file-explorer "dirvish")

(require 'packages-module)
(require 'byte-compile-module)
(require 'keybindings-module)

;; Utilities
(require 'utilities-module)

;; Doom look
(require 'doom-module)

;; Managements
(require 'buffer-management-module)
(require 'project-management-module)
(require 'file-explorer-module)

;; UI
(require 'ui-module)
(require 'evil-module)
(require 'completion-module)
(require 'modeline-module)
(require 'fonts-module)
(require 'icons-module)
(require 'dashboard-module)

;; Utilities
(require 'org-module)
(require 'password-module)
(require 'terminal-module)
(require 'system-module)
(require 'ssh-module)
(require 'pdf-module)
(require 'multimedia-module)
(require 'gtd-module)
(require 'server-module)

;; Programming support
(require 'lsp-module)
(require 'checker-module)
(require 'formatter-module)
(require 'version-control-module)
(require 'sidebar-module)
(require 'snippets-module)
(require 'treesitter-module)

;; Writting support
(require 'corrector-module)
(require 'bibliography-module)
(require 'notes-taking-module)
(require 'presentation-module)
(require 'csv-module)
(require 'notebook-module)

;; Support modules
(require 'latex-module)
(require 'python-module)
(require 'r-module)
(require 'julia-module)
(require 'qml-module)
(require 'scheme-module)
(require 'lua-module)
(require 'nix-module)
(require 'markdown-module)
(require 'news-module)




(print "loading init.el done")
;;; init.el ends here
