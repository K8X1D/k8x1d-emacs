;; TODO: fuse with emacs-pgtk
;;
;; Modules
;;
(use-modules (guix packages)
	     (guix git-download)
	     (guix build-system emacs)
	     (guix build-system python)
	     (gnu packages emacs-xyz)
	     (gnu packages python-xyz)
	     (gnu packages check)
	     (gnu packages statistics)
	     (guix download)
	     (guix licenses)
	     ((guix licenses) #:prefix license:))

;;
;; Packages
;;


(define-public emacs-emms
(package
  (name "emacs-emms")
  (version "20230329.2020")
  (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://git.savannah.gnu.org/git/emms.git")
                  (commit "0f4bd0c551b6ec1debfa834464f28030ce9c287b")))
            (sha256
             (base32
              "1mlvpfm3phmcfna1jnmpjw3q0dxa6ah1dwbarjmgqq15rrjs1841"))))
  (build-system emacs-build-system)
  (propagated-inputs (list emacs-nadvice emacs-seq))
  (arguments
   '(#:include '("^[^/]+.el$" "^[^/]+.el.in$"
                 "^dir$"
                 "^[^/]+.info$"
                 "^[^/]+.texi$"
                 "^[^/]+.texinfo$"
                 "^doc/dir$"
                 "^doc/[^/]+.info$"
                 "^doc/[^/]+.texi$"
                 "^doc/[^/]+.texinfo$")
     #:exclude '("^.dir-locals.el$" "^test.el$"
                 "^tests.el$"
                 "^[^/]+-test.el$"
                 "^[^/]+-tests.el$"
                 "^doc/fdl.texi$"
                 "^doc/gpl.texi$")))
  (home-page "https://www.gnu.org/software/emms/")
  (synopsis "The Emacs Multimedia System")
  (description
   "This is the very core of EMMS. It provides ways to play a track using
`emms-start', to go through the playlist using the commands `emms-next and
`emms-previous', to stop the playback using `emms-stop', and to see what's
currently playing using `emms-show'.  But in itself, this core is useless,
because it doesn't know how to play any tracks --- you need players for this.
In fact, it doesn't even know how to find any tracks to consider playing --- forthis, you need sources.  A sample configuration is offered in emms-setup.el, andthe Friendly Manual in the doc/ directory is both detailed, and kept up to date.")
  (license #f))
)



(define-public emacs-bind-key
  (package
   (name "emacs-bind-key")
   (version "20230203.2004")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/jwiegley/use-package.git")
		  (commit "77945e002f11440eae72d8730d3de218163d551e")))
	    (sha256
	     (base32
	      "1irr8a8r28n8c0c2x5w1flgv1f3z5jy2i5r5dknddiqa93b3rm84"))))
   (build-system emacs-build-system)
   (arguments
    '(#:include '("^bind-key.el$")
      #:exclude '()))
   (home-page "https://github.com/jwiegley/use-package")
   (synopsis "A simple way to manage personal keybindings")
   (description
    "If you have lots of keybindings set in your init file, it can be hard to know
which ones you haven't set yet, and which may now be overriding some new default
in a new Emacs version.  This module aims to solve that problem.  Bind keys as
follows in your init file: (bind-key \"C-c x\" my-ctrl-c-x-command) If the
keybinding argument is a vector, it is passed straight to `define-key', so
remapping a key with `[remap COMMAND] works as expected: (bind-key [remap
original-ctrl-c-x-command] my-ctrl-c-x-command) If you want the keybinding to
override all minor modes that may also bind the same key, use the `bind-key*
form: (bind-key* \"<C-return>\" other-window) If you want to rebind a key only in
a particular keymap, use: (bind-key \"C-c x\" my-ctrl-c-x-command
some-other-mode-map) To unbind a key within a keymap (for example, to stop your
favorite major mode from changing a binding that you don't want to override
everywhere), use `unbind-key': (unbind-key \"C-c x\" some-other-mode-map) To bind
multiple keys at once, or set up a prefix map, a `bind-keys macro is provided.
It accepts keyword arguments, please see its documentation for a detailed
description.  To add keys into a specific map, use :map argument (bind-keys :map
dired-mode-map (\"o\" .  dired-omit-mode) (\"a\" .  some-custom-dired-function)) To
set up a prefix map, use `:prefix-map and `:prefix arguments (both are required)
(bind-keys :prefix-map my-customize-prefix-map :prefix \"C-c c\" (\"f\" .
customize-face) (\"v\" .  customize-variable)) You can combine all the keywords
together.  Additionally, `:prefix-docstring can be specified to set
documentation of created `:prefix-map variable.  To bind multiple keys in a
`bind-key* way (to be sure that your bindings will not be overridden by other
modes), you may use `bind-keys* macro: (bind-keys* (\"C-o\" .  other-window)
(\"C-M-n\" .  forward-page) (\"C-M-p\" .  backward-page)) After Emacs loads, you can
see a summary of all your personal keybindings currently in effect with this
command: M-x describe-personal-keybindings This display will tell you if you've
overridden a default keybinding, and what the default was.  Also, it will tell
you if the key was rebound after your binding it with `bind-key', and what it
was rebound it to.  See the `use-package info manual for more information.")
   (license #f))
  )


;; post which-key cons integration
(define-public emacs-use-package
  (package
   (name "emacs-use-package")
   (version "20230203.2004")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/jwiegley/use-package.git")
		  (commit "77945e002f11440eae72d8730d3de218163d551e")))
	    (sha256
	     (base32
	      "1irr8a8r28n8c0c2x5w1flgv1f3z5jy2i5r5dknddiqa93b3rm84"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-bind-key))
   (arguments
    '(#:include '("^[^/]+.el$" "^[^/]+.el.in$"
		  "^dir$"
		  "^[^/]+.info$"
		  "^[^/]+.texi$"
		  "^[^/]+.texinfo$"
		  "^doc/dir$"
		  "^doc/[^/]+.info$"
		  "^doc/[^/]+.texi$"
		  "^doc/[^/]+.texinfo$")
      #:exclude '("^.dir-locals.el$" "^test.el$"
		  "^tests.el$"
		  "^[^/]+-test.el$"
		  "^[^/]+-tests.el$"
		  "^bind-key.el$"
		  "^bind-chord.el$"
		  "^use-package-chords.el$"
		  "^use-package-ensure-system-package.el$")))
   (home-page "https://github.com/jwiegley/use-package")
   (synopsis "A configuration macro for simplifying your .emacs")
   (description
    "The `use-package declaration macro allows you to isolate package configuration
in your init file in a way that is performance-oriented and, well, just tidy.  I
created it because I have over 80 packages that I use in Emacs, and things were
getting difficult to manage.  Yet with this utility my total load time is just
under 1 second, with no loss of functionality! See the `use-package info manual
for more information.")
   (license #f))
  )




(define-public emacs-julia-vterm
  (package
   (name "emacs-julia-vterm")
   (version "0.13")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/julia-vterm-" version
		  ".el"))
	    (sha256
	     (base32
	      "14lyjm89ybxgr4j52h1py0zmjk1rgm4fk26fp80gfk0pak6gkwa4"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-vterm))
   (home-page "https://github.com/shg/julia-vterm.el")
   (synopsis "A mode for Julia REPL using vterm")
   (description
    "This package provides a major-mode for inferior Julia process that runs in
vterm, and a minor-mode that extends julia-mode to support interaction with the
inferior Julia process.")
   (license #f))
  )


(define-public emacs-ob-julia-vterm 
  (package
   (name "emacs-ob-julia-vterm")
   (version "0.2")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/ob-julia-vterm-" version
		  ".el"))
	    (sha256
	     (base32
	      "1x0r7a49rb3zi8dc6cmy01k86mnc6pla7nxwgzkdfi1l0jk03nfv"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-julia-vterm))
   (home-page "https://github.com/shg/ob-julia-vterm.el")
   (synopsis "Babel Functions for Julia in VTerm")
   (description
    "Org-Babel support for Julia source code block using julia-vterm. ; Requirements:
This package uses julia-vterm to run Julia code.  You also need to have
Suppressor.jl package installed in your Julia environment to use :results
output. - https://github.com/shg/julia-vterm.el -
https://github.com/JuliaIO/Suppressor.jl See
https://github.com/shg/ob-julia-vterm.el for installation instructions.")
   (license #f))
  )

;; Don't work
(define-public emacs-cl-generic 
  (package
   (name "emacs-cl-generic")
   (version "0.3")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://elpa.gnu.org/packages/cl-generic-"
				version ".el"))
	    (sha256
	     (base32
	      "0vb338bhjpsnrf60qgxny4z5rjrnifahnrv9axd4shay89d894zq"))))
   (build-system emacs-build-system)
   (home-page "http://elpa.gnu.org/packages/cl-generic.html")
   (synopsis "Forward cl-generic compatibility for Emacs<25")
   (description
    "This is a forward compatibility package, which provides (a subset of) the
features of the cl-generic package introduced in Emacs-25, for use on previous
emacsen.  Make sure this is installed *late* in your `load-path`, i.e.  after
Emacs's built-in .../lisp/emacs-lisp directory, so that if/when you upgrade to
Emacs≥25, the built-in version of the file will take precedence, otherwise you
could get into trouble (although we try to hack our way around the problem in
case it happens).  AFAIK, the main incompatibilities between cl-generic and
EIEIO's defmethod are: - EIEIO does not support multiple dispatch.  We ignore
this difference here and rely on EIEIO to detect and signal the problem. - EIEIOonly supports primary, :before, and :after qualifiers.  We ignore this
difference here and rely on EIEIO to detect and signal the problem. - EIEIO doesnot support specializers other than classes.  We ignore this difference here andrely on EIEIO to detect and signal the problem. - EIEIO uses :static instead of
(subclass <foo>) and :static methods match both class arguments as well as
object argument of that class.  Here we turn (subclass <foo>) into a :static
qualifier and ignore the semantic difference, hoping noone will notice. -
EIEIO's defgeneric does not reset the function.  We ignore this difference and
hope for the best. - EIEIO uses `call-next-method and `next-method-p while
cl-defmethod uses `cl-next-method-p and `cl-call-next-method (simple matter of
renaming).  We handle that by renaming the calls in the `cl-defmethod macro. -
The errors signaled are slightly different.  We make cl-no-applicable-method
into a \"parent\" error of no-method-definition, which should cover the usual
cases. - EIEIO's no-next-method and no-applicable-method have different calling
conventions from cl-generic's.  We don't try to handle this, so just refrain
from trying to call (or add methods to) `cl-no-next-method or
`cl-no-applicable-method'. - EIEIO's `call-next-method and `next-method-p have
dynamic scope whereas cl-generic's `cl-next-method-p and `cl-call-next-method
are lexically scoped.  The cl-defmethod here handles the common subset between
the two.")
   (license gpl3+))
  )

(define-public emacs-julia-ts-mode 
(package
  (name "emacs-julia-ts-mode")
  (version "20230318.2210")
  (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/ronisbr/julia-ts-mode.git")
                  (commit "33ea957ef696155ad45a952d653a9ff18d45c866")))
            (sha256
             (base32
              "1pqsxdajrm5amvy51a9va2ycx8n4jhmv1a6frmdkjvdn127w2rg0"))))
  (build-system emacs-build-system)
  (propagated-inputs (list emacs-julia-mode))
  (home-page "https://github.com/ronisbr/julia-ts-mode")
  (synopsis "Major mode for Julia source code using tree-sitter")
  (description
   "This major modes uses tree-sitter for font-lock, indentation, imenu, and
navigation.  It is derived from `julia-mode'.")
  (license #f))
)



;; Don't work
;;(define-public emacs-eglot-jl 
;;  (package
;;   (name "emacs-eglot-jl")
;;   (version "2.2.1")
;;   (source (origin
;;	    (method url-fetch)
;;	    (uri (string-append "https://stable.melpa.org/packages/eglot-jl-"
;;				version ".tar"))
;;	    (sha256
;;	     (base32
;;	      "0i993vl9byp8xfdqrv20kfsnfggv8wihpv31npwmh82f7yi36kcz"))))
;;   (build-system emacs-build-system)
;;   ;;(propagated-inputs (list emacs-eglot emacs-project emacs-cl-generic))
;;   (propagated-inputs (list emacs-eglot emacs-project))
;;   (home-page "https://github.com/non-Jedi/eglot-jl")
;;   (synopsis "Julia support for eglot")
;;   (description
;;    "This package loads support for the Julia language server into eglot and
;;package.el.  This provides IDE-like features for editing julia-mode buffers.
;;After installing this package, to load support for the Julia language server,
;;run eglot-jl-init.  After that, running the eglot function in a julia-mode
;;buffer should work properly.")
;;   (license #f))
;;  )

;; From https://raw.githubusercontent.com/babariviere/guix-emacs/master/emacs/packages/melpa.scm
(define-public emacs-eglot-jl
  (package
   (name "emacs-eglot-jl")
   (version "20230117.1243")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/non-Jedi/eglot-jl.git")
	   (commit
	    "2e04597223553a369dd5b6520b6365b41e6ea508")))
     (sha256
      (base32
       "1zr5f5hvrj2i7a2yzrgbhdhzfwf6fxhj3p4ws85r0mgvk2kwwlll"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-eglot))
   ;;(arguments
   ;;  '(#:files (:defaults "*.jl" "*.toml")))
   (home-page
    "https://github.com/non-Jedi/eglot-jl")
   (synopsis "Julia support for eglot")
   (description
    "Documentation at https://melpa.org/#/eglot-jl")
   (license #f))
  )


(define-public emacs-dired-hacks-utils 
  (package
   (name "emacs-dired-hacks-utils")
   (version "20221127.1247")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/Fuco1/dired-hacks.git")
		  (commit "1596e516835099b96cb65d1dc372cfbdff6aea96")))
	    (sha256
	     (base32
	      "0fl6gfdl44790i83j4dxz0jglbyki3lgk3ghxq77b9fdy4rw922w"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-dash))
   (arguments
    '(#:include '("^dired-hacks-utils.el$")
      #:exclude '()))
   (home-page "unspecified")
   (synopsis "Utilities and helpers for dired-hacks collection")
   (description
    "Utilities and helpers for `dired-hacks collection of dired improvements.  This
package also provides these interactive functions: * `dired-hacks-next-file - goto next file, skipping empty and non-file lines * `dired-hacks-previous-file -
go to previous file, skipping empty and non-file lines *
`dired-utils-format-information-line-mode - Format the information (summary)
line file sizes to be human readable (e.g. 1GB instead of 1048576).  See
https://github.com/Fuco1/dired-hacks for the entire collection")
   (license #f))

  )


(define-public emacs-dired-subtree
  (package
   (name "emacs-dired-subtree")
   (version "20230118.1953")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/Fuco1/dired-hacks.git")
		  (commit "1596e516835099b96cb65d1dc372cfbdff6aea96")))
	    (sha256
	     (base32
	      "0fl6gfdl44790i83j4dxz0jglbyki3lgk3ghxq77b9fdy4rw922w"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-dash emacs-dired-hacks-utils))
   (arguments
    '(#:include '("^dired-subtree.el$")
      #:exclude '()))
   (home-page "unspecified")
   (synopsis "Insert subdirectories in a tree-like fashion")
   (description
    "Introduction ------------ The basic command to work with subdirectories in dired
is `i', which inserts the subdirectory as a separate listing in the active diredbuffer.  This package defines function `dired-subtree-insert which instead
inserts the subdirectory directly below its line in the original listing, and
indent the listing of subdirectory to resemble a tree-like structure (somewhat
similar to tree(1) except the pretty graphics).  The tree display is somewhat
more intuitive than the default \"flat\" subdirectory manipulation provided by
`i'.  There are several presentation options and faces you can customize to
change the way subtrees are displayed.  You can further remove the unwanted
lines from the subtree by using `k command or some of the built-in \"focusing\"
functions, such as `dired-subtree-only-* (see list below).  If you have the
package `dired-filter', you can additionally filter the subtrees with global or
local filters.  A demo of basic functionality is available on youtube:
https://www.youtube.com/watch?v=z26b8HKFsNE Interactive functions
--------------------- Here's a list of available interactive functions.  You canread more about each one by using the built-in documentation facilities of
emacs.  It is adviced to place bindings for these into a convenient prefix key
map, for example C-, * `dired-subtree-insert * `dired-subtree-remove *
`dired-subtree-toggle * `dired-subtree-cycle * `dired-subtree-revert *
`dired-subtree-narrow * `dired-subtree-up * `dired-subtree-down *
`dired-subtree-next-sibling * `dired-subtree-previous-sibling *
`dired-subtree-beginning * `dired-subtree-end * `dired-subtree-mark-subtree *
`dired-subtree-unmark-subtree * `dired-subtree-only-this-file *
`dired-subtree-only-this-directory If you have package `dired-filter',
additional command `dired-subtree-apply-filter is available.  See
https://github.com/Fuco1/dired-hacks for the entire collection.")
   (license #f))

  )

(define-public emacs-dired-sidebar
  (package
   (name "emacs-dired-sidebar")
   (version "20230216.432")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/jojojames/dired-sidebar.git")
		  (commit "5569d3b53585f5413cf87a694650d0fd6e040803")))
	    (sha256
	     (base32
	      "1vkdaw09vdjm583b0cdql991d76cqb1wkis3vzfhdy22hmy38wh7"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-dired-subtree))
   (home-page "https://github.com/jojojames/dired-sidebar")
   (synopsis "Tree browser leveraging dired")
   (description
    "This package provides a tree browser similar to `neotree or `treemacs but
leverages `dired to do the job of display. (use-package dired-sidebar :bind
((\"C-x C-n\" .  dired-sidebar-toggle-sidebar)) :ensure nil :commands
(dired-sidebar-toggle-sidebar))")
   (license #f))
  )


(define-public emacs-ibuffer-sidebar
  (package
   (name "emacs-ibuffer-sidebar")
   (version "20210508.836")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/jojojames/ibuffer-sidebar.git")
		  (commit "fb685e1e43db979e25713081d8ae4073453bbd5e")))
	    (sha256
	     (base32
	      "04x87gngmvyj4nfq1dm3h9jr6b0kvikxsg1533kdkz9k72khs3n3"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/jojojames/ibuffer-sidebar")
   (synopsis "Sidebar for `ibuffer'")
   (description
    "This package provides a sidebar interface similar to `dired-sidebar', but for
`ibuffer'. (use-package ibuffer-sidebar :bind ((\"C-x C-b\" .
ibuffer-sidebar-toggle-sidebar)) :ensure nil :commands
(ibuffer-sidebar-toggle-sidebar))")
   (license #f))
  )

(define-public emacs-tabspaces
  (package
   (name "emacs-tabspaces")
   (version "20230307.2235")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/mclear-tools/tabspaces.git")
		  (commit "315a5b375f9276f9725991c42a7c8a63ff26d51f")))
	    (sha256
	     (base32
	      "05xfj39rhwx73f6wzwgs6vmlkz8qrykg853i054b1kbywpawjlzf"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-project))
   (home-page "https://github.com/mclear-tools/tabspaces")
   (synopsis "Leverage tab-bar and project for buffer-isolated workspaces")
   (description
    "This package provides several functions to facilitate a single frame-based
workflow with one workspace per tab, integration with project.el (for
project-based workspaces) and buffer isolation per tab (i.e.  a \"tabspace\"
workspace).  The package assumes project.el and tab-bar.el are both present
(they are built-in to Emacs 27.1+).  This file is not part of GNU Emacs. ;
Acknowledgements Much of the package code is inspired by: -
https://github.com/kaz-yos/emacs -
https://github.com/wamei/elscreen-separate-buffer-list/issues/8 -
https://www.rousette.org.uk/archives/using-the-tab-bar-in-emacs/ -
https://github.com/minad/consult#multiple-sources -
https://github.com/florommel/bufferlo")
   (license #f))

  )

(define-public emacs-embark-consult
(package
  (name "emacs-embark-consult")
  (version "20230327.1843")
  (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/oantolin/embark.git")
                  (commit "846b3fd311d06dd0f9aa20f133907ae10855c9ae")))
            (sha256
             (base32
              "18kyh2pfzyvy3nx60wln255x1qqbncr4hlnjq7fd82aklghcdjc6"))))
  (build-system emacs-build-system)
  (propagated-inputs (list emacs-embark emacs-consult))
  (arguments
   '(#:include '("^embark-consult.el$")
     #:exclude '()))
  (home-page "https://github.com/oantolin/embark")
  (synopsis "Consult integration for Embark")
  (description
   "This package provides integration between Embark and Consult.  The package will
be loaded automatically by Embark.  Some of the functionality here was
previously contained in Embark itself: - Support for consult-buffer, so that you
get the correct actions for each type of entry in consult-buffer's list. -
Support for consult-line, consult-outline, consult-mark and consult-global-mark,
so that the insert and save actions don't include a weird unicode character at
the start of the line, and so you can export from them to an occur buffer (where
occur-edit-mode works!).  Just load this package to get the above functionality,
no further configuration is necessary.  Additionally this package contains some
functionality that has never been in Embark: access to Consult preview from
auto-updating Embark Collect buffer that is associated to an active minibuffer
for a Consult command.  For information on Consult preview, see Consult's info
manual or its readme on GitHub.  If you always want the minor mode enabled
whenever it possible use: (add-hook embark-collect-mode-hook
#'consult-preview-at-point-mode) If you don't want the minor mode automatically
on and prefer to trigger the consult previews manually use this instead:
(keymap-set embark-collect-mode-map \"C-j\" #'consult-preview-at-point)")
  (license #f))
)

;; TODO: repair
(define-public python-tinytag 
(package
  (name "python-tinytag")
  (version "1.8.1")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "tinytag" version))
            (sha256
             (base32
              "0vb3hy2dpmb55qip1msl89xiryqmm6mn385ad25mk99ig08b6fin"))))
  (build-system python-build-system)
  (native-inputs (list python-flake8 python-pytest python-pytest-cov))
  (home-page "https://github.com/devsnd/tinytag")
  (synopsis
   "Read music meta data and length of MP3, OGG, OPUS, MP4, M4A, FLAC, WMA and Wave files")
  (description
   "Read music meta data and length of MP3, OGG, OPUS, MP4, M4A, FLAC, WMA and Wave
files")
  (license license:expat))

)


;; guix version don't have access to spinner symbol for lsp 
;; error in process filter: Symbol’s function definition is void: eglot--spinner

(define-public emacs-doom-modeline 
(package
  (name "emacs-doom-modeline")
  (version "20230415.1710")
  (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/seagle0128/doom-modeline.git")
                  (commit "ed72a56f4b1ae7c13cfb14aa17c77b9400fd222f")))
            (sha256
             (base32
              "007c666c49g4h8nn4wizmnwfgvsgmql48n17499nm3ambk2jcysk"))))
  (build-system emacs-build-system)
  (propagated-inputs (list emacs-compat emacs-shrink-path))
  (home-page "https://github.com/seagle0128/doom-modeline")
  (synopsis "A minimal and modern mode-line")
  (description
   "This package offers a fancy and fast mode-line inspired by minimalism design.
It's integrated into Doom Emacs (https://github.com/hlissner/doom-emacs) and
Centaur Emacs (https://github.com/seagle0128/.emacs.d).  The doom-modeline
offers: - A match count panel (for anzu, iedit, multiple-cursors,
symbol-overlay, evil-search and evil-substitute) - An indicator for recording a
macro - Current environment version (e.g. python, ruby, go, etc.) in the
major-mode - A customizable mode-line height (see doom-modeline-height) - A
minor modes segment which is compatible with minions - An error/warning count
segment for flymake/flycheck - A workspace number segment for eyebrowse - A
perspective name segment for persp-mode - A window number segment for winum and
window-numbering - An indicator for modal editing state, including evil,
overwrite, god, ryo and xah-fly-keys, etc. - An indicator for battery status -
An indicator for current input method - An indicator for debug state - An
indicator for remote host - An indicator for LSP state with lsp-mode or eglot -
An indicator for github notifications - An indicator for unread emails with
mu4e-alert - An indicator for unread emails with gnus (basically builtin) - An
indicator for irc notifications with circe, rcirc or erc. - An indicator for
buffer position which is compatible with nyan-mode or poke-line - An indicator
for party parrot - An indicator for PDF page number with pdf-tools - An
indicator for markdown/org previews with grip - Truncated file name, file icon,
buffer state and project name in buffer information segment, which is compatible
with project, find-file-in-project and projectile - New mode-line for Info-mode
buffers - New package mode-line for paradox - New mode-line for helm buffers -
New mode-line for git-timemachine buffers Installation: From melpa, `M-x
package-install RET doom-modeline RET`.  In `init.el`, (require doom-modeline)
(doom-modeline-mode 1) or (use-package doom-modeline :ensure t :hook (after-init
.  doom-modeline-mode))")
  (license #f))
)

(define-public emacs-ess-view-data 
  (package
   (name "emacs-ess-view-data")
   (version "20220927.353")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/ShuguangSun/ess-view-data.git")
		  (commit "1b48afef4dcc8fbaed1af98fade7f0df84bd6871")))
	    (sha256
	     (base32
	      "0nybmqj166a5qrhcn0a7mlwdwfijm8hgzizvd3lycycak3ixq6xf"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-ess emacs-csv-mode))
   (home-page "https://github.com/ShuguangSun/ess-view-data")
   (synopsis "View Data")
   (description
    "Customization: ess-view-data-backend-list: dplyr (default), dplyr+DT,
data.table+magrittr ess-view-data-print-backend-list: print (default), kable
ess-view-data-save-backend-list: write.csv (default), readr::write_csv,
data.table::fwrite kable ess-view-data-complete-backend-list: jsonlite
ess-view-data-read-string: ess-completing-read (default), completing-read,
ido-completing-read, ivy-completing-read Utils: NOTE: it will make a copy of the
data and then does the following action ess-view-data-print: the main function
to view data Example: In a ess-r buffer or a Rscript buffer, `M-x
ess-view-data-print` and input `mtcars`.  ess-view-data-set-backend: change
backend ess-view-data-toggle-maxprint: toggle limitation of lines per page to
print ess-view-data-verbs Example: In the ESS-V buffer, `M-x
ess-view-data-verbs` and select the verb to do with.  ess-view-data-filter
Example: In the ESS-V buffer, `M-x ess-view-data-filter`, `cyl <RET> mpg` to
select columns and <C-j> to finish input.  An indirect buffer pops up and
data-masking Expressions can be edited.  ess-view-data-select /
ess-view-data-unselect Example: In the ESS-V buffer, `M-x ess-view-data-select`,
`cyl <RET> mpg` to select columns and <C-j> to finish input.  ess-view-data-sort
ess-view-data-group / ess-view-data-ungroup ess-view-data-mutate
ess-view-data-slice ess-view-data-wide2long / ess-view-data-long2wide
ess-view-data-update ess-view-data-reset Example: In the ESS-V buffer, `M-x
ess-view-data-reset`, an indirect buffer pops up and the action history can be
edited.  ess-view-data-unique ess-view-data-count Example: In the ESS-V buffer,
`M-x ess-view-data-count`, `cyl <RET> mpg` to select columns and <C-j> to finish
input.  In the updated buffer with count information, `M-x ess-view-data-print`
to go back.  ess-view-data-summarise ess-view-data-overview
ess-view-data-goto-page / -next-page / -preious-page / -first-page / -last-page
/ -page-number ess-view-data-save")
   (license #f))
  )


;;
;; Manifest
;;
(concatenate-manifests
 (list
  (specifications->manifest
   (list
    "emacs-next-pgtk" ;; Emacs text editor with `pgtk' and `tree-sitter' support
    ;;"emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
    "emacs-guix" ;; Emacs interface for GNU Guix

    "emacs-evil" ;; Extensible Vi layer for Emacs
    "emacs-evil-collection" ;; Collection of Evil bindings for many major and minor modes
    "emacs-undo-fu" ;; Simple, stable linear undo with redo for Emacs

    "emacs-ess" ;; Emacs mode for statistical analysis programs


    "emacs-vterm" ;; Emacs libvterm integration
    "emacs-vterm-toggle" ;; Toggle between a vterm buffer and other buffers
    "emacs-multi-vterm" ;; Manage multiple vterm buffers in Emacs
    "emacs-julia-mode" ;; Major mode for Julia
    ;;"emacs-julia-repl" ;; Minor mode for interacting with a Julia REPL ;; Replaced by julia-vterm since support org-babel via ob-julia-vterm
    "emacs-no-littering" ;; Help keep `~/.emacs.d/' clean
    "emacs-pdf-tools" ;; Emacs support library for PDF files

    "emacs-vertico" ;; Vertical interactive completion
    "emacs-orderless" ;; Emacs completion style that matches multiple regexps in any order
    "emacs-embark" ;; Emacs mini-buffer actions rooted in keymaps
    "emacs-marginalia" ;; Marginalia in the minibuffer completions
    "emacs-corfu" ;; Completion overlay region function
    "emacs-kind-icon" ;; Completion kind icons in Emacs

    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries
    "emacs-emprise" ;; Control MPRIS supported media players from Emacs
    "emacs-marginalia-emprise" ;; Annotate Emprise with Marginalia
    "emacs-which-key" ;; Display available key bindings in popup 
    "emacs-general" ;; More convenient key definitions in emacs
    "emacs-org-modern" ;; Modern Org Style
    "emacs-evil-org" ;; Evil keybindings for Org mode
    ;;"emacs-nano-modeline" ;; Emacs minor mode controlling mode line
    ;;"emacs-simple-modeline" ;; Simple mode-line configuration for Emacs

    "emacs-f" ;; Emacs API for working with files and directories 
    "emacs-s" ;; Emacs string manipulation library
    "emacs-dash"

    "emacs-mixed-pitch" ;; Mix variable- and fixed-pitch fonts in the same Emacs buffer

    "emacs-org-pomodoro" ;; Pomodoro technique for org-mode
    "emacs-org-appear" ;; Make invisible parts of Org fragments appear visible

    "emacs-mood-line" ;; Minimal mode-line for Emacs
    "font-fira-code"
    "font-fira-mono"
    "font-fira-sans"

    ;;"emacs-doom-modeline" ;; Fancy and fast mode-line inspired by minimalism design
    "emacs-minions" ;; Minor-mode menu for the mode line

    "emacs-magit" ;; Emacs interface for the Git version control system
    "emacs-magit-todos" ;; Show source files' TODOs (and FIXMEs, etc) in Magit status buffer
    "emacs-magit-org-todos-el" ;; Get todo.org into Emacs Magit status

    "emacs-forge" ;; Access Git forges from Magit
    ;;"emacs-dired-sidebar" ;; Sidebar for Emacs using Dired ;; problem with git versioned project, version too old
    "emacs-dired-git-info" ;; Show git info in Emacs Dired
    "emacs-solaire-mode" ;; Change background of file-visiting buffers in Emacs
    "emacs-all-the-icons" ;; Collect icon fonts and propertize them within Emacs
    "emacs-all-the-icons-ibuffer" ;; Display icons for all buffers in ibuffer
    "emacs-all-the-icons-dired" ;; Show icons for each file in `dired-mode'
    "emacs-all-the-icons-completion" ;; Add icons to completion candidates 

    "emacs-org-auto-tangle" ;; Automatically tangle code blocks on save

    "emacs-pass" ;; Major mode for `password-store.el'
    "emacs-password-store" ;; Password store (pass) support for Emacs
    "emacs-password-store-otp" ;; Interact with the `pass-otp' extension for `pass' from Emacs

    "emacs-geiser" ;; Collection of Emacs modes for Scheme hacking 

    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries

    "emacs-doom-themes" ;; Wide collection of color themes for Emacs
    "emacs-hide-mode-line" ;; Emacs plugin that hides the mode-line

    ;;"emacs-emms" ;; The Emacs Multimedia System ;; miss mpd-prev
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    ;;"python-flake8" ;; The modular source code checker: pep8, pyflakes and co
    "emacs-mpv" ;; Control MPV for easy note taking
    ;;"emacs-emms-mode-line-cycle" ;;  Display the EMMS mode line as a ticker

    "python-lsp-server" ;; Python implementation of the Language Server Protocol

    "emacs-bluetooth" ;; Manage Bluetooth devices using Emacs

    "emacs-org-roam" ;; Non-hierarchical note-taking with Org mode
    "emacs-org-roam-ui" ;; Web User Interface for Org Roam
    "emacs-websocket" ;;  Emacs WebSocket client and server 
    "emacs-citar-org-roam" ;; Emacs package to provide tighter Citar and Org-Roam integration
    "emacs-consult-org-roam" ;; Consult integration for Org Roam

    ;;"git"


    "emacs-sly" ;; Sylvester the Cat's Common Lisp IDE 

    "emacs-dashboard" ;; Startup screen extracted from Spacemacs
    "emacs-page-break-lines" ;; Display page breaks as tidy horizontal lines

    "emacs-langtool" ;; Emacs interface to LanguageTool
    "tree-sitter"

    "emacs-straight-el" ;; Purely functional package manager for the Emacs hacker
    "emacs-poly-r" ;; Polymodes for the R language
    "emacs-polymode-markdown" ;; Polymode for Markdown mode

    "emacs-org-superstar" ;; Prettify headings and plain lists in Org mode
    "emacs-org-fancy-priorities" ;; Display org priorities as custom strings 

    "emacs-nyxt" ;; Interact with Nyxt from Emacs

    "emacs-pinentry" ;; GnuPG Pinentry server implementation

    ))
  (packages->manifest (list
		       emacs-julia-vterm
		       emacs-ob-julia-vterm
		       ;;emacs-cl-generic
		       ;;emacs-julia-ts-mode ;; wrong emacs version when building
		       ;;emacs-eglot-jl
		       emacs-dired-sidebar
		       emacs-ibuffer-sidebar
		       emacs-tabspaces
		       emacs-use-package
		       emacs-emms
		       ;;python-tinytag ;; don't work
		       emacs-doom-modeline
		       emacs-ess-view-data
		       emacs-all-the-icons
		       ))
  ))
