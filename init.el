(setq k8x1d/bibliography '("~/Zotero/k8x1d.bib"))

(setq k8x1d/org-directory "~/Nextcloud/facil/Org")
(setq org-directory "~/Nextcloud/facil/Org")

(setq k8x1d/org-files
      '("~/Nextcloud/facil/Org/projects/implications.org"
        "~/Nextcloud/facil/Org/projects/bin.org"    
        "~/Nextcloud/facil/Org/projects/doctorat.org"  
        "~/Nextcloud/facil/Org/projects/developpements.org"
        "~/Nextcloud/facil/Org/projects/articles.org"  
        "~/Nextcloud/facil/Org/projects/financements.org"  
        "~/Nextcloud/facil/Org/projects/administratifs.org"
        "~/Nextcloud/facil/Org/projects/machines.org"
        "~/Nextcloud/facil/Org/projects/evocult.org"
        "~/Nextcloud/facil/Org/projects/contrats.org"
        "~/Nextcloud/facil/Org/projects/presentations.org"
        "~/Nextcloud/facil/Org/Horaire.org"
        "~/Nextcloud/facil/Org/Inbox.org"
        "~/Nextcloud/facil/Org/Habits.org"))

(defvar k8x1d/lsp-backend "eglot")
;; (defvar k8x1d/lsp-backend "lsp-bridge")
(defvar k8x1d/ide "minimal")
(defvar k8x1d/terminal "vterm")
(defvar k8x1d/completion "corfu")
(defvar k8x1d/posframe-support nil)

(require 'tools-module)

(require 'packages-module)
(require 'evil-module)

(require 'buffer-module)
(require 'workspaces-module)
(require 'file-browser-module)
(require 'scrolling-module)
(require 'daemon-module)

(require 'fonts-module)
(require 'theme-module)
(require 'modeline-module)

(require 'completion-module)
(require 'icons-module)
(require 'highlight-module)
(require 'workspaces-management-module)
(require 'documentation-module)

(require 'keybindings-module)

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

(require 'julia-module)
(require 'python-module)
(require 'r-module)
(require 'scheme-module)
(require 'sql-module)

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

(require 'org-gui-module)
(require 'org-writing-module)
(require 'org-agenda-module)
(require 'org-management-module)

(require 'pubmed-module)
(require 'social-module)
