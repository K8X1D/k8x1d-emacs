;; -*- lexical-binding: t -*-


;; Music player + tag editor
(use-package emms
  :config
  (require 'emms-setup)
  (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
  (emms-mode-line-mode -1)
  )

;; Mpd interface
;; Adapted from https://emacs.stackexchange.com/questions/64532/emms-and-mpd-configuration 
(use-package emms
  :general
  (k8x1d/leader-keys
    "o"  '(:ignore t :which-key "Open")
    "om"  '(emms-smart-browse :which-key "Music Player")
    )
  :bind
  ("C-c o m" . emms-smart-browse)
  :config
  (require 'emms-player-mpd)
  ;; Ensure flac support
  (emms-player-set emms-player-mpd
		   'regex
		   (emms-player-simple-regexp
		    "m3u" "ogg" "flac" "mp3" "wav" "mod" "au" "aiff"))


  (setq emms-source-file-default-directory (expand-file-name "~/Music/"))
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600")
  (setq emms-player-mpd-music-directory "~/Music")

  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)

  (emms-player-mpd-connect)
  (add-hook 'emms-playlist-cleared-hook 'emms-player-mpd-clear)

  ;; (setq emms-player-list '(emms-player-mpd))
  (add-to-list 'emms-player-list 'emms-player-mpv t)
  (emms-player-set emms-player-mpd
		   'regex
		   (emms-player-simple-regexp
		    "m3u" "ogg" "flac" "mp3" "wav" "mod" "au" "aiff"))
  )

;; MPV interface
(use-package ready-player
  :hook
  (after-init . ready-player-mode))

(provide 'multimedia-module)
