


;; Pass interation
(use-package pass
  :general
  (k8x1d/leader-keys
    "q"  '(:ignore t :which-key "Query")
    "qp"  '(+pass/consult :which-key "Password-store")
    "op"  '(pass :which-key "Pass"))
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
  ;;:bind ("C-c o p" . +pass/consult))

(use-package password-store
  :defer t)

(use-package password-store-otp
  :defer t)


(provide 'k8x1d-password)
