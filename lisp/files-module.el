;; -*- lexical-binding: t -*-
(use-package files
  :ensure nil
  :init
  (setq view-read-only t)
  (setq auto-save-visited-interval 30)
  :hook
  (after-init . auto-save-visited-mode) ;; autosave to original file
  :config
  ;; Enable auto-save to safeguard against crashes or data loss. The
  ;; `recover-file' or `recover-session' functions can be used to restore
  ;; auto-saved data.
  (setq auto-save-default t)

  ;; Do not auto-disable auto-save after deleting large chunks of
  ;; text. The purpose of auto-save is to provide a failsafe, and
  ;; disabling it contradicts this objective.
  (setq auto-save-include-big-deletions t)

  (setq auto-save-list-file-prefix
	(expand-file-name "autosave/" user-emacs-directory))
  (setq tramp-auto-save-directory
	(expand-file-name "tramp-autosave/" user-emacs-directory))

  ;; Auto save options
  (setq kill-buffer-delete-auto-save-files t)
  )

(provide 'files-module)
