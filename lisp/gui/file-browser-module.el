
;; Native file-explorer
(use-package emacs
  :ensure nil
  :config
  (setq dired-auto-revert-buffer t)
  (setq dired-guess-shell-alist-user '(("\\.docx\\'" "libreoffice")
				       ("\\.xlsx\\'" "libreoffice")
				       ("\\.odt\\'" "libreoffice")
				       ("\\.ods\\'" "libreoffice")
				       ("\\.csv\\'" "libreoffice")
				       ("\\.tsv\\'" "libreoffice")
				       ("\\.rtf\\'" "libreoffice")
				       ("\\.mp4\\'" "mpv")
				       ("\\.mkv\\'" "mpv")
				       ("\\.webm\\'" "mpv")
				       ("\\.pdf\\'" "okular")
				       ("\\.html\\'" "firefox")
				       ))
  )

(use-package dired-posframe
  :if k8x1d/posframe-support
  :hook (dired-mode . dired-posframe-mode))


(provide 'file-browser-module)
