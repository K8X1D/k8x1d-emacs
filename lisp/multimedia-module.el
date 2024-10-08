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
  (setq emms-player-list '(emms-player-mpd))
  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600")
  (setq emms-player-mpd-music-directory "~/Music")
  (emms-player-mpd-connect)
  )

;; MPV interface
(use-package ready-player
  :hook
  (after-init . ready-player-mode))

(provide 'multimedia-module)
