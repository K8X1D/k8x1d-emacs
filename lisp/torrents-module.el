;; -*- lexical-binding: t -*-

(use-package transmission
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "oT"  '(transmission :which-key "Torrents")
    )
  :bind
   ("C-c o T" . transmission)
  :config
  (setq transmission-refresh-modes '(transmission-mode
                                     transmission-files-mode
                                     transmission-info-mode
                                     transmission-peers-mode)))


(provide 'torrents-module)
