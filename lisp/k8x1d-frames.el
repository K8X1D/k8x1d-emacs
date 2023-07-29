;; -*- lexical-binding: t; -*-

(use-package emacs
  :config
  (setq frame-resize-pixelwise t) ;; take alle the available space for window
  (setq initial-scratch-message
	";; This buffer is for notes you don't want to save, and for Lisp evaluation.\n;; If you want to create a file, visit that file with C-x C-f,\n;; then enter the text in that file's own buffer.\n")

  ;; Set initial transparency
;;;; FIXME: daemon mode lacks color, seem to use non emacs 29 config
  (if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
      (progn
	(set-frame-parameter nil 'alpha-background 80) ; For current frame
	(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth
	)
    (progn
      (set-frame-parameter (selected-frame) 'alpha '(90 . 90)) ; For current frame
      (add-to-list 'default-frame-alist '(alpha . (90 . 90))) ; For all new frames henceforth
      ))

  ;;(set-frame-parameter nil 'alpha-background 80) ; For current frame
  ;;(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth
  )

(provide 'k8x1d-frames)



