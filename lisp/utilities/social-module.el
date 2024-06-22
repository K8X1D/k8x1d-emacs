
;; Mastodon interaction
(use-package mastodon
  :init
  (setq browse-url-browser-function 'browse-url-firefox)
  ;; (setq browse-url-browser-function 'browse-url-nyxt)
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
