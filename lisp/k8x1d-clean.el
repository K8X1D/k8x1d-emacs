;; -*- lexical-binding: t; -*-

(use-package emacs
  :config
  ;; Backup files
  (setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-cache-directory))))

  ;; auto-save-mode doesn't create the path automatically!
  (make-directory (expand-file-name "tmp/auto-saves/" user-emacs-cache-directory) t)

  (setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-cache-directory)
	auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-cache-directory) t)))

  ;; Custom file location
  (setq custom-file (concat user-emacs-cache-directory "/custom.el"))
  )


(provide 'k8x1d-clean)
