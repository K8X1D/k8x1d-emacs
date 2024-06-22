
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
  ;; :bind (:map dired-mode-map
		 ;; ("p" . my-dired-preview-to-the-right))
  :config
  ;; Default values for demo purposes
  (setq dired-preview-delay 10)
  (setq dired-preview-max-size (expt 2 20))
  (setq dired-preview-ignored-extensions-regexp
	(concat
	 ;; "\\."
		"\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
		"\\|gz\\|zst\\|tar\\|xz\\|rar\\|zip"
		"\\|iso\\|epub\\)"))

(defun my-dired-preview-to-the-right ()
  "My preferred `dired-preview-display-action-alist-function'."
  (interactive)
  '((display-buffer-in-side-window)
    (side . right)
    (width . 0.3)))

  ;; :hook (dired-mode . dired-preview-mode)
  )


(use-package dired-posframe
  :if k8x1d/posframe-support
  :hook (dired-mode . dired-posframe-mode))





(provide 'file-browser-module)
