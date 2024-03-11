
(use-package transmission
  :bind
  ("C-c o T" . transmission)
  :config
  (setq transmission-refresh-modes '(transmission-mode transmission-files-mode transmission-info-mode transmission-peers-mode)))

(provide 'torrents-module)
