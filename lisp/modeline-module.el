;;; package --- Summary

;;; Commentary:

;;; Code:


;; Modeline
(use-package breadcrumb)
(use-package emacs
  :init
  (defun simple-mode-line-render (left right)
    "Return a string of `window-width' length.
Containing LEFT, and RIGHT aligned respectively."
    (let ((available-width
	   (- (window-total-width)
	      (+ (length (format-mode-line left))
		 (length (format-mode-line right))))))
      (append left
	      (list (format (format "%%%ds" available-width) ""))
	      right)))
  :config
  (setq-default
   mode-line-format
   '((:eval
      (simple-mode-line-render
       ;; Left.
       (quote ("%e "
	       evil-mode-line-tag
	       " "
	       (:eval (breadcrumb-project-crumbs))
	       (vc-mode vc-mode)
	       " [%l:%c]"
	       ))
       ;;
       ;; Right.
       (quote (
	       " "
	       mode-line-frame-identification
	       mode-line-misc-info
	       ;; (:eval flymake-mode-line-counter-format)
	       mode-line-modes
	       ))))))
  )

(use-package minions
  :hook (after-init . minions-mode)
  :init
  (setq minions-mode-line-lighter "...")
  )

(use-package hide-mode-line
  :hook
  ((vterm-mode . hide-mode-line-mode)
   (dired-sidebar-mode . hide-mode-line-mode)
   (inferior-ess-r-mode . hide-mode-line-mode)
   (org-capture-mode . hide-mode-line-mode)
   (eat-mode . hide-mode-line-mode)
   (treemacs-mode . hide-mode-line-mode)
   ;; (dashboard-mode . hide-mode-line-mode)
   (compilation-mode . hide-mode-line-mode)
   (geiser-repl-mode . hide-mode-line-mode)
   (inferior-python-mode . hide-mode-line-mode)
   (julia-vterm-repl-mode . hide-mode-line-mode)
   ;; (special-mode . hide-mode-line-mode)
   (pdf-view-mode . hide-mode-line-mode))
  )


(provide 'modeline-module)
;;; modeline-module.el ends here
