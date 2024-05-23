(setq k8x1d/bibliography '("~/Zotero/k8x1d.bib"))

(setq k8x1d/org-directory "~/org")
(setq org-directory "~/org")
(setq k8x1d/denote-directory (concat k8x1d/org-directory "/notes"))

(setq k8x1d/org-files
      '("~/org/projects/implications.org"
        "~/org/projects/bin.org"    
        "~/org/projects/doctorat.org"  
        "~/org/projects/developpements.org"
        "~/org/projects/articles.org"  
        "~/org/projects/financements.org"  
        "~/org/projects/administratifs.org"
        "~/org/projects/machines.org"
        "~/org/projects/evocult.org"
        "~/org/projects/recherches.org"
        "~/org/projects/contrats.org"
        "~/org/projects/presentations.org"
        ;; "~/org/Horaire.org"
        "~/org/Inbox.org"
        "~/org/Habits.org"))

(defvar k8x1d/lsp-backend "eglot")
;; (defvar k8x1d/lsp-backend "lsp-bridge")
(defvar k8x1d/ide "minimal")
(defvar k8x1d/terminal "vterm")
(defvar k8x1d/completion "corfu")
;; FIXME To correct
(defvar k8x1d/tabs t)
(defvar k8x1d/posframe-support nil)
(defvar k8x1d/use-general-keybindings t)
(defvar k8x1d/use-general-keybindings t)
;; Theme
(defvar k8x1d/default-emacs-dark-theme 'doom-palenight)
(defvar k8x1d/default-emacs-light-theme 'doom-one-light)
(defvar k8x1d/default-dark-theme "Breeze-Dark")
(defvar k8x1d/default-light-theme "Breeze")
(defvar k8x1d/package-management "guix")

;;
;; Loaded modules
;;

(if (string= k8x1d/package-management "guix")
    (require 'packages-module)
  (require 'straight-module)
  )

(require 'tools-module)

(require 'keybindings-module)
(require 'evil-module)

(require 'frames-module)
(require 'buffer-module)
;; (require 'tabs-module)
(require 'tabs-alt-module)
(require 'minibuffer-module)
(require 'project-module)
(require 'file-browser-module)
(require 'scrolling-module)
(require 'daemon-module)

(require 'fonts-module)
(require 'theme-module)
(require 'modeline-module)

(require 'completion-module)
(require 'icons-module)
(require 'highlight-module)
;; (require 'workspaces-management-module)
(require 'documentation-module)


(require 'prog-module)
(require 'tree-sitter-module)
(require 'lsp-module)
(require 'sidebar-module)
(require 'checker-module)
(require 'snippets-module)
(require 'version-control-module)
(require 'environment-management-module)
(require 'compilation-module)
(require 'notebook-module)
(require 'breadcrumb-module)

(require 'julia-module)
(require 'python-module)
(require 'r-module)
(require 'php-module)
(require 'scheme-module)
(require 'elisp-module)
(require 'sql-module)
(require 'shell-module)
(require 'lua-module)
(require 'fennel-module)

(require 'terminal-module)
(require 'password-module)
(require 'pdf-module)
(require 'remote-module)
(require 'notes-module)
(require 'bibliography-module)
(require 'multimedia-module)
(require 'guix-module)
(require 'process-management-module)
(require 'bluetooth-module)
(require 'gnupg-module)
(require 'torrents-module)
(require 'k8x1d-emacs-management-module)

(require 'text-module)
(require 'markdown-module)
(require 'csv-module)
(require 'latex-module)
(require 'corrector-module)

(require 'org-gui-module)
(require 'org-writing-module)
(require 'org-agenda-module)
(require 'org-management-module)
(require 'todo-txt-module)
(require 'denote-module)

(require 'pubmed-module)
(require 'social-module)
