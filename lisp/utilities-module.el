;;; package --- Summary

;;; Commentary:

;;; Code:
(defun k8x1d/kill-buffer-and-window ()
  (interactive)
  (kill-buffer)
  (if (> (length (window-list)) 1)
      (delete-window)))


(provide 'utilities-module)
;;; utilities-module.el ends here
