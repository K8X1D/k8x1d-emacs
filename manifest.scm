(use-modules (guix packages)
	     (guix download)
	     (guix build-system python)
	     (guix build-system pyproject)
	     (gnu packages python)
	     (gnu packages python-xyz)
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


    ;; Markdown
    "markdown" ;; Text-to-HTML conversion tool

    ;; ???
    "djvulibre" ;; Implementation of DjVu, the document format 

    "qtlanguageserver" ;;  Implementation of the Language Server Protocol for Qt
    "clang" ;; C language family frontend for LLVM


    ))
  (packages->manifest (list
		       python-radian
		       python-rapidfuzz
		       ))
  ))
