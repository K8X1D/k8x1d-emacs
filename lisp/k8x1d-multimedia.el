;; Multimedia player
;; (use-package emms
;;   :defer t
;;   ;;:hook
;;   ;;(after-init . (lambda () 
;;   ;;(emms-player-mpd-connect)))
;;   :bind
;;   (("<XF86AudioPrev>" . emms-player-mpd-prev)
;;    ("<XF86AudioNext>" . emms-player-mpd-next)
;;    ("<XF86AudioPlay>" . emms-player-mpd-pause))
;;   :config
;;   ;;(emms-minimalistic)
;;   (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
;;   (setq emms-info-functions '(emms-info-native))
;;   (setq emms-player-list '())

;;   ;; Music player config
;;   (setq emms-source-file-default-directory "~/Music/") ;; Change to your music folder
;;   (setq emms-info-tinytag-python-name "python3")
;;   (setq emms-info-functions '(emms-info-tinytag))  ;; When using Tinytag
;;   ;; Load cover images
;;   (setq emms-browser-covers 'emms-browser-cache-thumbnail-async)

;;   ;; Mpd interactions
;;   (require 'emms-setup)
;;   (require 'emms-player-mpd)
;;   (add-to-list 'emms-info-functions 'emms-info-mpd)
;;   (add-to-list 'emms-player-list 'emms-player-mpd)
;;   ;; Socket is not supported
;;   (setq emms-player-mpd-server-name "localhost")
;;   (setq emms-player-mpd-server-port "6600")
;;   (setq emms-player-mpd-music-directory "~/Music/")

;;   ;; Video player config
;;   (add-to-list 'emms-player-list 'emms-player-mpv)
;;   (setq emms-player-mpv-parameters '("--sub-auto=all" ))
;;   )


(use-package bluetooth
  :general
  (k8x1d/leader-keys
    "ob" '(bluetooth-list-devices :which-key "Bluetooth"))
  :defer t)

(use-package mpv
  :defer t)

(use-package mpdel
  :defer t
  ;;:init
  ;;(setq mpdel-prefix-key (kbd "C-c m"))
  :general
  (k8x1d/leader-keys
    "om" '(mpdel-core-map :which-key "Music Player"))
  :hook (after-init . mpdel-mode))


(use-package transmission
  :general
  (k8x1d/leader-keys
    "oT" '(transmission :which-key "Transmission")))
  ;;:bind ("C-c o T" . transmission))


(provide 'k8x1d-multimedia)
