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

(require 'packages-module)
(require 'evil-module)

(require 'buffer-module)
(require 'workspaces-module)
(require 'file-browser-module)

(require 'fonts-module)
(require 'theme-module)
(require 'modeline-module)

(require 'completion-module)
(require 'icons-module)
(require 'highlight-module)

(require 'keybindings-module)

(require 'prog-module)
(require 'tree-sitter-module)
(require 'sidebar-module)
(require 'checker-module)
(require 'snippets-module)
(provide 'version-control-module)
(require 'julia-module)
(require 'python-module)
(require 'r-module)

(require 'terminal-module)
(require 'password-module)
(require 'pdf-module)
(require 'remote-module)
(require 'notes-module)
(require 'bibliography-module)

(require 'org-gui-module)
(require 'org-writing-module)
(require 'org-agenda-module)
(require 'org-management-module)
