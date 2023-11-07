;;; package --- Summary

;;; Commentary:

;;; Code:

;; Pass interation
(use-package pass
  :bind
  (("M-g p" . +pass/consult)
   ("C-c o p" . pass))
  :config
  ;; From https://github.com/doomemacs/doomemacs/blob/master/modules/tools/pass/autoload/consult.el
  (defun +pass/consult (arg pass)
    "Get pass password through consult"
    (interactive
     (list current-prefix-arg
	   (progn
	     (require 'consult)
	     (require 'pass)
	     (consult--read (password-store-list)
			    :prompt "Pass: "
			    :sort nil
			    :require-match t
			    :category 'pass))))
    (funcall (if arg
		 #'password-store-url
	       #'password-store-copy)
	     pass))
  )

(provide 'password-module)
;;; password-module.el ends here
