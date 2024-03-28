;; Version control management
(use-package magit
  :bind (("C-c g g" . magit-status)))

;; Issue creation/interaction
(use-package forge
  :bind
  (("C-c g a" . forge-add-repository)
  ("C-c g p i" . forge-pull)
  ("C-c g c i" . forge-create-issue)
  ("C-c g c p" . forge-create-post)
  ("C-c g l i" . forge-list-issues)
  ("C-c g l r" . forge-list-repository))
  :config
  ;; (add-to-list 'forge-alist '("gitlab.cirst.ca" "gitlab.cirst.ca/api/v4" "gitlab.cirst.ca:8822" forge-gitlab-repository))
  (add-to-list 'forge-alist '("gitlab.cirst.ca" "gitlab.cirst.ca/api/v4" "gitlab.cirst.ca" forge-gitlab-repository)) 
  (setq auth-sources '("~/.authinfo.gpg"))
  )
;; ssh://git@gitlab.cirst.ca:8822/bin-phun/ofdig.git
;; ssh://gitlab.cirst.ca:8822/

;; List todo in magit buffer
(use-package magit-todos
  :after magit
  :hook (magit-mode . magit-todos-mode)
  )

;; Evil compatibility
(use-package magit
  :config
  :hook (git-commit-mode . evil-insert-state)
  )

(provide 'version-control-module)
