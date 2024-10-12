(use-modules (guix packages)
	     (gnu packages emacs)
	     (gnu packages gtk)
	     (gnu packages commencement)
	     (gnu packages glib)
	     (gnu packages perl)
	     (gnu packages tex)
	     (gnu packages rust-apps)
	     (gnu packages image)
	     (emacs build-system melpa)
	     (gnu packages pdf)
	     (gnu packages compression)
	     (gnu packages autotools)
	     (gnu packages pkg-config)
	     (gnu packages emacs-xyz)
	     (emacs packages melpa)
	     (guix git-download)
	     (guix build-system emacs)
	     (guix build-system gnu)
	     ((guix licenses) #:prefix license:))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Updated packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some packages from gnu elpa and non-gnu elpa are too old for melpa package. Hence, some dependency conflict appears. Updating the conflicking dependency solve to problem.

(define emacs-bluetooth-upd
  (package
   (inherit emacs-bluetooth)
   (name "emacs-bluetooth-upd")
   (propagated-inputs
    (list emacs-dash))
   ))

(define emacs-consult-denote-upd
  (package
   (inherit emacs-consult-denote)
   (name "emacs-consult-denote-upd")
   (propagated-inputs
    (list emacs-consult emacs-denote))
   ))
(define emacs-pdf-tools-upd
  (package
   (inherit emacs-pdf-tools)
   (name "emacs-pdf-tools")
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f                      ; there are no tests
      #:modules ((guix build gnu-build-system)
                 ((guix build emacs-build-system) #:prefix emacs:)
                 (guix build utils)
                 (guix build emacs-utils))
      #:imported-modules (,@%gnu-build-system-modules
                          (guix build emacs-build-system)
                          (guix build emacs-utils))
      #:phases
      (modify-phases %standard-phases
		     ;; Build server side using 'gnu-build-system'.
		     (add-after 'unpack 'enter-server-dir
				(lambda _ (chdir "server")))
		     (add-after 'enter-server-dir 'autogen
				(lambda _
				  (invoke "bash" "autogen.sh")))
		     ;; Build emacs side using 'emacs-build-system'.
		     (add-after 'compress-documentation 'enter-lisp-dir
				(lambda _ (chdir "../lisp")))
		     (add-after 'enter-lisp-dir 'emacs-patch-variables
				(lambda* (#:key outputs #:allow-other-keys)
					 (for-each make-file-writable (find-files "."))

					 ;; Set path to epdfinfo program.
					 (emacs-substitute-variables "pdf-info.el"
								     ("pdf-info-epdfinfo-program"
								      (string-append (assoc-ref outputs "out")
										     "/bin/epdfinfo")))
					 ;; Set 'pdf-tools-handle-upgrades' to nil to avoid "auto
					 ;; upgrading" that pdf-tools tries to perform.
					 (emacs-substitute-variables "pdf-tools.el"
								     ("pdf-tools-handle-upgrades" '()))))
		     (add-after 'emacs-patch-variables 'emacs-expand-load-path
				(assoc-ref emacs:%standard-phases 'expand-load-path))
		     (add-after 'emacs-expand-load-path 'emacs-add-install-to-native-load-path
				(assoc-ref emacs:%standard-phases 'add-install-to-native-load-path))
		     (add-after 'emacs-add-install-to-native-load-path 'emacs-install
				(assoc-ref emacs:%standard-phases 'install))
		     (add-after 'emacs-install 'emacs-build
				(assoc-ref emacs:%standard-phases 'build))
		     (add-after 'emacs-install 'emacs-make-autoloads
				(assoc-ref emacs:%standard-phases 'make-autoloads)))))
   (native-inputs
    (list autoconf automake emacs-minimal pkg-config))
   (inputs
    (list cairo glib libpng poppler zlib))
   (propagated-inputs
    (list emacs-tablist))
   (home-page "https://github.com/vedang/pdf-tools")
   (synopsis "Emacs support library for PDF files")
   (description
    "PDF Tools is, among other things, a replacement of DocView for PDF
files.  The key difference is that pages are not pre-rendered by
e.g. ghostscript and stored in the file-system, but rather created on-demand
and stored in memory.")
   (license license:gpl3+)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Manually defined packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define emacs-python-vterm
  (package
   (name "emacs-python-vterm")
   (version "0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/shg/python-vterm.el")
           (commit
            "8da9612b7adfda9703d2042dc95602743dd5a71e")))
     (sha256
      (base32
       "1xl4nkknjqm375gbi2csgacy8h0v1cx1qrhy8slwiwg04g8kj937"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-vterm))
   (home-page
    "https://github.com/shg/python-vterm.el")
   (synopsis "A simple vterm-based mode for an inferior Python REPL process in Emacs")
   (description
    "A simple vterm-based mode for an inferior Python REPL process in Emacs")
   (license license:gpl3+)))

(define emacs-ob-python-vterm
  (package
   (name "emacs-ob-python-vterm")
   (version "0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/shg/ob-python-vterm.el")
           (commit
            "de2a1d515b9e0530acc9eb9b498c522474361153")))
     (sha256
      (base32
       "1702p6ilwwdvs6wbz1q3ncmny5v2z5z7viqzrmcxdafzl22q03ni"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-queue emacs-python-vterm))
   (home-page
    "https://github.com/vale981/python-vterm.el")
   (synopsis "Org-babel support for Python code blocks using python-vterm.")
   (description
    "Org-babel support for Python code blocks using python-vterm.")
   (license license:gpl3+)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages bundles
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define %emacs-package (list emacs-next-pgtk))

(define %vc-packages
  (list emacs-magit
	emacs-forge
	emacs-magit-todos
	))

(define %modeline-packages
  (list emacs-diminish))

(define %completion-packages
  (list
   emacs-vertico
   emacs-marginalia
   emacs-orderless
   emacs-consult
   ))

(define %lsp-packages
  (list emacs-lsp-mode
	emacs-lsp-ui))

(define %terminal-packages
  (list emacs-vterm
	emacs-multi-vterm
	))


(define %checker-packages
  (list emacs-flycheck))

(define %icons-packages
  (list
   emacs-nerd-icons
   emacs-nerd-icons-completion
   emacs-nerd-icons-dired
   emacs-nerd-icons-ibuffer
   ))

(define %evil-packages
  (list
   emacs-evil
   emacs-evil-collection
   emacs-evil-escape
   emacs-evil-mc
   emacs-evil-org
   emacs-evil-surround
   emacs-evil-visualstar
   emacs-undo-fu
   emacs-undo-fu-session
   emacs-vdiff
   ))

(define %r-packages
  (list emacs-ess
	emacs-ess-view-data))

(define-public emacs-lsp-julia
  (package
    (name "emacs-lsp-julia")
    (version "20230915.654")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/gdkrmr/lsp-julia.git")
               (commit
                 "c869b2f6c05a97e5495ed3cc6710a33b4faf41a2")))
        (sha256
          (base32
            "0mbqv324b0km1z4af4hcgbc0493bizrbxr9v97asxvgm8j8bh24p"))))
    (build-system melpa-build-system)
    (propagated-inputs
      (list emacs-lsp-mode emacs-julia-mode))
    (arguments
      ;; '(#:files (:defaults "languageserver")))
      '(#:files (:defaults "*.jl" "*.toml" "languageserver")))
    (home-page "https://github.com/gdkrmr/lsp-julia")
    (synopsis "Julia support for lsp-mode")
    (description
      "Documentation at https://melpa.org/#/lsp-julia")
    (license #f)))


(define %julia-packages
  (list emacs-julia-mode
	emacs-julia-vterm
	emacs-ob-julia-vterm
	emacs-lsp-julia))

(define %python-packages
  (list
   emacs-python-vterm
   emacs-ob-python-vterm
   emacs-pyvenv
   ))



(define %pdf-packages
  (list
   emacs-pdf-tools-upd
   emacs-saveplace-pdf-view
   ))


(define %notes-taking-packages
  (list
   emacs-denote
   emacs-consult-denote-upd
   emacs-citar-denote
   emacs-denote-menu
   ))


(define %multimedia-packages
  (list
   emacs-emms
   emacs-ready-player
   ))


(define %keybindings-packages
  (list
   emacs-embark
   emacs-embark-consult
   emacs-which-key
   emacs-general
   ))

(define %org-packages
  (list
   emacs-org
   emacs-org-modern
   ))

(define %bluetooth-packages
  (list
   emacs-bluetooth-upd
   ))

(define %latex-packages
  (list
   emacs-auctex
   ))

(define %corrector-packages
  (list
   emacs-lsp-ltex
   ))

(define %highlight-packages
  (list
   emacs-hl-todo
   ))


(define %csv-packages
  (list
   emacs-csv-mode
   ))


(define %buffers-packages
  (list
   emacs-ibuffer-project
   ))


(define %guix-packages
  (list
   emacs-guix
   ))


(define %emacs-package-el-packages
  (list
   ;; Vterm building dependency
   libtool
   perl
   gcc-toolchain
   ;; Checker
   texlive-lacheck
   ;; LSP
   emacs-lsp-booster
   ;; Org + Latex
   ;; texlive-bin
   texlive-dvipng-bin
   ;; texlive-scheme-basic
   texlive-ulem ;; org-preview latex
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Manifest 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(packages->manifest
 (append 
  ;; %bluetooth-packages
  ;; %buffers-packages
  ;; %checker-packages
  ;; %completion-packages
  ;; %corrector-packages
  ;; %csv-packages
  %emacs-package
  ;; %evil-packages
  ;; %highlight-packages
  ;; %icons-packages
  ;; %julia-packages
  ;; %keybindings-packages
  ;; %latex-packages
  ;; %lsp-packages
  ;; %modeline-packages
  ;; %multimedia-packages
  ;; %notes-taking-packages
  ;; %org-packages
  ;; %pdf-packages
  ;; %python-packages
  ;; %r-packages
  ;; %terminal-packages
  ;; %vc-packages
  ;; %guix-packages
  %emacs-package-el-packages
  ))
