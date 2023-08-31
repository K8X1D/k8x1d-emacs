(use-modules (guix packages)
	     (guix download)
	     (guix build-system python)
	     (guix build-system pyproject)
	     (gnu packages python-xyz)
	     (gnu packages libffi)
	     (gnu packages check)
	     (gnu packages terminals))





;; Set emacs version according to window system
(define emacs-distribution 
  (if (equal? (getenv "XDG_SESSION_TYPE") "x11")
      "emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
      "emacs-next-pgtk") ;; Emacs text editor with `pgtk' and `tree-sitter' support
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
  (home-page "https://github.com/randy3k/radian")
  (synopsis "A 21 century R console")
  (description "This package provides a 21 century R console")
  (license #f))
)


;;
;; Manifest
;;
(concatenate-manifests
 (list
  (specifications->manifest
   (list 
    emacs-distribution
    ))
  (specifications->manifest
   (list
    "aspell" ;; Spell checker 
    "aspell-dict-en" ;; English dictionary for GNU Aspell  
    "aspell-dict-fr" ;; French dictionary for GNU Aspell 
    "autoconf"
    "automake"
    "ccls" ;; C/C++/Objective-C language server
    "coreutils" ;; Core GNU utilities (file, text, shell)
    "fd" ;; Simple, fast and user-friendly alternative to find
    "ffmpegthumbnailer" ;; Create thumbnails from video files
    "findutils" ;; Operating on files matching given criteria
    "font-fira-code"
    "font-fira-mono"
    "font-fira-sans"
    "font-hack" ;; Typeface designed for source code
    "font-iosevka" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-aile" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-term" ;; Coders' typeface, built from code
    "git"
    "guile-irregex"
    "guile-srfi-145"
    "guile-srfi-180"
    "guile@3.0"
    "hicolor-icon-theme" ;; Freedesktop icon theme 
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    "java-slf4j-simple" ;; Simple implementation of simple logging facade for Java
    "julia" ;; High-performance dynamic language for technical computing
    "mediainfo" ;; Utility for reading media metadata
    "mpv" ;; Audio and video player
    "mpv-mpris" ;; MPRIS plugin for mpv
    "nss-certs" ;; CA certificates from Mozilla
    "openjdk" ;; Java development kit
    "pinentry-emacs" ;; GnuPG's interface to passphrase input
    "pkg-config"
    "plantuml" ;; Draw UML diagrams from simple textual description
    "poppler" ;; PDF rendering library
    "python-epc" ;; Remote procedure call (RPC) stack for Emacs Lisp and Python
    "python-lsp-server" ;; Python implementation of the Language Server Protocol
    "python-orjson" ;; Python JSON library supporting dataclasses, datetimes, and numpy
    "python-paramiko" ;; SSHv2 protocol library
    "python-pylint" ;; Advanced Python code static checker
    "python-sexpdata" ;; S-expression parser for Python
    "python-six" ;; Python 2 and 3 compatibility utilities
    "r" ;; Environment for statistical computing and graphics
    "r-languageserver" ;; Language Server for R
    "r-styler" ;; Non-invasive pretty printing of R code
    "sqls" ;; SQL language server written in Go
    "tar" ;; Managing tar archives
    "texlive-chktex" ;; Check for errors in LaTeX documents
    "texlive-digestif" ;; Editor plugin for LaTeX, ConTeXt etc.
    "tree-sitter"
    "unzip" ;; Decompression and file extraction utility
    "zip" 
    ))
  (packages->manifest (list
		       python-radian
		       ))
  ))
