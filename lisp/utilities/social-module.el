
;; Mastodon interaction
(use-package mastodon
  :init
  :bind ("C-c o M" ("Mastodon" . mastodon))
  :config
  (setq mastodon-instance-url "https://mastodon.online"
	mastodon-active-user "k8x1d")
  (mastodon-discover)
  )

(use-package mastodon
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "oM"  '(mastodon :which-key "Mastodon")
    )
  )

(provide 'social-module)
