;; Interaction with mpd
(use-package mpdel
  :custom
  (mpdel-prefix-key (kbd "C-c o m"))
  :hook (after-init . mpdel-mode)
  :config
  (setq libmpdel-port 6600)
  (setq libmpdel-hostname "0.0.0.0")
  )


;; Embark support
(use-package mpdel-embark
  :after (embark mpdel)
  :config
  (progn
    (mpdel-embark-setup)))

;; Video
(use-package empv
  :bind-keymap ("C-c o v" . empv-map)
  ;; :init
  ;; (bind-key "C-c o v" empv-map)
  :config
  (setq empv-invidious-instance "https://invidious.flokinet.to/api/v1")
  (setq empv-youtube-use-tabulated-results t)
  ;; Mpv options
  (add-to-list 'empv-mpv-args "--ytdl-format=best")
  (add-to-list 'empv-mpv-args "--script=$K8X1D_EMACS_PROFILE/$XDG_SESSION_TYPE/$XDG_SESSION_TYPE/lib/mpris.so")
  (add-to-list 'empv-mpv-args "--sub-auto=all")
  )


;; Keybindings
(use-package mpdel 
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "om" '(:keymap mpdel-core-map
		  :package mpdel 
		  :which-key "MPD")
   )
  )

(use-package empv 
  :if k8x1d/use-general-keybindings
  :general
  (k8x1d/leader-keys
   "o"  '(:ignore t :which-key "Open")
   "ov" '(:keymap empv-map
		  :package empv
		  :which-key "MPV")
   )
  )

(provide 'multimedia-module)
