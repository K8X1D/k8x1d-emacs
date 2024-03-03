;; Interaction with mpd
(use-package mpdel
  :custom
  (mpdel-prefix-key (kbd "C-c o m"))
  :hook (after-init . mpdel-mode))


;; Embark support
(use-package mpdel-embark
  :after (embark mpdel)
  :config
  (progn
    (mpdel-embark-setup)))


(provide 'multimedia-module)
