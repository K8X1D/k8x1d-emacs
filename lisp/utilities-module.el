;;; package --- Summary

;;; Commentary:

;;; Code:
(defun k8x1d/kill-buffer-and-window ()
  (interactive)
  (kill-buffer)
  (if (> (length (window-list)) 1)
      (delete-window)))


;; From https://www.emacswiki.org/emacs/EmacsAsDaemon
(defun k8x1d/server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

;; Opacity
(defun k8x1d/set-frame-opacity (opacity)
  "Interactively change the current frame's opacity (v29 pgtk version).

OPACITY is an integer between 0 to 100, inclusive."
  (interactive
   (list (read-number "Opacity (0-100): "
                      (or (frame-parameter nil 'alpha)
                          100))))
  (if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
      (set-frame-parameter nil 'alpha-background opacity)
    (set-frame-parameter nil 'alpha opacity)))




(provide 'utilities-module)
;;; utilities-module.el ends here
