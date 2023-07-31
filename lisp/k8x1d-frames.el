;; -*- lexical-binding: t; -*-

(use-package emacs
  :config
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



