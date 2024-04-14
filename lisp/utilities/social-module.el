
;; Mastodon interaction
(use-package mastodon
  :init
  (setq browse-url-browser-function 'browse-url-firefox)
  :bind ("C-c o M" ("Mastodon" . mastodon))
  :config
  (setq mastodon-instance-url "https://mastodon.online"
	mastodon-active-user "k8x1d")
  (mastodon-discover)
  )

(provide 'social-module)
