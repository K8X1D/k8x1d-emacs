;;; package --- Summary

;;; Commentary:

;;; Code:


;; Open interactive REPL 
(setq geiser-scheme-implementation 'guile)
(defun k8x1d/dwl-guile-repl ()
  (interactive)
  (require 'geiser)
  (require 'geiser-repl)
  (geiser-repl--start-repl 'guile "/tmp/dwl-guile.socket")
    (evil-window-move-very-bottom)
    (evil-window-set-height 16)
  ;; (geiser-connect-local geiser-guile-binary "/tmp/dwl-guile.socket")
  )


(provide 'dwl-guile-module)
;;; dwl-guile-module.el ends here
