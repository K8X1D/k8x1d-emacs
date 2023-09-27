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




(provide 'multimedia-module)
;;; multimedia-module.el ends here
