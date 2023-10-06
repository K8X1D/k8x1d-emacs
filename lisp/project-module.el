;;; package --- Summary

;;; Commentary:

;;; Code:
(use-package project
  :config
  ;; Expand project root identification, see https://blog.jmthornton.net/p/emacs-project-override
  (setq project-vc-extra-root-markers '(".project.el" ".projectile" ))

  ;; Prettify compilation buffer
  ;; See https://www.reddit.com/r/emacs/comments/kbwkca/compile_buffer_show_weird_symbols/
  ;; See https://stackoverflow.com/questions/20663005/why-does-shell-mode-display-some-rubbish-code
  ;; Still some left over... e.g. [[K...
  ;;(require 'ansi-color)
  ;; (defun colorize-compilation-buffer ()
  ;;   (ansi-color-apply-on-region compilation-filter-start (point)))
  ;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  ;; More up to date
  ;; https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
  ;; (require 'ansi-color)
  ;; (defun colorize-compilation-buffer ()
  ;;   (let ((inhibit-read-only t))
  ;;     (ansi-color-apply-on-region (point-min) (point-max))))
  ;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  )

;; Enhance compilation buffer
;; (use-package fancy-compilation
;; :after 'compile
;; :hook (compilation-mode . fancy-compilation-mode))

(use-package fancy-compilation
  :commands (fancy-compilation-mode)
  :config
  (with-eval-after-load 'compile
    (fancy-compilation-mode)))


(provide 'project-module)
;;; project-module.el ends here
