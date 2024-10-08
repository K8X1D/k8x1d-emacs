;; -*- lexical-binding: t -*-

;; Mastodon interaction
(use-package mastodon
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "oM"  '(mastodon :which-key "Mastodon")
    )
  :bind ("C-c o M"  . mastodon)
  :config
  (setq mastodon-instance-url "https://mastodon.online"
	mastodon-active-user "k8x1d")
  (mastodon-discover)
  )

(provide 'social-module)
