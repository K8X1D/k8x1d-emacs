;;
;; Modules
;;
(use-modules (guix packages)
	     (guix git-download)
	     (guix build-system emacs)
	     (gnu packages emacs-xyz)
	     (guix download)
	     (guix licenses))

;;
;; Packages
;;

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


;;
;; Manifest
;;
(concatenate-manifests
 (list
  (specifications->manifest
   (list
    ;;"emacs-next-pgtk" ;; Emacs text editor with `pgtk' and `tree-sitter' support
    "emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
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
    "emacs-corfu" ;; Completion overlay region function
    "emacs-embark" ;; Emacs mini-buffer actions rooted in keymaps
    "emacs-marginalia" ;; Marginalia in the minibuffer completions
    "emacs-orderless" ;; Emacs completion style that matches multiple regexps in any order
    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries
    "emacs-emprise" ;; Control MPRIS supported media players from Emacs
    "emacs-marginalia-emprise" ;; Annotate Emprise with Marginalia
    "emacs-which-key" ;; Display available key bindings in popup 
    "emacs-general" ;; More convenient key definitions in emacs
    "emacs-org-modern" ;; Modern Org Style
    "emacs-evil-org" ;; Evil keybindings for Org mode
    ;;"emacs-nano-modeline" ;; Emacs minor mode controlling mode line
    ;;"emacs-simple-modeline" ;; Simple mode-line configuration for Emacs


    "emacs-mixed-pitch" ;; Mix variable- and fixed-pitch fonts in the same Emacs buffer

    "emacs-org-pomodoro" ;; Pomodoro technique for org-mode
    "emacs-org-appear" ;; Make invisible parts of Org fragments appear visible

    "emacs-mood-line" ;; Minimal mode-line for Emacs
    "font-fira-code"
    "font-fira-mono"
    "font-fira-sans"

    "emacs-doom-modeline" ;; Fancy and fast mode-line inspired by minimalism design
    "emacs-minions" ;; Minor-mode menu for the mode line

    "emacs-magit" ;; Emacs interface for the Git version control system
    "emacs-magit-org-todos-el" ;; Get todo.org into Emacs Magit status
    "emacs-magit-todos" ;; Show source files' TODOs (and FIXMEs, etc) in Magit status buffer
    "emacs-forge" ;; Access Git forges from Magit
    ;;"emacs-dired-sidebar" ;; Sidebar for Emacs using Dired ;; problem with git versioned project, version too old
    "emacs-dired-git-info" ;; Show git info in Emacs Dired
    "emacs-solaire-mode" ;; Change background of file-visiting buffers in Emacs
    "emacs-all-the-icons-ibuffer" ;; Display icons for all buffers in ibuffer
    "emacs-all-the-icons-dired" ;; Show icons for each file in `dired-mode'
    "emacs-org-auto-tangle" ;; Automatically tangle code blocks on save

    "emacs-pass" ;; Major mode for `password-store.el'
    "emacs-password-store" ;; Password store (pass) support for Emacs
    "emacs-password-store-otp" ;; Interact with the `pass-otp' extension for `pass' from Emacs

    "emacs-geiser" ;; Collection of Emacs modes for Scheme hacking 

    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries

    "emacs-doom-themes" ;; Wide collection of color themes for Emacs

    "emacs-emms" ;; The Emacs Multimedia System

    "python-lsp-server" ;; Python implementation of the Language Server Protocol

    "emacs-bluetooth" ;; Manage Bluetooth devices using Emacs

    "emacs-org-roam" ;; Non-hierarchical note-taking with Org mode
    "emacs-org-roam-ui" ;; Web User Interface for Org Roam
    "emacs-citar-org-roam" ;; Emacs package to provide tighter Citar and Org-Roam integration
    "emacs-consult-org-roam" ;; Consult integration for Org Roam

    "git"


    "emacs-sly" ;; Sylvester the Cat's Common Lisp IDE 

    "emacs-dashboard" ;; Startup screen extracted from Spacemacs
    "emacs-page-break-lines" ;; Display page breaks as tidy horizontal lines

    "emacs-langtool" ;; Emacs interface to LanguageTool
    ))
  (packages->manifest (list
		       emacs-julia-vterm
		       emacs-ob-julia-vterm
		       ;;emacs-cl-generic
		       emacs-eglot-jl
		       emacs-dired-sidebar
		       emacs-ibuffer-sidebar
		       emacs-tabspaces
		       ))
  ))
