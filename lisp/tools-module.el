

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


(provide 'tools-module)
