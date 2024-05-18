(use-modules (guix packages)
	     (guix git-download)
	     (guix download)
	     (guix build-system emacs)
	     ((guix licenses) #:prefix license:)
	     (guix)
	     (guix gexp)
	     (gnu packages)
	     (gnu packages commencement)
	     (gnu packages emacs)
	     (gnu packages graphviz)
	     (gnu packages fontutils)
	     (gnu packages glib)
	     (gnu packages linux)
	     (gnu packages cran)
	     (gnu packages emacs-xyz)
	     (gnu packages shellutils)
	     (gnu packages python-xyz)
	     (gnu packages python-science)
	     (gnu packages pdf)
	     (gnu packages julia)
	     (gnu packages linux)
	     (gnu packages python)
	     (gnu packages rust-apps)
	     (gnu packages shellutils)
	     (gnu packages check)
	     (gnu packages gtk)
	     (gnu packages image)
	     (gnu packages autotools)
	     (gnu packages pkg-config)
	     (gnu packages python-check)
	     (gnu packages python-build)
	     (gnu packages python-crypto)
	     (gnu packages statistics)
	     (guix build-system gnu)
	     (gnu packages tex)
	     (gnu packages ncurses)
	     (gnu packages texinfo)
	     (gnu packages compression)
	     (guix build-system python)
	     (guix build-system r)
	     (guix build-system emacs)
	     (guix build-system pyproject)
	     ;; (emacs build-system melpa)
	     (emacs packages melpa)
       )


(define-public emacs-python-vterm
  (package
    (name "emacs-python-vterm")
    (version "20240517.075")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/vale981/python-vterm.el.git")
               (commit
                 "0755613c86fa7af89a2badc336787b4c694da89d")))
        (sha256
          (base32
            "0si1gsvwpj3in60dzlm98ayf2wvlc1s9wqaarnv0laz62s7fgiij"))))
    (build-system emacs-build-system)
    (arguments
     `(#:include (cons* "^scripts/.*" %default-include))
     )
    (propagated-inputs (list emacs-vterm))
    (home-page
      "https://github.com/shg/julia-vterm.el")
    (synopsis "A mode for Python REPL using vterm")
    (description
      "A simple vterm-based mode for an inferior (i)Python REPL process in Emacs ")
    (license #f)))

(define-public emacs-denote-refs
  (package
   (name "emacs-denote-refs")
   (version "0.1.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://codeberg.org/akib/emacs-denote-refs")
           (commit "9ae49c8770a83eed92c58be45a4c96fa927cbe6f")))
     (sha256
      (base32 "04k3gz60pp5p2dnywnx6d6fpa12ssg4l07hxfn13201lpwcp6x1a"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-denote))
   (home-page "https://codeberg.org/akib/emacs-denote-refs")
   (synopsis "Show links and backlinks in Denote notes")
   (description
    "Show links and backlinks in Denote notes")
   (license license:gpl3+)))

(define-public emacs-breadcrumb
  (package
   (name "emacs-breadcrumb")
   (version "0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/joaotavora/breadcrumb")
	   (commit "dcb6e2e82de2432d8eb75be74c8d6215fc97a2d3")))
     (sha256
      (base32 "01k2gj9s9g8zdhb9c20zk11jgknk8na2vjvzqh0dna75z8kqi1dn"))
     (file-name (git-file-name name version))
     ))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-f))
   (home-page "https://github.com/joaotavora/breadcrumb")
   (synopsis "Emacs headerline indication of where you are in a large project")
   (description
    "Emacs headerline indication of where you are in a large project")
   (license license:gpl3+)))

(define-public emacs-eglot-ltex
  (package
   (name "emacs-eglot-ltex")
   (version "v0.1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/emacs-languagetool/eglot-ltex")
	   (commit "b61e36fad79c03ef3c1acc3c3366df7fc223aed8")))
     (sha256
      (base32 "1b8rmlc9a1djqfh9ra61is5c9jaq8j4qcrmavn273z06lr5qwj47"))
     (file-name (git-file-name name version))
     ;; (patches (list %patch-org-margin-svg-support.patch))
     ))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-f))
   (home-page "https://github.com/emacs-languagetool/eglot-ltex")
   (synopsis "Eglot Clients for LTEX")
   (description
    "Eglot Clients for LTEX")
   (license license:gpl3+)))

(define-public %patch-org-margin-svg-support.patch
  (local-file "patches/org-margin-svg-support.patch" #:recursive? #t))

(define-public emacs-org-margin-patched
  (package
   (name "emacs-org-margin")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/rougier/org-margin")
	   (commit "4013b59ff829903a7ab86b95593be71aa5c9b87d")))
     (sha256
      (base32 "13x5568yfqm1lfmy29vcii2bdkjxjygmhslbr0fwgm2xq9rn63yv"))
     (file-name (git-file-name name version))
     ;; (patches (list %patch-org-margin-svg-support.patch))
     ))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-svg-lib))
   (home-page "https://github.com/rougier/org-margin")
   (synopsis "Outdent headlines in emacs org-mode")
   (description
    "Outdent headlines in emacs org-mode")
   (license license:gpl3+)))

(define-public emacs-consult-jump-project
  (package
   (name "emacs-consult-jump-project")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/jdtsmith/consult-jump-project")
           (commit "bb540e72708dc9e7c8d66337be3d1fe68369ee72")))
     (sha256
      (base32 "0wgfhfp2ww5alx5gnn7yay3s8zi0vd2kwnphgb3pcn5bpnjp53v2"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-jsonrpc emacs-consult emacs-eglot emacs-seq))
   (home-page "https://github.com/jdtsmith/consult-jump-project")
   (synopsis "Quickly jump between projects, their files and buffers with consult")
   (description
    "Quickly jump between projects, their files and buffers with consult.")
   (license license:gpl3+)))



(define-public emacs-eglot-booster
  (package
   (name "emacs-eglot-booster")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/jdtsmith/eglot-booster")
           (commit "e19dd7ea81bada84c66e8bdd121408d9c0761fe6")))
     (sha256
      (base32 "06rn253jil4ccr29hpcadvh3gya8hvi3kz916x2c93qlhmkghpdw"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-jsonrpc emacs-eglot emacs-seq))
   (home-page "https://github.com/jdtsmith/eglot-booster")
   (synopsis "Boost eglot using lsp-booster")
   (description
    "The emacs-lsp-booster project provides a rust-based wrapper program which substantially speeds up emacs' interactions with lsp servers. This small package enables eglot to use it.")
   (license license:gpl3+)))


(define-public emacs-flymake-margin
  (package
   (name "emacs-flymake-margin")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/LionyxML/flymake-margin")
           (commit "fe4da9f947c7a11aba331dd77637d471cedbd061")))
     (sha256
      (base32 "1p3q7s5n1szggj8w8fmpz8l7g27srmsrgla5wag2320dnd6djrir"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (home-page "https://github.com/LionyxML/flymake-margin")
   (synopsis "A package to provide flymake into the margin world ")
   (description
    "A package to provide Emacs Flymake marks into the margin world.")
   (license license:gpl3+)))


(define-public emacs-modern-tab-bar
  (package
   (name "emacs-modern-tab-bar")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/aaronjensen/emacs-modern-tab-bar")
           (commit "f5e06b2e4897f72add34b061a294116b2d75b756")))
     (sha256
      (base32 "1j8f99asp0vq3qg1k2pdhldkdv7qj2jwhyplfz6vz6qf9bih5dxj"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (home-page "https://github.com/aaronjensen/emacs-modern-tab-bar")
   (synopsis "A more modern visual representation for tab-bar-mode tabs.")
   (description
    "A more modern visual representation for tab-bar-mode tabs. Note that this does not affect tab-line-mode tabs.")
   (license license:gpl3+)))

(define-public emacs-pdf-tools-upd
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


;; https://github.com/tpapp/julia-repl/blob/656437b94ee7f8d4e21259d942821512d87909c7/julia-repl.el

;;(define-public emacs-julia-repl-w-eat
;;  (package
;;   (inherit emacs-julia-repl)
;;   (name "emacs-julia-repl")
;;   (source
;;    (origin
;;     (method git-fetch)
;;     (uri (git-reference
;;	   (url "https://github.com/tpapp/julia-repl.git")
;;	   (commit
;;	    "656437b94ee7f8d4e21259d942821512d87909c7")))
;;     (sha256
;;      (base32
;;       "10rng1kwl45z8r2z3g5icswm5f52jlp1ic0j4hm5g3s9q2chfrr1"))))
;;   (build-system melpa-build-system)
;;   (propagated-inputs (list emacs-s))
;;   (home-page "https://github.com/tpapp/julia-repl")
;;   (synopsis "A minor mode for a Julia REPL")
;;   (description
;;    "Documentation at https://melpa.org/#/julia-repl")
;;   (license #f)))



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


(define-public r-unigd
  (package
    (name "r-unigd")
    (version "0.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (cran-uri "unigd" version))
       (sha256
        (base32 "0q6nix6pqjg7adfyisg6zn7hzwkdmz1dhd34c6a58dsg2yq1qh1a"))))
    (properties `((upstream-name . "unigd")))
    (build-system r-build-system)
    (inputs (list cairo fontconfig freetype libpng zlib))
    (propagated-inputs (list r-cpp11 r-systemfonts))
    (native-inputs (list pkg-config r-knitr))
    (home-page "https://github.com/nx10/unigd")
    (synopsis "Universal graphics device")
    (description
     "This package provides a unified R graphics backend.  Render R graphics
fast and easy to many common file formats.  It provides a thread safe C
interface for asynchronous rendering of R graphics.")
    (license license:gpl2+)))

(define-public r-asioheaders
  (package
    (name "r-asioheaders")
    (version "1.22.1-2")
    (source
     (origin
       (method url-fetch)
       (uri (cran-uri "AsioHeaders" version))
       (sha256
        (base32 "192qxayrpvi02wrqq2h5cjc92aaxrsgw7z32r8qk5imqg3mc0a8n"))))
    (properties `((upstream-name . "AsioHeaders")))
    (build-system r-build-system)
    (home-page "https://github.com/eddelbuettel/asioheaders")
    (synopsis "Asio C++ header files")
    (description
     "Asio is a cross-platform C++ library for network and low-level I/O
programming that provides developers with a consistent asynchronous model
using a modern C++ approach.  It is also included in Boost but requires
linking when used with Boost.  Standalone it can be used header-only (provided
a recent compiler).  Asio is written and maintained by Christopher
M. Kohlhoff, and released under the Boost Software License', Version 1.0.")
    (license license:boost1.0)))

(define-public r-httpgd
  (let ((commit "3f5f55822c4dce930155b91cedcfd4d483e3294e")
        (revision "1"))
    (package
      (name "r-httpgd")
      (version (git-version "2.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/nx10/httpgd")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "14i7mhbv1vcz2886w9lii9zhgr4zhhc844349syb989nhhzg552n"))))
      (properties `((upstream-name . "httpgd")))
      (build-system r-build-system)
      (propagated-inputs (list r-asioheaders r-cpp11 r-unigd))
      (native-inputs (list r-knitr))
      (home-page "https://github.com/nx10/httpgd")
      (synopsis "'HTTP' Server Graphics Device")
      (description
       "This package provides a graphics device for R that is accessible via
network protocols.  This package was created to make it easier to embed live R
graphics in integrated development environments and other applications.  The
included HTML/@code{JavaScript} client (plot viewer) aims to provide a better
overall user experience when dealing with R graphics.  The device
asynchronously serves graphics via HTTP and @code{WebSockets}'.")
      (license license:gpl2+))))

(define-public emacs-essgd 
  (package
   (name "emacs-essgd")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/sje30/essgd")
           (commit "c0e54ee69848e813e5a267aa167bc891afc819bb")))
     (sha256
      (base32 "0m55nn3719w3vfbkhxbyrh62xcx1bqz6fcypcmsm8ajbprgiwadq"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-websocket emacs-ess))
   (home-page "https://github.com/sje30/essgd")
   (synopsis "")
   (description
    ".")
   (license license:gpl3+)))

(define-public emacs-org-popup-posframe
  (package
   (name "emacs-org-popup-posframe")
   (version "v0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/A7R7/org-popup-posframe")
           (commit "f2457999d886328d44a86c2e6e62944bf3191a78")))
     (sha256
      (base32 "0d7zfpasa9ymci82qs3ihrjqd1na2s5hagwr0bayzxcrnqrr80di"))
     (file-name (git-file-name name version))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-posframe))
   (home-page "https://github.com/A7R7/org-popup-posframe")
   (synopsis "show org-mode popup buffers in posframe")
   (description
    "")
   (license license:gpl3+)))


(define-public %patch-flymake-posframe-eglot
  (local-file "patches/flymake-posframe-eglot.patch" #:recursive? #t))

(define-public %patch-flymake-posframe-no-transparency
  (local-file "patches/flymake-posframe-no-transparency.patch" #:recursive? #t))

;;(define-public emacs-flymake-posframe-patched
;;  (package
;;   (name "emacs-flymake-posframe")
;;   (version "20210304")
;;   (source
;;    (origin
;;     (method git-fetch)
;;     (uri (git-reference
;;	   (url "https://github.com/Ladicle/flymake-posframe.git")
;;	   (commit
;;	    "6ce6e2bc62699c84b7046dd6d07191d37cad3e3e")))
;;     (sha256
;;      (base32
;;       "08id06c3750adxgk8y30yai098jzrh0mmgwn34b7gmfvcn16934n"))
;;     (patches (list %patch-flymake-posframe-eglot
;;		    %patch-flymake-posframe-no-transparency)
;;     )))
;;  (build-system melpa-build-system)
;;  (propagated-inputs (list emacs-posframe))
;;  (home-page
;;   "https://github.com/Ladicle/flymake-posframe")
;;  (synopsis "Showing flymake diagnostics at point using posframe")
;;  (description
;;   "Showing flymake diagnostics at point using posframe")
;;  (license #f)))





;; bluetooth package from guix-channel conflicts with emacs-pass from emacs channel, ensure that newer emacs-dash is used
(define-public emacs-bluetooth-upd
  (package
   (inherit emacs-bluetooth)
   (name "emacs-bluetooth-upd")
   (propagated-inputs
    (list emacs-dash))
   ))

;; vertico-posframe package from guix-channel conflicts with more up-to-date vertico package from emacs channel, ensure that newer emacs-vertico is used
(define-public emacs-vertico-posframe-upd
  (package
   (inherit emacs-vertico-posframe)
   (name "emacs-vertico-posframe-upd")
   (propagated-inputs
    (list emacs-vertico emacs-posframe))
   ))


(define-public %patch-eldoc-box-no-transparency
  (local-file "patches/eldoc-box-no-transparency.patch" #:recursive? #t))

;;(define-public emacs-eldoc-box-patched
;;  (package
;;   (inherit emacs-eldoc-box)
;;    (version "20231115.519")
;;    (source
;;     (origin
;;      (method git-fetch)
;;      (uri (git-reference
;;	    (url "https://github.com/casouri/eldoc-box.git")
;;	    (commit
;;	     "c36f31074b09930e8425963f39d5508da6d2c32d")))
;;      (sha256
;;       (base32
;;	"0vglh3sp9x6z537jngh5jh9j3szbfadryzlwhmrlq7asiinnjq01"))
;;     (patches (list %patch-eldoc-box-no-transparency))))
;;    (build-system melpa-build-system)
;;    (home-page
;;      "https://github.com/casouri/eldoc-box")
;;    (synopsis "Display documentation in childframe")
;;    (description
;;      "Documentation at https://melpa.org/#/eldoc-box")
;;    (license #f)))


(define-public python-wsgiref
  (package
   (name "python-wsgiref")
   (version "0.1.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "wsgiref" version ".zip"))
     (sha256
      (base32 "0y8fyjmpq7vwwm4x732w97qbkw78rjwal5409k04cw4m03411rn7"))))
   (build-system pyproject-build-system)
   (native-inputs (list zip unzip))
   (home-page "http://cheeseshop.python.org/pypi/wsgiref")
   (synopsis "WSGI (PEP 333) Reference Library")
   (description "WSGI (PEP 333) Reference Library")
   (license #f)))

(define-public python-frozen-flask
  (package
   (name "python-frozen-flask")
   (version "1.0.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Frozen-Flask" version))
     (sha256
      (base32 "1brsw2hx3bbnw5jvcsvblasdi5z03373zkvgipmmjzcb31dqk9sk"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask))
   (native-inputs (list python-pytest))
   (home-page "")
   (synopsis "Freezes a Flask application into a set of static files.")
   (description "Freezes a Flask application into a set of static files.")
   (license #f)))

(define-public python-flask-uploads
  (package
   (name "python-flask-uploads")
   (version "0.2.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Uploads" version))
     (sha256
      (base32 "00nb3s29vkqhb0196llyq1bgrirkmaxxwfmn0ap50zb66dhbvv2k"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask))
   (home-page "https://github.com/maxcountryman/flask-uploads")
   (synopsis "Flexible and efficient upload handling for Flask")
   (description "Flexible and efficient upload handling for Flask")
   (license license:expat)))

(define-public python-flask-themes
  (package
   (name "python-flask-themes")
   (version "0.1.3")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Themes" version))
     (sha256
      (base32 "1z6r12z4gdxlnxd3sj99v4vnl3757wm6b4pwxwvsmksckb9gv1h5"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask))
   (home-page "http://bitbucket.org/leafstorm/flask-themes/")
   (synopsis "Provides infrastructure for theming Flask applications")
   (description
    "This package provides infrastructure for theming Flask applications")
   (license license:expat)))

(define-public python-mimeparse
  (package
   (name "python-mimeparse")
   (version "1.6.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "python-mimeparse" version))
     (sha256
      (base32 "0y2g6cl660bpz11srgqyvvm8gmywpgyx8g0xfvbiyr0af0yv1r3n"))))
   (build-system pyproject-build-system)
   (home-page "https://github.com/dbtsai/python-mimeparse")
   (synopsis
    "A module provides basic functions for parsing mime-type names and matching them against a list of media-ranges.")
   (description
    "This package provides a module provides basic functions for parsing mime-type
names and matching them against a list of media-ranges.")
   (license #f)))

(define-public python-mimerender
  (package
   (name "python-mimerender")
   (version "0.6.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "mimerender" version))
     (sha256
      (base32 "1imim78dypbl9fvrz21j8f13q8i96dx90m7f5ib3z371zrz3gwg7"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-python-mimeparse))
   (home-page "https://github.com/martinblech/mimerender")
   (synopsis
    "RESTful HTTP Content Negotiation for Flask, Bottle, web.py and webapp2 (Google App Engine)")
   (description
    "RESTful HTTP Content Negotiation for Flask, Bottle, web.py and webapp2 (Google
App Engine)")
   (license license:expat)))

(define-public python-flask-restless
  (package
   (name "python-flask-restless")
   (version "0.17.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Restless" version))
     (sha256
      (base32 "1dn2g3qkgvbbs4165hng82gkplm1bnxf010qkaf26ixx1bl7zr0x"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask python-mimerender python-dateutil
                            python-sqlalchemy))
   (home-page "http://github.com/jfinkels/flask-restless")
   (synopsis "A Flask extension for easy ReSTful API generation")
   (description
    "This package provides a Flask extension for easy @code{ReSTful} API generation")
   (license #f)))

(define-public python-flask-pymongo
  (package
   (name "python-flask-pymongo")
   (version "2.3.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-PyMongo" version))
     (sha256
      (base32 "051kwdk07y4xm4yawcjhn6bz8swxp9nanv7jj35mz2l0r0nv03k2"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask python-pymongo))
   (home-page "http://flask-pymongo.readthedocs.org/")
   (synopsis "PyMongo support for Flask applications")
   (description "@code{PyMongo} support for Flask applications")
   (license license:bsd-3)))

(define-public python-flask-mail
  (package
   (name "python-flask-mail")
   (version "0.9.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Mail" version))
     (sha256
      (base32 "0hazjc351s3gfbhk975j8k65cg4gf31yq404yfy0gx0bjjdfpr92"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-blinker python-flask))
   (home-page "https://github.com/rduplain/flask-mail")
   (synopsis "Flask extension for sending email")
   (description "Flask extension for sending email")
   (license license:bsd-3)))

(define-public python-flask-gravatar
  (package
   (name "python-flask-gravatar")
   (version "0.5.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Gravatar" version))
     (sha256
      (base32 "1qb2ylirjajdqsmldhwfdhf8i86k7vlh3y4gnqfqj4n6q8qmyrk0"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask))
   (native-inputs (list python-check-manifest
                        python-coverage
                        python-isort
                        python-pydocstyle
                        python-pytest
                        python-pytest-cache
                        python-pytest-cov
                        python-pytest-pep8))
   (home-page "https://github.com/zzzsochi/Flask-Gravatar/")
   (synopsis
    "Small extension for Flask to make usage of Gravatar service easy.")
   (description
    "Small extension for Flask to make usage of Gravatar service easy.")
   (license license:bsd-3)))

(define-public python-flask-flatpages
  (package
   (name "python-flask-flatpages")
   (version "0.8.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-FlatPages" version))
     (sha256
      (base32 "0sdws2y801a00c3gic86ybqwbvqqysmw6anhkd44b39h99bhqgs0"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask
                            python-jinja2
                            python-markdown
                            python-pytz
                            python-pyyaml
                            python-six))
   (home-page "")
   (synopsis "Provides flat static pages to a Flask application")
   (description
    "This package provides flat static pages to a Flask application")
   (license #f)))

(define-public python-flask-cache
  (package
   (name "python-flask-cache")
   (version "0.13.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Cache" version))
     (sha256
      (base32 "1x3ygki1x5rp3msxaxzx8n7frd5j71fyjxp2ivpm8f06pjlnq4lh"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask))
   (home-page "http://github.com/thadeusb/flask-cache")
   (synopsis "Adds cache support to your Flask application")
   (description "Adds cache support to your Flask application")
   (license license:bsd-3)))

(define-public python-visitor
  (package
   (name "python-visitor")
   (version "0.1.3")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "visitor" version))
     (sha256
      (base32 "02j87v93c50gz68gbgclmbqjcwcr7g7zgvk7c6y4x1mnn81pjwrc"))))
   (build-system pyproject-build-system)
   (home-page "http://github.com/mbr/visitor")
   (synopsis "A tiny pythonic visitor implementation.")
   (description
    "This package provides a tiny pythonic visitor implementation.")
   (license license:expat)))

(define-public python-dominate
  (package
   (name "python-dominate")
   (version "2.9.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "dominate" version))
     (sha256
      (base32 "1i4xs4qjmr77lizb6lgm1j64mp9js4d0bmp30hcsx2lvgml890jm"))))
   (build-system pyproject-build-system)
   (home-page "")
   (synopsis
    "Dominate is a Python library for creating and manipulating HTML documents using an elegant DOM API.")
   (description
    "Dominate is a Python library for creating and manipulating HTML documents using
an elegant DOM API.")
   (license #f)))

(define-public python-flask-bootstrap
  (package
   (name "python-flask-bootstrap")
   (version "3.3.7.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Bootstrap" version))
     (sha256
      (base32 "1j1s2bplaifsnmr8vfxa3czca4rz78xyhrg4chx39xl306afs26b"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-dominate python-flask python-visitor))
   (home-page "http://github.com/mbr/flask-bootstrap")
   (synopsis
    "An extension that includes Bootstrap in your project, without any boilerplate code.")
   (description
    "An extension that includes Bootstrap in your project, without any boilerplate
code.")
   (license license:bsd-3)))

(define-public python-flask-admin
  (package
   (name "python-flask-admin")
   (version "1.6.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Admin" version))
     (sha256
      (base32 "0s9k4dw1n96bv1lvh9m4fmn1sv165ps3bp6p04d62sibhfpy5ji4"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-flask python-wtforms))
   (home-page "https://github.com/flask-admin/flask-admin/")
   (synopsis "Simple and extensible admin interface framework for Flask")
   (description "Simple and extensible admin interface framework for Flask")
   (license license:bsd-3)))

(define-public python-zip
  (package
   (name "python-zip")
   (version "0.0.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "zip" version))
     (sha256
      (base32 "18agz94zz086z023y5kmchizg2wmwmmjdj14g8hyjqb777i7j2qd"))))
   (build-system pyproject-build-system)
   (propagated-inputs (list python-blinker
                            python-bumpversion
                            python-click
                            python-colorama
                            python-coverage
                            python-cryptography
                            python-flake8
                            python-flask
                            python-flask-admin
                            python-flask-bootstrap
                            python-flask-cache
                            python-flask-flatpages
                            python-flask-gravatar
                            python-flask-login
                            python-flask-mail
                            python-flask-pymongo
                            python-flask-restless
                            python-flask-sqlalchemy
                            python-flask-themes
                            python-flask-uploads
                            python-flask-wtf
                            python-frozen-flask
                            python-jinja2
                            python-markdown
                            python-networkx
                            python-pymongo
                            python-pytest
                            python-dateutil
                            python-pyyaml
                            python-six
                            python-sphinx
                            python-sqlalchemy
                            python-tox
                            python-watchdog
                            python-werkzeug
                            python-wheel
                            python-wsgiref
                            python-wtforms))
   (home-page "https://github.com/kdheepak/zip")
   (synopsis "")
   (description "")
   (license #f)))

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
   (arguments
    (list #:tests? #f                  
          #:phases #~(modify-phases %standard-phases
				    (delete 'compile-bytecode))))
   (inputs (list zip unzip python-wheel))
   (home-page "https://github.com/tr4n2uil/backend.django")
   (synopsis "Backend Utility Tools")
   (description "Backend Utility Tools")
   (license license:expat)))

(define-public python-rapidfuzz
  (package
   (name "python-rapidfuzz")
   (version "3.6.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "rapidfuzz" version))
     (sha256
      (base32 "06jyrbfpiq4k514k2biz22cj1ndzza569wlv9ilk3i5h59wix4fg"))))
   (build-system pyproject-build-system)
   ;; (inputs (list python-backend))
   ;; From python-inflect definition
   (arguments
    (list
     #:test-flags
     '(list "--ignore=_custom_build/backend.py"
	    "-k" "not mypy-status")
     #:phases
     '(modify-phases %standard-phases
		     ;; The build system insists on ignoring the existing environment and
		     ;; running "pip install".
		     (add-after 'unpack 'do-not-use-pip-install
				(lambda _
				  (substitute* "pyproject.toml"
					       (("^build-backend.*") "\
build-backend = \"backend\"
backend_path = [\"_custom_build\"]\n")
					       (("requires = .*") "requires = []\n"))
				  (mkdir-p "_custom_build")
				  (with-output-to-file "_custom_build/backend.py"
				    (lambda _
				      (display "\
from setuptools import build_meta as _orig
from setuptools.build_meta import *
def get_requires_for_build_wheel(config_settings=None):
    return []
def get_requires_for_build_sdist(config_settings=None):
    return []
")))
				  (setenv "PYTHONPATH"
					  (string-append (getcwd) "/_custom_build")))))))
   (propagated-inputs (list python-pydantic))
   (native-inputs (list python-flake8
                        python-pygments
                        python-pytest
                        python-pytest-black
                        python-pytest-checkdocs
                        python-pytest-cov
                        python-pytest-enabler
                        python-pytest-flake8
			python-pytest-mypy
			python-scikit-build
                        ;; For the version number
                        python-setuptools-scm))

   (home-page "https://github.com/rapidfuzz/RapidFuzz")
   (synopsis "rapid fuzzy string matching")
   (description "rapid fuzzy string matching")
   (license license:expat)))



(define-public emacs-eat-upd
  (package
   (name "emacs-eat-upd")
   (version "0.9.4")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://codeberg.org/akib/emacs-eat")
           (commit "3a6f418f55d183b9d86f99c140caed4ba3d44f93")))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "0wbfkhsy5c3agm7bw0g4n37mf6jghqp79hsxpbgrfy8bbb77j5pb"))
     (modules '((guix build utils)))
     (snippet
      #~(begin
          ;; Remove generated terminfo database.
          (delete-file-recursively "terminfo")))))
   (build-system emacs-build-system)
   (arguments
    (list
     #:tests? #t
     #:include #~(cons* "^term/"
                        "^terminfo/"
                        "^integration/"
                        "\\.ti$"
                        %default-include)
     #:phases
     #~(modify-phases %standard-phases
		      (add-before 'install 'build-info
				  (lambda _
				    (invoke "make" "info")))
		      (add-before 'install 'build-terminfo-database
				  (lambda _
				    (invoke "make" "terminfo")))
		      (add-before 'install 'patch-ncurses-tic-executable
				  (lambda* (#:key inputs #:allow-other-keys)
				    (let ((tic (search-input-file inputs "/bin/tic")))
				      (substitute* "eat.el"
						   (("\\(executable-find \"tic\"\\)")
						    (string-append "\"" tic "\"")))))))))
   (native-inputs
    (list texinfo))
   (inputs
    (list ncurses))
   (propagated-inputs
    (list emacs-compat))
   (home-page "https://codeberg.org/akib/emacs-eat")
   (synopsis "Terminal emulator in Emacs")
   (description
    "Eat (Emulate A Terminal) is a terminal emulator in Emacs, written in
pure Elisp.  It has features like Sixel support, complete mouse support and
shell integration.")
   (license license:gpl3+)))




(packages->manifest
 (list
;;;; to add
  emacs-julia-ts-mode
  emacs-citar-embark
  emacs-consult-todo
  emacs-consult-eglot-embark
  emacs-embark-consult
  emacs-empv
  emacs-ess-view-data
  emacs-evil-easymotion
  emacs-python-view-data
  emacs-fancy-compilation
  emacs-ibuffer-project
  emacs-mpdel-embark
  emacs-nerd-icons-completion
  emacs-nerd-icons-corfu
  emacs-nerd-icons-dired
  emacs-nerd-icons-ibuffer
  emacs-org-roam-ql
  emacs-org-roam-timestamps
  emacs-origami
  emacs-org-roam-ui
  emacs-proced-narrow
  emacs-pyvenv-auto
  emacs-tabspaces
  emacs-treesit-auto
  emacs-yasnippet-capf
  emacs-julia-vterm
  emacs-ob-julia-vterm
  emacs-memento-mori
  emacs-auto-dark
  emacs-flymake-php
  emacs-nix-ts-mode
  emacs-tab-bar-echo-area
  emacs-diredc
  emacs-dired-posframe
  emacs-flymake-hadolint
  emacs-flymake-lua
  emacs-flymake-fennel
  emacs-todotxt
  emacs-denote-explore
  





  ;; emacs-julia-snail
  ;; emacs-julia-repl-w-eat
  ;; emacs-org-noter
  ;; emacs-org-noter-pdftools
  ;; emacs-org-pdftools
  ;; emacs-pdf-tools
  emacs-use-package ;; native don't have description but has :vc
  ;; alsa-utils
  ;; pipewire
  ;; wireplumber
  direnv
  emacs-auctex
  emacs-bluetooth-upd
  ;; emacs-bluetooth
  emacs-cape
  emacs-citar-org-roam
  emacs-consult-org-roam
  emacs-consult-yasnippet
  emacs-consult-eglot
  ;; emacs-corfu-candidate-overlay
  emacs-dired-sidebar
  emacs-doom-themes
  ;; emacs-eat-upd
  emacs-envrc
  emacs-ess
  emacs-essgd
  r-httpgd
  emacs-evil-anzu
  emacs-evil-args
  emacs-evil-collection
  emacs-evil-escape
  emacs-evil-goggles
  emacs-evil-mc
  emacs-evil-nerd-commenter
  emacs-evil-org
  emacs-evil-surround
  emacs-evil-tex
  emacs-evil-traces
  emacs-flymake-collection
  emacs-forge
  emacs-geiser
  emacs-geiser-guile
  emacs-guix
  emacs-hide-mode-line
  emacs-highlight-indent-guides
  emacs-magit-todos
  emacs-marginalia
  emacs-markdown-preview-mode
  emacs-minimap
  emacs-minions
  emacs-mixed-pitch
  emacs-mpdel
  emacs-next-pgtk-xwidgets
  ;; emacs-pgtk-xwidgets
  emacs-orderless
  emacs-org-appear
  emacs-org-modern
  emacs-org-modern-indent
  emacs-org-roam
  emacs-ox-gfm
  emacs-pass
  emacs-rainbow-mode
  emacs-toc-org
  emacs-transmission
  emacs-vertico
  emacs-which-key
  emacs-general
  emacs-elpy
  emacs-yasnippet-snippets
  emacs-vterm
  ;; emacs-vterm-toggle
  emacs-multi-vterm
  fd
  poppler
  python-lsp-server
  python-pandas
  ripgrep
  python-epc
  python-orjson
  python-sexpdata
  python-six
  python-setuptools
  python-paramiko
  ;; python-rapidfuzz
  python
  julia
  r-minimal
  r-languageserver
  r-lintr
  r-renv
  emacs-pdf-tools-upd
  ;; emacs-pdf-tools-upd
  glibc-locales
  ;; texlive
  texlive-scheme-basic ;; Basic scheme (plain and latex)
  texlive-dvipng
  texlive-digestif

  ;; emacs-which-key-posframe
  ;; emacs-eldoc-box-patched
  ;; emacs-vertico-posframe-upd
  ;; emacs-org-popup-posframe
  ;; emacs-flymake-posframe-patched

  emacs-pubmed
  emacs-mastodon

  emacs-modern-tab-bar
  emacs-flymake-margin
  emacs-eglot-booster
  emacs-consult-jump-project
  emacs-php-mode
  emacs-org-margin-patched
  emacs-eglot-ltex

  emacs-nix-mode


  emacs-breadcrumb

  emacs-docker
  emacs-dockerfile-mode
  emacs-docker-compose-mode

  emacs-lua-mode
  emacs-fennel-mode
  emacs-corfu

  emacs-denote
  emacs-denote-refs
  emacs-denote-menu
  emacs-citar-denote
  graphviz

  emacs-direnv

  emacs-python-vterm

  )
 
 )
