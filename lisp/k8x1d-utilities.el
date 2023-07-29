;; -*- lexical-binding: t; -*-

(use-package emacs
  :config
  ;; Test if pgtk
  (defun k8x1d/test-if-pgtk ()
    (interactive)
    (if (eq window-system 'pgtk)
	(message "pgtk version in use")
      (message "non-pgtk version in use"))
    )
  ;; Set transparency of emacs
  (defun k8x1d/transparency (value)
    "Sets the transparency of the frame window. 0=transparent/100=opaque"
    (interactive "nTransparency Value 0 - 100 opaque:")
    (if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
	(set-frame-parameter (selected-frame) 'alpha-background value)
      (set-frame-parameter (selected-frame) 'alpha value)))
  )

(provide 'k8x1d-utilities)



