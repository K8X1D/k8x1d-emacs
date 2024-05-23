
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

;; Preview files
(use-package dired-preview
  :config
  ;; Default values for demo purposes
  (setq dired-preview-delay 0.7)
  (setq dired-preview-max-size (expt 2 20))
  (setq dired-preview-ignored-extensions-regexp
	(concat
	 ;; "\\."
		"\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
		"\\|gz\\|zst\\|tar\\|xz\\|rar\\|zip"
		"\\|iso\\|epub\\)"))

  :hook (dired-mode . dired-preview-mode))


(use-package dired-posframe
  :if k8x1d/posframe-support
  :hook (dired-mode . dired-posframe-mode))


(provide 'file-browser-module)
