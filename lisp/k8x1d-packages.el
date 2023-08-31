;;; package --- Summary

;;; Commentary:

;;; Code:

(setq straight-repository-branch "develop")

;; Install straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Configure use-package to use straight.el by default
(use-package straight
  :config
  (setq straight-use-package-by-default t)
  )

(use-package use-package
  :straight nil
  :config
  (setq use-package-always-defer t)
  (setq use-package-enable-imenu-support t))


;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; (unless (package-installed-p 'vc-use-package)
;;   (package-vc-install "https://github.com/slotThe/vc-use-package"))
;; (require 'vc-use-package)


(provide 'k8x1d-packages)
;;; k8x1d-packages.el ends here
