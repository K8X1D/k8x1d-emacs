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
	     (gnu packages pdf)
	     (gnu packages julia)
	     (gnu packages python)
	     (gnu packages rust-apps)
	     (gnu packages shellutils)
	     (gnu packages check)
	     (gnu packages python-check)
	     (gnu packages python-build)
	     (gnu packages python-crypto)
	     (gnu packages tex)
	     (gnu packages ncurses)
	     (gnu packages texinfo)
	     (gnu packages compression)
	     (guix build-system python)
	     (guix build-system pyproject)
	     (emacs build-system melpa)
	     (emacs packages melpa))


;; https://github.com/tpapp/julia-repl/blob/656437b94ee7f8d4e21259d942821512d87909c7/julia-repl.el

(define-public emacs-julia-repl-w-eat
  (package
   (inherit emacs-julia-repl)
   (name "emacs-julia-repl")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/tpapp/julia-repl.git")
	   (commit
	    "656437b94ee7f8d4e21259d942821512d87909c7")))
     (sha256
      (base32
       "10rng1kwl45z8r2z3g5icswm5f52jlp1ic0j4hm5g3s9q2chfrr1"))))
   (build-system melpa-build-system)
   (propagated-inputs (list emacs-s))
   (home-page "https://github.com/tpapp/julia-repl")
   (synopsis "A minor mode for a Julia REPL")
   (description
    "Documentation at https://melpa.org/#/julia-repl")
   (license #f)))



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
  ;; emacs-julia-snail
  emacs-julia-ts-mode
  emacs-julia-repl-w-eat
  ;; emacs-org-noter
  ;; emacs-org-noter-pdftools
  ;; emacs-org-pdftools
  ;; emacs-pdf-tools
  ;; emacs-use-package ;; native don't have description but has :vc
  alsa-utils
  direnv
  ;; emacs-auctex
  emacs-bluetooth-upd
  emacs-cape
  emacs-citar-embark
  emacs-citar-org-roam
  emacs-consult-org-roam
  emacs-eldoc-box
  emacs-consult-todo
  emacs-consult-yasnippet
  emacs-corfu
  emacs-corfu-candidate-overlay
  emacs-dired-sidebar
  emacs-doom-themes
  emacs-eat-upd
  emacs-embark-consult
  emacs-empv
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
  ;; emacs-evil-tex
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
  emacs-next-pgtk-xwidgets
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
  emacs-proced-narrow
  emacs-pyvenv-auto
  emacs-rainbow-mode
  emacs-tabspaces
  emacs-toc-org
  emacs-transmission
  emacs-treesit-auto
  emacs-vertico
  emacs-which-key
  emacs-elpy
  emacs-yasnippet-capf
  emacs-yasnippet-snippets
  emacs-vterm
  emacs-vterm-toggle
  emacs-multi-vterm
  fd
  poppler
  python-lsp-server
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
  emacs-julia-vterm
  emacs-ob-julia-vterm

  glibc-locales
  ;; texlive
  texlive-scheme-basic ;; Basic scheme (plain and latex)
  texlive-dvipng
  texlive-digestif

  ))
