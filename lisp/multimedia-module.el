;;; package --- Summary

;;; Commentary:

;;; Code:

;; Music
(use-package mpdel
  :init
  (setq mpdel-prefix-key (kbd "C-c o m"))
  :hook (after-init . mpdel-mode))

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

;; In test
;; Inspiration
;; - https://lucidmanager.org/productivity/configure-emms/
 ;; Emacs Multimedia System configuration
(use-package emms
  :init
  (require 'emms-setup)
  (require 'emms-mpris)
  (emms-all)
  (emms-default-players)
  (emms-mpris-enable)
  :custom
  (emms-source-file-default-directory "~/Music/")
  (emms-lyrics-dir "~/Music/lyrics")
  (emms-info-tinytag-python-name "python3")
  :bind
  (("<f5>" . emms-browser)
   ("<M-f5>" . emms)
   ("<AudioPrev>" . emms-previous)
   ("<AudioNext>" . emms-next)
   ("<AudioPlay>" . emms-pause))
  :config
  (setq emms-info-functions '(emms-info-tinytag))
  (setq emms-browser-covers 'emms-browser-cache-thumbnail-async)
  )

(provide 'multimedia-module)
;;; multimedia-module.el ends here
