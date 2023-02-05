;; Inspirations:
;; - https://github.com/SystemCrafters/crafted-emacs/blob/master/bootstrap/crafted-package-bootstrap.el

;;
;; Package set-up
;;

;; Load required modules
(require 'package)

;; Set repos
(add-to-list 'package-archives '("stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities
                        '(("gnu"    . 80)   ; prefer GNU packages
                          ("nongnu" . 70)   ; use non-gnu packages if
                                            ; not found in GNU elpa
                          ("stable" . 90)   ; prefer "released" versions
                                            ; from melpa
                          ("melpa"  . 0)))  ; if all else fails, get it
                                            ; from melpa

;; Not sure if necessary...
;;(when (not package-archive-contents)
;;    (package-refresh-contents))

;; Ensure package is installed
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(provide 'packages-module)
