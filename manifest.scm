(use-modules (guix packages)
	     (guix download)
	     (guix build-system python)
	     (guix build-system pyproject)
	     (gnu packages python)
	     (gnu packages aspell)
	     (gnu packages python-xyz)
	     (gnu packages emacs)
	     (gnu packages libffi)
	     (gnu packages compression)
	     (gnu packages check)
	     ((guix licenses) #:prefix license:)
	     (gnu packages terminals))

;;
;; Packages
;;

(define-public python-backend
  (package
   (name "python-backend")
   (version "0.2.4.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "backend" version ".zip"))
     (sha256
      (base32 "17p70swiawv0dzmcd04szdaxsfi5dwnfjqjkbcppacf7fkmghqg1"))))
   (build-system pyproject-build-system)
    ;; (build-system python-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
		     (replace 'build
			      (lambda* (#:key tests? #:allow-other-keys)
				(setenv "PYTHON" (or (which "python3") (which "python")))
				))
		     (replace 'install
			      (lambda* (#:key tests? #:allow-other-keys)
				(setenv "PYTHON" (or (which "python3") (which "python")))
				))
		     (replace 'check
			      (lambda* (#:key tests? #:allow-other-keys)
				(setenv "PYTHON" (or (which "python3") (which "python")))
				))
		     )))
   (native-inputs (list zip unzip))
   (home-page "https://github.com/tr4n2uil/backend.django")
   (synopsis "Backend Utility Tools")
   (description "Backend Utility Tools")
   (license license:expat))
  )


(define-public python-rapidfuzz
  (package
   (name "python-rapidfuzz")
   (version "3.3.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "rapidfuzz" version))
     (sha256
      (base32 "0l5ly2iz2r3cvigbl5d9hf3g7d57ay3kablfd1kpbv8m5y2v70v7"))))
   (build-system pyproject-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
		     (replace 'build
			      (lambda* (#:key tests? #:allow-other-keys)
				(setenv "PYTHON" (or (which "python3") (which "python")))
				))
		     (replace 'install
			      (lambda* (#:key tests? #:allow-other-keys)
				(setenv "PYTHON" (or (which "python3") (which "python")))
				))
		     (replace 'check
			      (lambda* (#:key tests? #:allow-other-keys)
				(setenv "PYTHON" (or (which "python3") (which "python")))
				))
		     )))
   (native-inputs (list python-backend))
   (home-page "https://github.com/maxbachmann/RapidFuzz")
   (synopsis "rapid fuzzy string matching")
   (description "rapid fuzzy string matching")
   (license license:expat))
  )


(define-public python-rchitect
(package
  (name "python-rchitect")
  (version "0.4.2")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "rchitect" version))
            (sha256
             (base32
              "1gmab3kxw0zyy2rzc59hjj89zijc27rpzrdfbvh9n5rna5w57564"))))
  (build-system pyproject-build-system)
  (propagated-inputs (list python-cffi python-six))
  (native-inputs (list python-pytest python-pytest-cov python-pytest-mock))
  (arguments `(#:tests? #f))
  (home-page "https://github.com/randy3k/rchitect")
  (synopsis "Mapping R API to Python")
  (description "Mapping R API to Python")
  (license #f))
)

(define-public python-radian
  (package
   (name "python-radian")
   (version "0.6.7")
   (source (origin
	    (method url-fetch)
	    (uri (pypi-uri "radian" version))
	    (sha256
	     (base32
	      "0d2i8dqdjlf3i10q7rhrcflpmrj1xfji8rnh1skm0zhyb33f2zr9"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-prompt-toolkit python-pygments
			    python-rchitect))
   (native-inputs (list python-coverage python-pexpect python-ptyprocess
			python-pyte python-pytest))
   (arguments `(#:tests? #f))
   (home-page "https://github.com/randy3k/radian")
   (synopsis "A 21 century R console")
   (description "This package provides a 21 century R console")
   (license #f))

  )


;;
;; Manifest


;;
;; Manifest
;;
(concatenate-manifests
 (list
  (specifications->manifest
   (list
    ;; Emacs
    "emacs-next-pgtk-xwidgets" ;; Emacs text editor with `xwidgets' and `pgtk' support

    ;; Fonts
    "font-iosevka" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-aile" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-term" ;; Coders' typeface, built from code

    ;; Vterm dependencies
    "gcc-toolchain" ;; Complete GCC tool chain for C/C++ development
    "cmake" ;; Cross-platform build system
    "libvterm" ;; VT220/xterm/ECMA-48 terminal emulator library

    ;; Utilities
    "fd" ;; Simple, fast and user-friendly alternative to find
    "ispell" ;; Interactive spell-checking tool for Unix


    ;; Markdown
    "markdown" ;; Text-to-HTML conversion tool

    ;; ???
    "djvulibre" ;; Implementation of DjVu, the document format 

    "qtlanguageserver" ;;  Implementation of the Language Server Protocol for Qt
    "clang" ;; C language family frontend for LLVM


    "direnv" ;; Environment switcher for the shell



    ;; ;;
    ;; ;; Emacs packages
    ;; ;;

    ;; ;; Completion
    ;; "emacs-corfu" ;; COmpletion in Region FUnction


    ;; ;; GUI
    ;; "emacs-rainbow-mode" ;; Colorize color names in buffers
    ;; ;; "emacs-rainbow-identifiers" ;; Highlight identifiers according to their names
    ;; "emacs-rainbow-delimiters" ;; Highlight brackets according to their depth
    ;; "emacs-hide-mode-line" ;; minor mode that hides/masks your modeline
    ;; "emacs-tab-bar-echo-area" ;; Display tab names of the tab bar in the echo area
    ;; "emacs-nerd-icons" ;; Library for easily using nerd font icons inside Emacs
    ;; "emacs-nerd-icons-corfu" ;; Icons for Corfu via nerd-icons ;; TODO: implement insteat of kind-icon
    ;; "emacs-nerd-icons-ibuffer" ;; Display nerd icons in ibuffer
    ;; "emacs-nerd-icons-dired" ;; Shows icons for each file in dired mode
    ;; "emacs-nerd-icons-completion" ;; Add icons to completion candidates ;; TODO: implement

    ;; ;; Utilities
    ;; "emacs-pdf-tools" ;; Emacs support library for PDF files
    ;; "emacs-general" ;; More convenient key definitions in
    ;; "emacs-org-gtd" ;; An implementation of GTD
    ;; "emacs-password-store-otp" ;; Interact with the `pass-otp' extension for `pass' from Emacs
    ;; "emacs-pass" ;; Major mode for `password-store.el'
    ;; "emacs-password-store" ;; Password store (pass) support for Emacs
    ;; "emacs-ssh-agency" ;; Manage `ssh-agent' from Emacs
    ;; "emacs-auth-source-pass" ;; Integrate `auth-source' with `password-store'
    ;; "emacs-doom-themes" ;; Wide collection of color themes for Emacs
    ;; "emacs-doom-modeline" ;; Fancy and fast mode-line inspired by minimalism design

    ;; ;; Multimedia
    ;; "emacs-emms" ;; The Emacs Multimedia System
    ;; ;; "emacs-bluetooth" ;; Manage Bluetooth devices using Emacs
    ;; "emacs-mpdel"
    ;; "emacs-guix"
    ;; "emacs-embark-consult"
    ;; "emacs-consult"

    ;; ;; Evil
    ;; "emacs-evil" ;; Extensible Vi layer for Emacs
    ;; "emacs-evil-collection" ;; Collection of Evil bindings for many major and minor modes
    ;; "emacs-evil-tex" ;; Evil oriented additions for editing LaTeX
    ;; "emacs-evil-org" ;; Evil keybindings for Org mode
    ;; "emacs-evil-mc" ;; Interactive search compatible with `multiple-cursors'

    ;; ;; Programming
    ;; "emacs-consult-lsp" ;; LSP mode and Consult helping each other
    ;; "emacs-lsp-ui" ;; User interface extensions for `lsp-mode'
    ;; "emacs-lsp-mode" ;; Emacs client and library for the Language Server Protocol
    ;; "emacs-lsp-scheme" ;; Scheme support for lsp-mode
    ;; "emacs-lsp-pyright" ;; Python LSP client using Pyright
    ;; "emacs-lsp-ltex" ;; LSP Clients for LTEX
    ;; "emacs-lsp-julia" ;; Julia support for lsp-mode
    ;; "emacs-lsp-docker" ;; LSP Docker integration

    ;; "emacs-jupyter" ;; Jupyter
    ;; "emacs-yasnippet" ;; Yet another snippet extension for Emacs
    ;; "emacs-yasnippet-snippets" ;; Collection of YASnippet snippets for many languages 
    ;; "emacs-consult-yasnippet" ;; Consulting-read interface for Yasnippet
    ;; "emacs-yasnippet-capf" ;; Yasnippet Completion At Point Function
    ;; "emacs-apheleia" ;; Reformat buffer stably
    ;; "emacs-flycheck" ;; On-the-fly syntax checking
    ;; "emacs-consult-flycheck" ;; Consult integration for Flycheck
    ;; "emacs-flycheck-guile" ;; GNU Guile support for Flycheck
    ;; "emacs-flycheck-title" ;; show flycheck errors in the frame title
    ;; "emacs-dap-mode" ;; Emacs client/library for Debug Adapter Protocol
    ;; "emacs-auto-virtualenv" ;; Auto activate python virtualenvs

    ;; ;; Writing
    ;; "emacs-auctex" ;; Integrated environment for TeX

    ))
  (packages->manifest (list
		       python-radian
		       python-rapidfuzz
		       ))
  ))
