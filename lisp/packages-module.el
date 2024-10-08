;; -*- lexical-binding: t -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package package
  :ensure nil
  :if (string= k8x1d/package-manager "package.el")
  ;; :init
  ;; Ensure use-package is available at compile time
  ;; (eval-when-compile
  ;; 	(require 'use-package))
  ;; (setq use-package-always-ensure t)
  ;; (setq use-package-always-defer t)
  ;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
  ;; 			       ("melpa-stable" . "https://stable.melpa.org/packages/")
  ;; 			       ("gnu" . "https://elpa.gnu.org/packages/")
  ;; 			       ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  ;; (customize-set-variable 'package-archive-priorities '(("gnu"    . 99)
  ;; 							    ("nongnu" . 80)
  ;; 							    ("stable" . 70)
  ;; 							    ("melpa"  . 0)))
  ;; :config
  ;; (setq use-package-enable-imenu-support t)
  ;; (setq use-package-compute-statistics t)
  :custom
  (package-archives '(("melpa" . "https://melpa.org/packages/")
		      ("melpa-stable" . "https://stable.melpa.org/packages/")
		      ("gnu" . "https://elpa.gnu.org/packages/")
		      ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (package-archive-priorities '(("gnu"    . 99)
				("nongnu" . 80)
				("stable" . 70)
				("melpa"  . 0)))
  :init
  (setq package-enable-at-startup t)
  (setq package-quickstart t)
  )

;; (package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))

;;; Use package
(use-package use-package-core
  :ensure nil
  :config
  (setq use-package-enable-imenu-support t)
  (setq use-package-compute-statistics t)
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  )


;; Add :diminish keyword to use-package
(use-package diminish)
(use-package general)



(if (string= k8x1d/package-manager "elpaca")
    (progn
      (defvar elpaca-installer-version 0.7)
      (defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
      (defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
      (defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
      (defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
				    :ref nil :depth 1
				    :files (:defaults "elpaca-test.el" (:exclude "extensions"))
				    :build (:not elpaca--activate-package)))
      (let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
	     (build (expand-file-name "elpaca/" elpaca-builds-directory))
	     (order (cdr elpaca-order))
	     (default-directory repo))
	(add-to-list 'load-path (if (file-exists-p build) build repo))
	(unless (file-exists-p repo)
	  (make-directory repo t)
	  (when (< emacs-major-version 28) (require 'subr-x))
	  (condition-case-unless-debug err
	      (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
		       ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
						       ,@(when-let ((depth (plist-get order :depth)))
							   (list (format "--depth=%d" depth) "--no-single-branch"))
						       ,(plist-get order :repo) ,repo))))
		       ((zerop (call-process "git" nil buffer t "checkout"
					     (or (plist-get order :ref) "--"))))
		       (emacs (concat invocation-directory invocation-name))
		       ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
					     "--eval" "(byte-recompile-directory \".\" 0 'force)")))
		       ((require 'elpaca))
		       ((elpaca-generate-autoloads "elpaca" repo)))
		  (progn (message "%s" (buffer-string)) (kill-buffer buffer))
		(error "%s" (with-current-buffer buffer (buffer-string))))
	    ((error) (warn "%s" err) (delete-directory repo 'recursive))))
	(unless (require 'elpaca-autoloads nil t)
	  (require 'elpaca)
	  (elpaca-generate-autoloads "elpaca" repo)
	  (load "./elpaca-autoloads")))
      (add-hook 'after-init-hook #'elpaca-process-queues)
      (elpaca `(,@elpaca-order))

      ;; Install use-package support
      (elpaca elpaca-use-package
	;; Enable use-package :ensure support for Elpaca.
	(elpaca-use-package-mode))
      (elpaca diminish)
      (elpaca general)
      ;; Load custom.el
      (add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))
      )
  )


(provide 'packages-module)
