(use-modules (guix packages)
	     (guix git-download)
	     (guix download)
	     (guix build-system emacs)
	     ((guix licenses) #:prefix license:)
	     (gnu packages)
	     (gnu packages commencement)
	     (gnu packages emacs)
	     (gnu packages glib)
	     (gnu packages linux)
	     (gnu packages emacs-xyz)
	     (gnu packages shellutils)
	     (gnu packages python-xyz)
	     (gnu packages rust-apps)
	     (gnu packages shellutils)
	     (emacs packages melpa))

(define-public emacs-org-modern-indent
  (package
   (name "emacs-org-modern-indent")
   (version "v0.1.3")
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/jdtsmith/org-modern-indent")
             (commit version)))
       (sha256
        (base32 "0308shm58s38r4h7pj5wv5pa99ki3qxzwfrfdyvvarlchsnbsxza"))
       (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-org emacs-compat))
   (home-page "https://github.com/jdtsmith/org-modern-indent")
   (synopsis "modern block styling with org-indent ")
   (description
"Modern block styling with org-indent.")
   (license license:gpl3+)))


;; Bluetooth
;; bluetooth package from guix-channel conflicts with emacs-pass from emacs channel, ensure that newer emacs-dash is used
(define-public emacs-bluetooth-upd
  (package
   (inherit emacs-bluetooth)
   (name "emacs-bluetooth-upd")
   (propagated-inputs
    (list emacs-dash))
   ))


;; Emacs defintion
(define-public emacs-next-minimal
  (let ((commit "7f8717c6fd3e19b41048ce9a391d59540886cdee")
        (revision "1"))
    (package
     (inherit emacs-minimal)
     (name "emacs-next-minimal")
     (version (git-version "30.0.50" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.savannah.gnu.org/git/emacs.git")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "03d6qjmbsq65aci37xw3qg469c0j4zwplnhzs3mi5ccps8y6hcx8"))
       (patches
        (search-patches "emacs-next-exec-path.patch"
                        "emacs-fix-scheme-indent-function.patch"
                        "emacs-next-native-comp-driver-options.patch"
                        "emacs-pgtk-super-key-fix.patch")))))))


;;(define* (emacs->emacs-next emacs #:optional name
;;                            #:key (version (package-version emacs-next-minimal))
;;                            (source (package-source emacs-next-minimal)))
;;  (package
;;   (inherit emacs)
;;   (name (or name
;;             (and (string-prefix? "emacs" (package-name emacs))
;;                  (string-append "emacs-next"
;;                                 (string-drop (package-name emacs)
;;                                              (string-length "emacs"))))))
;;   (version version)
;;   (source source)))

;; (define-public emacs-next-pgtk-xwidgets (emacs->emacs-next emacs-pgtk-xwidgets))


(packages->manifest
 (list
  ;; Emacs version
  emacs-next-pgtk-xwidgets

  ;; Dependencies
  direnv

  ;; Emacs packages
  emacs-bluetooth-upd
  emacs-cape
  emacs-citar-embark
  emacs-citar-org-roam
  emacs-consult-org-roam
  emacs-consult-todo
  emacs-consult-yasnippet
  emacs-corfu
  emacs-corfu-candidate-overlay
  emacs-dired-sidebar
  emacs-doom-themes
  emacs-eat
  ;; emacs-eglot-jl
  emacs-embark-consult
  emacs-envrc
  emacs-ess-view-data
  emacs-evil-anzu
  emacs-evil-args
  emacs-evil-collection
  emacs-evil-easymotion
  emacs-evil-escape
  emacs-evil-goggles
  emacs-evil-mc
  emacs-evil-nerd-commenter
  emacs-evil-org
  emacs-evil-surround
  emacs-evil-tex
  emacs-evil-traces
  emacs-fancy-compilation
  emacs-flymake-collection
  emacs-forge
  emacs-geiser
  emacs-geiser-guile
  emacs-guix
  emacs-hide-mode-line
  emacs-highlight-indent-guides
  emacs-ibuffer-project
  ;; emacs-julia-snail
  ;; emacs-julia-ts-mode
  emacs-magit-todos
  emacs-marginalia
  emacs-markdown-preview-mode
  emacs-minimap
  emacs-minions
  emacs-mixed-pitch
  emacs-mpdel
  emacs-mpdel-embark
  emacs-nerd-icons-completion
  emacs-nerd-icons-corfu
  emacs-nerd-icons-dired
  emacs-nerd-icons-ibuffer
  emacs-orderless
  emacs-org-appear
  emacs-org-modern
  emacs-org-modern-indent
  emacs-org-roam
  emacs-org-roam-ql
  emacs-org-roam-timestamps
  emacs-org-roam-ui
  emacs-origami
  emacs-ox-gfm
  emacs-pass
  emacs-transmission
  emacs-empv
  ;; emacs-pdf-tools
  ;; emacs-org-noter
  ;; emacs-org-noter-pdftools
  ;; emacs-org-pdftools
  emacs-pyvenv-auto
  emacs-rainbow-mode
  emacs-tabspaces
  emacs-toc-org
  emacs-treesit-auto
  emacs-vertico
  ;; emacs-use-package ;; native don't have description but has :vc
  emacs-which-key
  emacs-yasnippet-capf
  emacs-yasnippet-snippets
  python-lsp-server
  fd
  ripgrep
  ))
