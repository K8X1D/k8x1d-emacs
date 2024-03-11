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

;; Video
(use-package empv
  :config
  (bind-key "C-c o v" empv-map)
  (setq empv-invidious-instance "https://invidious.flokinet.to/api/v1")
  (setq empv-youtube-use-tabulated-results t)
  ;; Mpv options
  (add-to-list 'empv-mpv-args "--ytdl-format=best")
  (add-to-list 'empv-mpv-args "--script=$K8X1D_EMACS_PROFILE/$XDG_SESSION_TYPE/$XDG_SESSION_TYPE/lib/mpris.so")
  (add-to-list 'empv-mpv-args "--sub-auto=all")
  )



(provide 'multimedia-module)
