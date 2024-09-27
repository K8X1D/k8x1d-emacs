;; -*- lexical-binding: t -*-
(use-package dired
  :ensure nil
  :hook
  (dired-mode . dired-hide-details-mode) ;; don't show all information at once
  (dired-mode . dired-omit-mode) ;; Don't show "." and ".." paths
  :config
  (setq dired-hide-details-hide-symlink-targets nil) ;; show symlink destination
  ;; (setq dired-listing-switches "-al") ;; in test
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
				       ("\\.pdf\\'" "zathura")
				       ("\\.html\\'" "firefox")
				       ))
  )

(provide 'file-explorer-module)
