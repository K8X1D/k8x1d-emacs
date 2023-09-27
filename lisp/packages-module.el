;;; package --- Summary

;;; Commentary:

;;; Code:

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; (customize-set-variable 'package-archive-priorities
;;                         '(("gnu"    . 99)   ; prefer GNU packages
;;                           ("nongnu" . 80)   ; use non-gnu packages if
;;                                             ; not found in GNU elpa
;;                           ("stable" . 70)   ; prefer "released" versions
;;                                             ; from melpa
;;                           ("melpa"  . 0)))  ; if all else fails, get it
;;                                             ; from melpa
(when package-enable-at-startup
  (package-initialize))

(unless package-archive-contents
  (package-refresh-contents))

(use-package use-package
  :config
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (setq use-package-enable-imenu-support t)
  )

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

(provide 'packages-module)
;;; packages-module.el ends here
