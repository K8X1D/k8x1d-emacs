;;; package --- Summary
;;; Commentary:

;;; Code:
(use-package project
  
  :config
  ;; Expand project root identification, see https://blog.jmthornton.net/p/emacs-project-override
  (setq project-vc-extra-root-markers '(".project.el" ".projectile" ))
  (add-to-list 'project-switch-commands '(eat-project-other-window "Terminal")) ;; add terminal to option list when switching project

  ;; Prettify compilation buffer
  ;; https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
  (require 'ansi-color)
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  )

;; Enhance compilation buffer
(use-package fancy-compilation
  
  :commands (fancy-compilation-mode)
  :config
  (with-eval-after-load 'compile
    (fancy-compilation-mode)))


(provide 'project-module)
;;; project-module.el ends here
