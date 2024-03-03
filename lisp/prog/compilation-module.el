;; Prettify compilation buffer
;; - inspiration: https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer

;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (let ((inhibit-read-only t))
;;     (ansi-color-apply-on-region (point-min) (point-max))))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; In test
(use-package fancy-compilation
  :commands (fancy-compilation-mode)
  :config
  (with-eval-after-load 'compile
    (fancy-compilation-mode)))


(provide 'compilation-module)
