;; Version control management
(use-package magit
  :bind (("C-c g g" . magit-status)
	 :map magit-mode-map
	 ;; evil uniformisation
	 ([remap magit-log] . evil-forward-char)
	 ([remap magit-dispatch] . evil-backward-char)
	 ([remap magit-ediff-dwim] . evil-forward-word-end)
	 ([remap magit-branch] . evil-backward-word-begin)
	 ([remap magit-jump-to-tracked] . evil-tab-next)
	 ;; ("gT" . tab-bar-switch-to-prev-tab)
	 )
  :config
  ;; Clean keybindings
  (require 'bind-key)
  (unbind-key "M-1" magit-section-mode-map)
  (unbind-key "M-2" magit-section-mode-map)
  (unbind-key "M-3" magit-section-mode-map)
  (unbind-key "M-4" magit-section-mode-map)
  )

;; Issue creation/interaction
(use-package forge
  :bind
  (("C-c g a" . forge-add-repository)
  ("C-c g p i" . forge-pull)
  ("C-c g c i" . forge-create-issue)
  ("C-c g c p" . forge-create-post)
  ("C-c g l i" . forge-list-issues)
  ("C-c g l r" . forge-list-repository)
  :map forge-issue-mode-map
  ("gt" . evil-tab-next)
  ("gT" . tab-bar-switch-to-prev-tab)
  )
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


;; Keybindings
(use-package magit
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "g"  '(:ignore t :which-key "Git")
    "gs"  '(magit-status :which-key "Status")
    "ga"  '(forge-add-repository :which-key "Add repository")
    "gpi" '(forge-pull :which-key "Pull Issues")
    "gc" '(:ignore t :which-key "Create")
    "gci" '(forge-create-issue :which-key "Issue")
    "gcp" '(forge-create-post :which-key "Post")
    "gc" '(:ignore t :which-key "List")
    "gli" '(forge-list-issues :which-key "Issues")
    "glr" '(forge-list-repository :which-key "Repositories"))
  )


(provide 'version-control-module)
