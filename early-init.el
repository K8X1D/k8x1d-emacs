;; Print loading time
;; From https://tychoish.com/post/towards-faster-emacs-start-times/
(defmacro with-timer (name &rest body)
  `(let ((time (current-time)))
     ,@body
     (message "%s: %.06f" ,name (float-time (time-since time)))))

(with-timer "early-init.el setup"
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Simplify ui
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; (menu-bar-mode -1)
	    (tool-bar-mode -1)             ; Hide the outdated icons
	    (scroll-bar-mode -1)           ; Hide the always-visible scrollbar
	    ;; (menu-bar-mode -1)             ; Hide menu-bar
	    (setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
	    (setq use-file-dialog nil)     ; Ask for textual confirmation instead of GUI
	    (setq use-dialog-box nil)      ; Remove dialog box
	    (setq use-short-answers t)     ; y-or-p insteat of yes-or-no

	    ;; Remove ui element from default-frame
	    (push '(menu-bar-lines . 0) default-frame-alist)
	    (push '(tool-bar-lines . 0) default-frame-alist)
	    (push '(vertical-scroll-bars) default-frame-alist)


;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Speed startup
;;;;;;;;;;;;;;;;;;;;;;;;
	    (setq gc-cons-threshold most-positive-fixnum) ;; Increase gc threshold at start
	    (add-hook 'emacs-startup-hook
		      (lambda ()
			(setq gc-cons-threshold (* 16 1024 1024))))  ;; Decrease gc threshold after start



;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Increase performance
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; from minimal emacs https://github.com/jamescherti/minimal-emacs.d

	    (setq load-prefer-newer t) ;; Prefer loading newer compiled files
	    (setq read-process-output-max (* 512 1024))  ;; Increase how much is read from processes in a single chunk (default is 4kb).
	    ;; Reduce rendering/line scan work by not rendering cursors or regions in non-focused windows.
	    (setq-default cursor-in-non-selected-windows nil)
	    (setq highlight-nonselected-windows nil)

	    ;; Disable warnings from the legacy advice API. They aren't useful.
	    (setq ad-redefinition-action 'accept)
	    (setq warning-suppress-types '((lexical-binding)))

	    (setq ffap-machine-p-known 'reject) ;; Don't ping things that look like domain names.
	    (setq idle-update-delay 1.0) ;; By default, Emacs "updates" its ui more often than it needs to
	    ;; Font compacting can be very resource-intensive, especially when rendering
	    ;; icon fonts on Windows. This will increase memory usage.
	    (setq inhibit-compacting-font-caches t)

;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Set initial theme
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; (load-theme 'modus-vivendi t)

	    ;; Prevent inital white flash
	    (add-to-list 'default-frame-alist
			 '(background-color . "#17191a")
			 '(foreground-color . "#ffffff"))

;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Load path
;;;;;;;;;;;;;;;;;;;;;;;;
	    (add-to-list 'load-path (concat user-emacs-directory "lisp"))

;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Backup files management
;;;;;;;;;;;;;;;;;;;;;;;;

	    ;; Avoid generating backups or lockfiles to prevent creating world-readable
	    ;; copies of files.
	    (setq create-lockfiles nil)
	    (setq make-backup-files nil)

	    (setq backup-directory-alist
		  `(("." . ,(expand-file-name "backup" user-emacs-directory))))
	    (setq tramp-backup-directory-alist backup-directory-alist)
	    (setq backup-by-copying-when-linked t)
	    (setq backup-by-copying t)  ; Backup by copying rather renaming
	    (setq delete-old-versions t)  ; Delete excess backup versions silently
	    (setq version-control t)  ; Use version numbers for backup files
	    (setq kept-new-versions 5)
	    (setq kept-old-versions 5)
	    (setq vc-make-backup-files nil)  ; Do not backup version controlled files


;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Recentf
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; `recentf' is an Emacs package that maintains a list of recently
	    ;; accessed files, making it easier to reopen files you have worked on
	    ;; recently.
	    (setq recentf-max-saved-items 300) ; default is 20
	    (setq recentf-auto-cleanup 'mode)

;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; saveplace
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; `save-place-mode` enables Emacs to remember the last location within a file
	    ;; upon reopening. This feature is particularly beneficial for resuming work at
	    ;; the precise point where you previously left off.
	    (setq save-place-file (expand-file-name "saveplace" user-emacs-directory))
	    (setq save-place-limit 600)

;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; savehist
;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; `savehist` is an Emacs feature that preserves the minibuffer history between
	    ;; sessions. It saves the history of inputs in the minibuffer, such as commands,
	    ;; search strings, and other prompts, to a file. This allows users to retain
	    ;; their minibuffer history across Emacs restarts.
	    (setq history-length 300)
	    (setq savehist-save-minibuffer-history t)  ;; Default


;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Initial frame parameters
;;;;;;;;;;;;;;;;;;;;;;;;
	    (set-frame-parameter nil 'alpha-background 80) ;; initial transparency For current frame
	    (add-to-list 'default-frame-alist '(alpha-background . 80)) ;; initial transparency for all new frames henceforth

	    ;;;;;;;;;;;;;;;;;;;;
	    ;; Disable package.el by default
	    ;;;;;;;;;;;;;;;;;;;
	    (setq package-enable-at-startup t)


;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Initial variables
;;;;;;;;;;;;;;;;;;;;;;;;
	    (setenv "LSP_USE_PLISTS" "true") ;; lsp plist
	    (setenv "CC" "~/.config/emacs-guix/guix/emacs-profile/bin/gcc") ;; vterm compilation

;;;;;;;;;;;;;;;;;;;;;;;;
	    ;; Custom file
;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (expand-file-name "customs.el" user-emacs-directory))


	    )
