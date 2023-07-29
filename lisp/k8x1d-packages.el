;;; lisp/k8x1d-packages.el -*- lexical-binding: t; -*-

;;;;;; Install straight.el
;;(defvar bootstrap-version)
;;(let ((bootstrap-file
;;       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;      (bootstrap-version 6))
;;  (unless (file-exists-p bootstrap-file)
;;    (with-current-buffer
;;        (url-retrieve-synchronously
;;         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
;;         'silent 'inhibit-cookies)
;;      (goto-char (point-max))
;;      (eval-print-last-sexp)))
;;  (load bootstrap-file nil 'nomessage))
;;
;;;; Configure use-package to use straight.el by default
;;(use-package straight
;;  :defer t)

(use-package use-package
  :config
  (setq use-package-always-defer t))



(provide 'k8x1d-packages)
