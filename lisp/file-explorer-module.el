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
  (setq dired-dwim-target t) ;; Allow dired tries to guess a default target directory, see https://emacs.stackexchange.com/questions/5603/how-to-quickly-copy-move-file-in-emacs-dired
  )


(use-package dired-sidebar
  :bind
  (:map project-prefix-map
	;; ("e" . +sidebar-toggle))
	("e" . dired-sidebar-toggle-sidebar))
  :hook (dired-sidebar-mode . (lambda ()
				(unless (file-remote-p default-directory)
				  (auto-revert-mode)))) ;; Do not autorevert when tramp connection
  )


(provide 'file-explorer-module)
