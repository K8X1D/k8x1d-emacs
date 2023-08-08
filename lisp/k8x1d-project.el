

;;
;; Project management
;;
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))
;; Project
(use-package project
  :general 
  (k8x1d/leader-keys
   "p" '(:keymap project-prefix-map
		 :which-key "Project"))
  (k8x1d/leader-keys
    "po" '(:ignore t :which-key "Open")
   )
  :config
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
  (require 'ansi-color)
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  )




(provide 'k8x1d-project)
