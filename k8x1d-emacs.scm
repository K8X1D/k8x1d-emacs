;;
;; Modules
;;
(use-modules (guix packages)
	     (guix git-download)

	     (guix build-system emacs)
	     (guix build-system python)
	     (guix build-system gnu)

	     (gnu packages emacs-xyz)
	     (gnu packages python-xyz)
	     (gnu packages check)
	     (gnu packages statistics)

	     (guix download)
	     (guix licenses)
	     (guix status)

	     ((guix build emacs-build-system)
	      #:select (%default-include %default-exclude))
	     (guix store)
	     (guix utils)
	     (guix gexp)
	     (guix monads)
	     (guix search-paths)
	     (guix build-system)
	     (guix build-system gnu)

	     (gnu packages python)
	     (gnu packages python-crypto)


	     ((guix licenses) #:prefix license:))


;;
;; Modules
;;

;; Create building module for emacs with version > 29
(define (emacs-treesitter)
  "Return the treesitter Emacs package."
  ;; Lazily resolve the binding to avoid a circular dependency.
  (let ((emacs-mod (resolve-interface '(gnu packages emacs))))
    (module-ref emacs-mod 'emacs-next-tree-sitter)))

(define* (lower name
		#:key source inputs native-inputs outputs system target
		(emacs (emacs-treesitter))
		#:allow-other-keys
		#:rest arguments)
  "Return a bag for NAME."
  (define private-keywords
    '(#:target #:emacs #:inputs #:native-inputs))

  (and (not target)                               ;XXX: no cross-compilation
       (bag
	(name name)
	(system system)
	(host-inputs `(,@(if source
			     `(("source" ,source))
			     '())
		       ,@inputs

		       ;; Keep the standard inputs of 'gnu-build-system'.
		       ,@(standard-packages)))
	(build-inputs `(("emacs" ,emacs)
			,@native-inputs))
	(outputs outputs)
	(build emacs-build)
	(arguments (strip-keyword-arguments private-keywords arguments)))))

(define emacs-next-build-system
  (build-system
   (name 'emacs)
   (description "The build system for Emacs packages")
   (lower lower)))

;;
;; Packages
;;


(define-public emacs-ibuffer-project
  (package
   (name "emacs-ibuffer-project")
   (version "2.1")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/ibuffer-project-"
		  version ".tar"))
	    (sha256 (base32
		     "1zsr0mpkm7762cfghp51pgm1av2fv9djjbi1m9yh3hiv0k7aajr4"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/muffinmad/emacs-ibuffer-project")
   (synopsis "Group ibuffer's list by project or any function")
   (description
    "This pacakage provides ibuffer filtering and sorting functions to group buffers
by function or regexp applied to `default-directory'.  By default buffers are
grouped by `project-current or by `default-directory'.  Buffer group and group
type name is determined by function or regexp listed in
`ibuffer-project-root-functions'.  E.g.  by adding `file-remote-p like this:
(add-to-list ibuffer-project-root-functions (file-remote-p . \"Remote\")) remote
buffers will be grouped by protocol and host.  To group buffers set
`ibuffer-filter-groups to result of `ibuffer-project-generate-filter-groups
function: (add-hook ibuffer-hook (lambda () (setq ibuffer-filter-groups
(ibuffer-project-generate-filter-groups)))) This package also provides column
with filename relative to project.  If there are no file in buffer then column
will display `buffer-name with `font-lock-comment-face face.  Add
project-file-relative to `ibuffer-formats': (custom-set-variables
(ibuffer-formats ((mark modified read-only locked \" \" (name 18 18 :left :elide)
\" \" (size 9 -1 :right) \" \" (mode 16 16 :left :elide) \" \"
project-file-relative)))) It's also possible to sort buffers by that column by
calling `ibuffer-do-sort-by-project-file-relative or: (add-hook ibuffer-hook
(lambda () (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
(unless (eq ibuffer-sorting-mode project-file-relative)
(ibuffer-do-sort-by-project-file-relative)))) To avoid calculating project root
each time, one can set `ibuffer-project-use-cache'.  Root info per directory
will be stored in the `ibuffer-project-roots-cache variable.  Command
`ibuffer-project-clear-cache allows to clear project info cache.")
   (license #f))
  )



(define-public emacs-org-appear
  (package
   (name "emacs-org-appear")
   (version "20220617.2355")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/awth13/org-appear.git")
		  (commit "eb9f9db40aa529fe4b977235d86494b115281d17")))
	    (sha256 (base32
		     "1hawkx6sgh52bg7rj22x148hx8hby276xmqks3kxyzvrxzi8yav9"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-org))
   (home-page "https://github.com/awth13/org-appear")
   (synopsis "Auto-toggle Org elements")
   (description
    "This package enables automatic visibility toggling of various Org elements
depending on cursor position.  It supports automatic toggling of emphasis
markers, links, subscripts and superscripts, entities, and keywords.  By
default, toggling is instantaneous and only affects emphasis markers.  If Org
mode custom variables that control visibility of elements are configured to show
hidden parts, the respective `org-appear settings do not have an effect.")
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

(define-public emacs-julia-ts-mode 
  (package
   (name "emacs-julia-ts-mode")
   (version "0.2.5")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/julia-ts-mode-" version
		  ".tar"))
	    (sha256 (base32
		     "07l349nzw1qxn4i28ixy5gr3a0h3xq9044i4r3fsqc0s9nc4d8qw"))))
   (build-system emacs-next-build-system)
   (propagated-inputs (list emacs-julia-mode))
   (home-page "https://github.com/ronisbr/julia-ts-mode")
   (synopsis "Major mode for Julia source code using tree-sitter")
   (description
    "This major modes uses tree-sitter for font-lock, indentation, imenu, and
    navigation.  It is derived from `julia-mode'.")
   (license #f))
  )


(define-public emacs-r-vterm
  (package
   (name "emacs-r-vterm")
   (version "0.1")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://gitlab.com/K8X1D/r-vterm.git")
		  (commit "51c116208b62cd022049420477c10f0d0bc328cb")))
	    (sha256
	     (base32
	      "1j1a4msmgxw7ykmxsqf7ci6bzhbrk1z259iddrdp4li9hg59wx1n"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-vterm))
   (home-page "https://github.com/shg/julia-vterm.el")
   (synopsis "A mode for Julia REPL using vterm")
   (description
    "This package provides a major-mode for inferior R process that runs in
    vterm, and a minor-mode that extends ess-R-mode to support interaction with the
    inferior R process. (is a clone of julia-vterm")
   (license #f))
  )



(define-public emacs-eglot-ltex
  (package
   (name "emacs-eglot-ltex")
   (version "0.1.0")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/emacs-languagetool/eglot-ltex.git")
		  (commit "95cf7a920c59ea8bdcf81e3f3250aef180214ac7")))
	    (sha256
	     (base32
	      "0an3x9d972lyr3byw7cvw3xhmbrf7z34y2mb3blvmlp18gmaf0hv"))
	    ))
   (build-system emacs-next-build-system)
   (propagated-inputs (list emacs-vterm emacs-f))
   (home-page "https://github.com/emacs-languagetool/eglot-ltex")
   (synopsis "Eglot Clients for LTEX")
   (description
    "Eglot client leveraging LTEX Language Server.")
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
   (build-system emacs-next-build-system)
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

(define-public emacs-auctex-latexmk
  (package
   (name "emacs-auctex-latexmk")
   (version "20221025.1219")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/emacsmirror/auctex-latexmk.git")
		  (commit "b00a95e6b34c94987fda5a57c20cfe2f064b1c7a")))
	    (sha256
	     (base32
	      "0bbvb4aw9frg4fc0z9qkc5xd2s9x65k6vdscy5svsy0h17iacsbb"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-auctex))
   (home-page "https://github.com/tom-tan/auctex-latexmk/")
   (synopsis "Add LatexMk support to AUCTeX")
   (description
    "This library adds LatexMk support to AUCTeX. Requirements: * AUCTeX * LatexMk *
    TeXLive (2011 or later if you write TeX source in Japanese) To use this package,
    add the following line to your .emacs file: (require auctex-latexmk)
    (auctex-latexmk-setup) And add the following line to your .latexmkrc file: #
    .latexmkrc starts $pdf_mode = 1; # .latexmkrc ends After that, by using M-x
    TeX-command-master (or C-c C-c), you can use LatexMk command to compile TeX
    source.  For Japanese users: LatexMk command automatically stores the encoding
    of a source file and passes it to latexmk via an environment variable named
    \"LATEXENC\".  Here is the example of .latexmkrc to use \"LATEXENC\": # .latexmkrc
    starts $kanji = \"-kanji=$ENV{\\\"LATEXENC\\\"}\" if defined $ENV{\"LATEXENC\"}; $latex
    = \"platex $kanji\"; $bibtex = \"pbibtex $kanji\"; $dvipdf = dvipdfmx -o %D %S';
    $pdf_mode = 3; # .latexmkrc ends")
   (license #f))
  )

(define-public emacs-tab-bar-echo-area
  (package
   (name "emacs-tab-bar-echo-area")
   (version "20221115.1953")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/fritzgrabo/tab-bar-echo-area.git")
		  (commit "3ab62ca7db3c1d83f96b7971ea4b3b0101b51ae9")))
	    (sha256 (base32
		     "0grapqwfqjbi9yzcirgd8gmkg4zkplagwvdyal4jd4aajnnx6sh8"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/fritzgrabo/tab-bar-echo-area")
   (synopsis "Display tab names of the tab bar in the echo area")
   (description
    "This package provides a global minor mode to temporarily display a list of
available tabs and tab groups (with the current tab and group highlighted) in
the echo area after tab-related commands.  This is intended to be used as an
unobtrusive replacement for the Emacs built-in display of the tab bar (that is,
when you have `tab-bar-show set to nil).  The idea is to provide but a quick
visual orientation aid to the user after tab-related commands, and then get out
of the way again.  I recommend using this together with the
tab-bar-lost-commands package, which provides simple and convenient commands
that help with common tab bar use-cases regarding the creation, selection and
movement of tabs.  You might also want to check out the tab-bar-groups package,
which backports a simplified version of Emacs 28 tab groups to Emacs 27 and
provides an integration with this package.")
   (license #f))
  )

(define-public emacs-emms 
  (package
   (name "emacs-emms")
   (version "20230619.1857")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://git.savannah.gnu.org/git/emms.git")
		  (commit "9e08a4b081abcf18c375214a50ff47f8919f8ab1")))
	    (sha256 (base32
		     "1hzvga5pqfndrhja3gkv382qrb7nvd9kxds9sphpr2s6f17wcwl2"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-nadvice emacs-seq))
   (arguments '(#:include '("^[^/]+.el$" "^[^/]+.el.in$"
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
In fact, it doesn't even know how to find any tracks to consider playing --- for
this, you need sources.  A sample configuration is offered in emms-setup.el, and
the Friendly Manual in the doc/ directory is both detailed, and kept up to date.")
   (license #f))
  )

(define-public emacs-eglot-jl 
  (package
   (name "emacs-eglot-jl")
   (version "20230601.1335")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/non-Jedi/eglot-jl.git")
		  (commit "7dc604fe42a459a987853d065cd6d0f3c4cbc02a")))
	    (sha256 (base32
		     "0ska1i7n2ykyxm3w64661x24ycfdn2vl7px0hv33llg2sbd9famf"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-eglot emacs-project emacs-cl-generic))
   (arguments '(#:include '("^[^/]+.el$" "^[^/]+.el.in$"
			    "^dir$"
			    "^[^/]+.info$"
			    "^[^/]+.texi$"
			    "^[^/]+.texinfo$"
			    "^doc/dir$"
			    "^doc/[^/]+.info$"
			    "^doc/[^/]+.texi$"
			    "^doc/[^/]+.texinfo$"
			    "^[^/]+.jl$"
			    "^[^/]+.toml$")
		#:exclude '("^.dir-locals.el$" "^test.el$" "^tests.el$"
			    "^[^/]+-test.el$" "^[^/]+-tests.el$")))
   (home-page "https://github.com/non-Jedi/eglot-jl")
   (synopsis "Julia support for eglot")
   (description
    "This package loads support for the Julia language server into eglot and
 package.el.  This provides IDE-like features for editing julia-mode buffers.
 After installing this package, to load support for the Julia language server,
 run eglot-jl-init.  After that, running the eglot function in a julia-mode
 buffer should work properly.")
   (license #f))
  )


(define-public emacs-dashboard
  (package
   (name "emacs-dashboard")
   (version "1.7.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/dashboard-" version
		  ".tar"))
	    (sha256 (base32
		     "1c0x369x6fp156r2kv3pw7yh0cp34271dvly4l96r3apa1yn1by6"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-page-break-lines))
   (home-page "https://github.com/emacs-dashboard/emacs-dashboard")
   (synopsis "A startup screen extracted from Spacemacs")
   (description
    "An extensible Emacs dashboard, with sections for bookmarks, projectile projects,
org-agenda and more.")
   (license #f))
  )

;; Set emacs version according to window system
(define emacs-distribution 
  (if (equal? (getenv "XDG_SESSION_TYPE") "x11")
      "emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
      "emacs-next-pgtk") ;; Emacs text editor with `pgtk' and `tree-sitter' support
  )

;;(display emacs-distribution)

;; Don't build, org-noter is missing
(define-public emacs-org-pdftools 
  (package
   (name "emacs-org-pdftools")
   (version "20220320.301")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/fuxialexander/org-pdftools.git")
		  (commit "967f48fb5038bba32915ee9da8dc4e8b10ba3376")))
	    (sha256 (base32
		     "0f47ww8r00b7lb1msybnmnqdhm9i2vwz5lrz9m9bn6gbh97mzhn8"))))
   (build-system emacs-next-build-system)
   (propagated-inputs (list emacs-org emacs-pdf-tools emacs-org-noter))
   (arguments '(#:include '("^org-pdftools.el$")
		#:exclude '()))
   (home-page "https://github.com/fuxialexander/org-pdftools")
   (synopsis "Support for links to documents in pdfview mode")
   (description
    "Add support for org links from pdftools buffers with more precise location
control.  https://github.com/fuxialexander/org-pdftools/")
   (license #f))
  )


(define-public emacs-lsp-bridge
  (package
   (name "emacs-lsp-bridge")
   (version "0.1")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/manateelazycat/lsp-bridge.git")
		  (commit "e959f3dd930dadb8b929a2ff5e93bb547e5ddb52")))
	    (sha256 (base32
		     "0fcjjm0sa7fwm2kfv2gcyg5nnnynpqhqlaaz233blja4jbw5rgl2"))))
   (build-system emacs-next-build-system)
   ;;(arguments '(#:tests? #f))

   ;;(build-system python-build-system)
   (propagated-inputs (list python python-epc python-sexpdata python-six python-paramiko emacs-markdown-mode emacs-yasnippet))
   (home-page "https://github.com/manateelazycat/lsp-bridge")
   (synopsis " A blazingly fast LSP client for Emacs")
   (description
    "Python LSP client implementation for the Emacs ecosystem")
   (license #f))
  )


(define-public emacs-empv
  (package
   (name "emacs-empv")
   (version "4.0.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://stable.melpa.org/packages/empv-"
				version ".tar"))
	    (sha256 (base32
		     "1hrf1kbvg6j79jypq6gj0lzhx92vnn7yz5vq5njganh10adhrazd"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-s))
   (home-page "https://github.com/isamert/empv.el")
   (synopsis "A multimedia player/manager, YouTube interface")
   (description
    "An Emacs media player, based on mpv.  More precisely this package provides
somewhat comprehensive interface to mpv with bunch of convenient functionality
like an embedded radio manager, @code{YouTube} interface, local music/video
library manager etc.  Lots of interactive functions are at your disposal.  To
view the most essential ones, type `M-x describe-keymap empv-map`.  It is
advised that you bind this keymap to a key for convenience.  Additionally, empv
has versatile customization options.  For an overview of all customization
options, do `M-x customize-group empv`.")
   (license #f))
  )

(define-public emacs-r-ts-mode
  (package
   (name "emacs-r-ts-mode")
   (version "0.1")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/sje30/r-ts-mode.git")
		  (commit "8745d782f7d6687844ecf022d2f0f3590b02d5c7")))
	    (sha256 (base32
		     "011jhydhjsbkxs6yl5yd8lyyb9w99qwxy70vi2y9j0j4jvfas5da"))))
   (build-system emacs-next-build-system)
   ;;(arguments '(#:tests? #f))

   ;;(build-system python-build-system)
   ;;(propagated-inputs (list python python-epc python-sexpdata python-six python-paramiko emacs-markdown-mode emacs-yasnippet))
   (home-page "https://github.com/sje30/r-ts-mode")
   (synopsis "Emacs mode for R (treesit)")
   (description
    "...")
   (license #f))
  )

(define-public emacs-forge
  (package
   (name "emacs-forge")
   (version "20230723.47")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/magit/forge.git")
		  (commit "ecbcce94a5581077f8e1cda3e3f2a66c6dd52766")))
	    (sha256 (base32
		     "1nq6xiq1hsrl0y7md16ddnkr2ycrsdbf2jjqjyaj3ldvdx9zbs6d"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-compat
			    emacs-closql
			    emacs-dash
			    emacs-emacsql
			    emacs-ghub
			    emacs-let-alist
			    emacs-magit
			    emacs-markdown-mode
			    emacs-transient
			    emacs-yaml))
   (home-page "https://github.com/magit/forge")
   (synopsis "Access Git forges from Magit.")
   (description
    "Work with Git forges, such as Github and Gitlab, from the comfort of Magit and
the rest of Emacs.  The schema of the database has not been finalized yet.
Until that has happened it will occasionally have to be discarded.  For now the
database does not contain any information that cannot simply be fetched again.")
   (license #f))
  )




;; Lsp-mode

(define-public emacs-lv
  (package
   (name "emacs-lv")
   (version "20200507.1518")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/abo-abo/hydra.git")
		  (commit "317e1de33086637579a7aeb60f77ed0405bf359b")))
	    (sha256 (base32
		     "1nbp0kpxb0m4igyjji1b8zi06am4l5m2m6rmxgz0jvks8cyri6dm"))))
   (build-system emacs-build-system)
   (arguments '(#:include '("^lv.el$")
		#:exclude '()))
   (home-page "unspecified")
   (synopsis "Other echo area")
   (description
    "This package provides `lv-message intended to be used in place of `message when
semi-permanent hints are needed, in order to not interfere with Echo Area. \"Я
тихо-тихо пiдглядаю, І тiшуся собi, як бачу то, Шо страшить i не пiдпускає, А
iншi п’ють тебе, як воду пiсок.\" -- Андрій Кузьменко, L.V.")
   (license #f))
  )


(define-public emacs-lsp-mode
  (package
   (name "emacs-lsp-mode")
   (version "8.0.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://stable.melpa.org/packages/lsp-mode-"
				version ".tar"))
	    (sha256 (base32
		     "0pjlrsn0g1h2c6nzpwzlq119pav013i72rjrbfgilkpdpjl7kbcb"))))   (build-system emacs-build-system)
		     (propagated-inputs (list emacs-dash
					      emacs-f
					      emacs-ht
					      emacs-spinner
					      emacs-markdown-mode
					      emacs-lv))
		     (home-page "https://github.com/emacs-lsp/lsp-mode")
		     (synopsis "LSP mode")
		     (description "Emacs client/library for the Language Server Protocol")
		     (license #f))
  )


(define-public emacs-lsp-ui
  (package
   (name "emacs-lsp-ui")
   (version "8.0.1")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://stable.melpa.org/packages/lsp-ui-"
				version ".tar"))
	    (sha256 (base32
		     "1s6cizb9696if20m11ygawlgisa1797h9c8y2596m7v0fkvcqwr0"))))   (build-system emacs-build-system)
		     (propagated-inputs (list emacs-dash emacs-lsp-mode emacs-markdown-mode))
		     (home-page "https://github.com/emacs-lsp/lsp-ui")
		     (synopsis "UI modules for lsp-mode")
		     (description
		      "lsp-ui contains a series of useful UI integrations for lsp-mode, like flycheck
support and code lenses.")
		     (license #f))
  )

(define-public emacs-consult-lsp
(package
  (name "emacs-consult-lsp")
   (version "1.1")
   (source (origin
             (method url-fetch)
             (uri (string-append
                   "https://stable.melpa.org/packages/consult-lsp-" version
                   ".tar"))
             (sha256 (base32
                      "0b62rvlh0pdfpdc9azlsrdc2wsvyn9j6y6yn20w7i2af8m3kn8wc"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-lsp-mode emacs-consult emacs-f))
   (home-page "https://github.com/gagbo/consult-lsp")
   (synopsis "LSP-mode Consult integration")
   (description
    "This package provides LSP-mode related commands for consult The commands are
autoloaded so you don't need to require anything to make them available.  Just
use M-x and go! ;; Diagnostics M-x consult-lsp-diagnostics provides a view of
all diagnostics in the current workspace (or all workspaces if passed a prefix
argument).  You can use prefixes to filter diagnostics per severity, and
previewing/selecting a candidate will go to it directly. ;; Symbols M-x
consult-lsp-symbols provides a selection/narrowing command to search and go to
any arbitrary symbol in the workspace (or all workspaces if passed a prefix
argument).  You can use prefixes as well to filter candidates per type, and
previewing/selecting a candidate will go to it. ;; File symbols M-x
consult-lsp-file-symbols provides a selection/narrowing command to search and go
to any arbitrary symbol in the selected buffer (like imenu) ;; Contributions
Possible contributions for ameliorations include: - using a custom format for
the propertized candidates This should be done with :type function custom
variables probably. - checking the properties in LSP to see how
diagnostic-sources should be used - checking the properties in LSP to see how
symbol-sources should be used")
   (license #f))
)


(define-public emacs-lsp-julia
  (package
   (name "emacs-lsp-julia")
   (version "0.7.2")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/lsp-julia-" version
		  ".tar"))
	    (sha256 (base32
		     "0w80fhljilhivik9dvxp9b2q870sgns3qphlfmznxrkjp634nzf0"))))   (build-system emacs-build-system)
		     (propagated-inputs (list emacs-lsp-mode emacs-julia-mode))
		     (home-page "https://github.com/gdkrmr/lsp-julia")
		     (synopsis "Julia support for lsp-mode")
		     (description
		      "This version of lsp-julia requires julia 1.7 to run.  Manual installation:
(require julia-mode) (push \"/path/to/lsp-julia\" load-path) (require lsp-julia)(require lsp-mode) ;; Configure lsp + julia (add-hook julia-mode-hook
#'lsp-mode) (add-hook julia-mode-hook #'lsp)")
		     (license #f))
  )

(define-public emacs-lsp-ltex
  (package
   (name "emacs-lsp-ltex")
   (version "0.2.1")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://stable.melpa.org/packages/lsp-ltex-"
				version ".tar"))
	    (sha256 (base32
		     "1bmnc5049drg3hlsbcmmgw2n33yyav1yzd48xvcg8bznfgxzyy65"))))   (build-system emacs-build-system)
		     (propagated-inputs (list emacs-lsp-mode emacs-f emacs-s))
		     (home-page "https://github.com/emacs-languagetool/lsp-ltex")
		     (synopsis "LSP Clients for LTEX")
		     (description "LSP server implementation for LTEX")
		     (license #f))
  )



(define-public emacs-lsp-docker
  (package
   (name "emacs-lsp-docker")
   (version "20230627.1601")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/emacs-lsp/lsp-docker.git")
		  (commit "9adabe57393c6e8740789710c614d011a697b1ed")))
	    (sha256 (base32
		     "0y01hf3phxbcr0qzhv4i5nwxkwlbadpg2yg8v8fb7cy91qjwzf86"))))   (build-system emacs-build-system)
		     (propagated-inputs (list emacs-dash
					      emacs-lsp-mode
					      emacs-f
					      emacs-s
					      emacs-yaml
					      emacs-ht))
		     (home-page "https://github.com/emacs-lsp/lsp-docker")
		     (synopsis "LSP Docker integration")
		     (description "Run language servers in containers")
		     (license #f))
  )

(define-public emacs-lsp-scheme
  (package
   (name "emacs-lsp-scheme")
   (version "0.1.1")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/lsp-scheme-" version
		  ".tar"))
	    (sha256 (base32
		     "13n4i1i76808f2pk651gwaj5gzd6hgvqmi5a55lg6kp4q8lh6j3x"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-f emacs-lsp-mode))
   (home-page "https://codeberg.org/rgherdt/emacs-lsp-scheme")
   (synopsis "Scheme support for lsp-mode")
   (description
    "Client for the Scheme LSP server.  Currently this client only supports CHICKEN 5
and Guile 3, since those are supported by scheme-lsp-server. ;; Installation
Make sure your chosen Scheme implementation is installed and on your load-path.
Implementation support depends on availability of a corresponding LSP server, as
mentioned, for now only CHICKEN and Guile are supported.  On first run you
should be prompted to install an lsp server.  The extension will install it to
its cache directory.  In case something goes wrong, manually install the server
available at https://codeberg.org/rgherdt/scheme-lsp-server (and make sure to
create an issue at our repository).  In order to achieve better results, follow
these instructions to update CHICKEN's documentation: - install needed eggs:
chicken-install -s r7rs apropos chicken-doc srfi-18 srfi-130 - update
documentation database: $ cd `csi -R chicken.platform -p (chicken-home)'` $ curl
https://3e8.org/pub/chicken-doc/chicken-doc-repo-5.tgz | sudo tar zx 
								      ;; Setup
Add the following lines to your Emacs configuration file: (require lsp-scheme)
(add-hook scheme-mode-hook #'lsp-scheme) (setq lsp-scheme-implementation
\"guile\") ;;; customizable 
			     ;; Usage This LSP client tries to implement an
workflow similar to other Lisp-related Emacs modes.  For instance, it relies on
the interaction between the user and the REPL to load information needed.  The
interaction is currently based on Emacs built-in Scheme inferior-mode.  So, for
instance, in order to load the current buffer you can just issue C-c C-l.  Since
the REPL is connected to the LSP server, this will allow it to fetch symbols
defined in the buffer, as well as libraries imported by it.")
   (license #f))
  )


(define-public emacs-flycheck 
  (package
   (name "emacs-flycheck")
   (version "32")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://stable.melpa.org/packages/flycheck-"
				version ".tar"))
	    (sha256 (base32
		     "11nwdds4mhysmxmn2w31qz3599nkmxyzd5np31kzapgv0k9dpg6i"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-dash emacs-pkg-info emacs-let-alist
			    emacs-seq))
   (home-page "http://www.flycheck.org")
   (synopsis "On-the-fly syntax checking")
   (description
    "On-the-fly syntax checking for GNU Emacs 24.  Flycheck is a modern on-the-fly
syntax checking extension for GNU Emacs, intended as replacement for the older
Flymake extension which is part of GNU Emacs.  Flycheck automatically checks
buffers for errors while you type, and reports warnings and errors directly in
the buffer and in an optional IDE-like error list.  It comes with a rich
interface for custom syntax checkers and other extensions, and has already many
3rd party extensions adding new features.  Please read the online manual at
http://www.flycheck.org for more information.  You can open the manual directly
from Emacs with `M-x flycheck-manual'. # Setup Flycheck works best on Unix
systems.  It does not officially support Windows, but tries to maintain Windows
compatibility and should generally work fine on Windows, too.  To enable
Flycheck add the following to your init file: (add-hook after-init-hook
#'global-flycheck-mode) Flycheck will then automatically check buffers in
supported languages, as long as all necessary tools are present.  Use
`flycheck-verify-setup to troubleshoot your Flycheck setup.")
   (license #f))
  )

(define-public emacs-consult-flycheck 
(package
  (name "emacs-consult-flycheck")
   (version "0.9")
   (source (origin
             (method url-fetch)
             (uri (string-append
                   "https://stable.melpa.org/packages/consult-flycheck-"
                   version ".tar"))
             (sha256 (base32
                      "1h3v1brsrhbn34qm7g267j5dqxwwgfl0177a5z9y59p62faklml9"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-consult emacs-flycheck))
   (home-page "https://github.com/minad/consult")
   (synopsis "Provides the command `consult-flycheck'")
   (description
    "This package provides the command `consult-flycheck'.  This is an extra package,
since the consult.el package only depends on Emacs core components.")
   (license #f))
)


(define-public emacs-pulseaudio-control 
  (package
   (name "emacs-pulseaudio-control")
   (version "20230316.1819")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://melpa.org/packages/pulseaudio-control-" version
		  ".tar"))
	    (sha256 (base32
		     "1wqk6lvq12dpyl6bk67x2vj4zy9wfkrpr8kbwsvfqx9iqj4ixkik"))))
   (build-system emacs-build-system)
   (home-page "https://git.sr.ht/~flexibeast/pulseaudio-control")
   (synopsis "Use `pactl' to manage PulseAudio volumes.")
   (description
    "`pulseaudio-control controls @code{PulseAudio} volumes from Emacs, via `pactl`.
## Table of Contents - [Installation](#installation) - [Usage](#usage) -
[Issues](#issues) - [License](#license) ## Installation Install
[pulseaudio-control from MELPA](http://melpa.org/#/pulseaudio-control), or put
`pulseaudio-control.el` in your load-path and do a `(require
pulseaudio-control)'. ## Usage Initially, the `pulseaudio-control keymap is not
bound to any prefix.  You can call the command
`pulseaudio-control-default-keybindings to use the prefix `C-x / to access the
`pulseaudio-control keymap globally; if you wish to use this prefix by default,
add the line: (pulseaudio-control-default-keybindings) to your init file.  The
default keybindings in the `pulseaudio-control keymap are: * `+` : Increase the
volume of the currently-selected sink by `pulseaudio-control-volume-step
(`pulseaudio-control-increase-sink-volume'). * `=` : Increase the volume of the
currently-selected source by `pulseaudio-control-volume-step
(`pulseaudio-control-increase-source-volume'). * `-` : Decrease the volume of
the currently-selected sink by `pulseaudio-control-volume-step
(`pulseaudio-control-decrease-sink-volume'). * `_` : Decrease the volume of the
currently-selected source by `pulseaudio-control-volume-step
(`pulseaudio-control-decrease-source-volume'). * `v` : Directly specify the
volume of the currently-selected sink (`pulseaudio-control-set-sink-volume').
The value can be: * a percentage, e.g. 10%'; * in decibels, e.g. @code{2dB';} *
a linear factor, e.g. 0.9 or 1.1'. * `V` : Directly specify the volume of the
currently-selected source (`pulseaudio-control-set-source-volume').  The value
can be: * a percentage, e.g. 10%'; * in decibels, e.g. @code{2dB';} * a linear
factor, e.g. 0.9 or 1.1'. * `m` : Toggle muting of the currently-selected sink
(`pulseaudio-control-toggle-current-sink-mute'). * `M` : Toggle muting of the
currently-selected source (`pulseaudio-control-toggle-current-source-mute'). *
`x` : Toggle muting of a sink, specified by index
(`pulseaudio-control-toggle-sink-mute-by-index'). * `X` : Toggle muting of a
source, specified by index (`pulseaudio-control-toggle-source-mute-by-index'). *
`e` : Toggle muting of a sink, specified by name
(`pulseaudio-control-toggle-sink-mute-by-name'). * `E` : Toggle muting of a
source, specified by name (`pulseaudio-control-toggle-source-mute-by-name'). *
`i` : Select a sink to be the current sink, specified by index
(`pulseaudio-control-select-sink-by-index'). * `I` : Select a source to be the
current sink, specified by index (`pulseaudio-control-select-source-by-index').
* `n` : Select a sink to be the current sink, specified by name
(`pulseaudio-control-select-sink-by-name'). * `N` : Select a source to be the
current source, specified by name (`pulseaudio-control-select-source-by-name').
* `d` : Display volume of the currently-selected sink
(`pulseaudio-control-display-volume'). * `]` : Toggle use of @@DEFAULT_SINK@@
for volume operations (`pulseaudio-control-default-sink-mode'). * `[` : Toggle
use of @@DEFAULT_SOURCE@@ for volume operations
(`pulseaudio-control-default-source-mode').  Customisation options, including
`pulseaudio-control-volume-step', are available via the `pulseaudio-control
customize-group. ## Issues / bugs If you discover an issue or bug in
`pulseaudio-control not already noted: * as a TODO item, or * in [the project's
\"Issues\" section on
@code{GitHub](https://github.com/flexibeast/pulseaudio-control/issues),} please
create a new issue with as much detail as possible, including: * which version
of Emacs you're running on which operating system, and * how you installed
`pulseaudio-control'. ## License [GNU General Public License version
3](http://www.gnu.org/licenses/gpl.html), or (at your option) any later version.")
   (license #f))
  )


(define-public emacs-org-agenda-property 
  (package
   (name "emacs-org-agenda-property")
   (version "1.3.1")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://stable.melpa.org/packages/org-agenda-property-"
		  version ".tar"))
	    (sha256 (base32
		     "0ppm19z2fkd45kb1vxy77jmwh9lvkc02dmzbjyji7inka54gvs83"))))
   (build-system emacs-next-build-system)
   (home-page "http://github.com/Bruce-Connor/org-agenda-property")
   (synopsis "Display org properties in the agenda buffer.")
   (description
    "org-agenda-property is a package which displays the properties of an org item
beside (or below) the item's title in the agenda buffer.  Customize the variable`org-agenda-property-list to add which properties you which to show. ;
Instructions: INSTALLATION If you installed from Melpa, you shouldn't need to doanything else.  Just customize `org-agenda-property-list and call your agenda
buffer (tipically `org-agenda-list') to see the magic.  If you installed
manually, just make sure it's in your load-path and call        (require
org-agenda-property) Variables  All variables can be edited by running
	`org-agenda-property-customize (seriously, chech it out, they   are just a few
:-)).  The documentations are mostly self       explanatory, I list here only the
most important two. `org-agenda-property-list This should be a list of all
properties you want displayed in the buffer.  Default is \"LOCATION\".
	`org-agenda-property-position           This is where you want the properties to be
displayed               (besides the title or below the title?).")
   (license #f))
  )

(define-public emacs-org-gtd 
  (package
   (name "emacs-org-gtd")
   (version "3.0.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://stable.melpa.org/packages/org-gtd-"
				version ".tar"))
	    (sha256 (base32
		     "070y9vj204gxc8ni4mw16hcwc3gf16yqf5hf9q6jdjz70i123b9i"))))
   (build-system emacs-next-build-system)
   (propagated-inputs (list emacs-org-edna emacs-f emacs-org
			    emacs-org-agenda-property emacs-transient))
   (home-page "https://github.com/Trevoke/org-gtd.el")
   (synopsis "An implementation of GTD.")
   (description
    "This package tries to replicate as closely as possible the GTD workflow.  This
package assumes familiarity with GTD. This package provides a system that allows
you to capture incoming things into an inbox, then process the inbox and
categorize each item based on the GTD categories.  It leverages org-agenda to
show today's items as well as the NEXT items.  It also has a simple project
management system, which currently assumes all tasks in a project are
sequential.  For a comprehensive instruction manual, see the documentation.
Either the info file or in the doc/ directory of the repository.  Upgrade
information is also available therein.")
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
    ;;"emacs-next-pgtk" ;; Emacs text editor with `pgtk' and `tree-sitter' support
    "emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
    "hicolor-icon-theme" ;; Freedesktop icon theme 
    "git" ;; Distributed version control system
    "nss-certs" ;; CA certificates from Mozilla
    "coreutils" ;; Core GNU utilities (file, text, shell)
    "findutils" ;; Operating on files matching given criteria


    "emacs-guix" ;; Emacs interface for GNU Guix

    "emacs-evil" ;; Extensible Vi layer for Emacs
    "emacs-evil-collection" ;; Collection of Evil bindings for many major and minor modes
    "emacs-undo-fu" ;; Simple, stable linear undo with redo for Emacs

    ;;"emacs-ess" ;; Emacs mode for statistical analysis programs


    ;;"emacs-julia-mode" ;; Major mode for Julia
    ;;"emacs-julia-repl" ;; Minor mode for interacting with a Julia REPL ;; Replaced by julia-vterm since support org-babel via ob-julia-vterm
    "emacs-no-littering" ;; Help keep `~/.emacs.d/' clean
    "emacs-pdf-tools" ;; Emacs support library for PDF files

    "emacs-vertico" ;; Vertical interactive completion
    "emacs-orderless" ;; Emacs completion style that matches multiple regexps in any order
    "emacs-embark" ;; Emacs mini-buffer actions rooted in keymaps
    "emacs-marginalia" ;; Marginalia in the minibuffer completions
    "emacs-corfu" ;; Completion overlay region function
    "emacs-corfu-doc" ;; Documentation popup for Corfu
    "emacs-kind-icon" ;; Completion kind icons in Emacs 
    "emacs-svg-lib" ;; Emacs SVG library for creating tags, icons and bars 
    "emacs-cape" ;; Completion at point extensions for Emacs

    "emacs-company"
    "emacs-company-posframe"

    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries
    "emacs-emprise" ;; Control MPRIS supported media players from Emacs
    "emacs-marginalia-emprise" ;; Annotate Emprise with Marginalia
    "emacs-which-key" ;; Display available key bindings in popup 
    "emacs-general" ;; More convenient key definitions in emacs
    "emacs-org-modern" ;; Modern Org Style
    "emacs-svg-tag-mode" ;; Replace keywords with SVG tags 
    "emacs-evil-org" ;; Evil keybindings for Org mode
    ;;"emacs-nano-modeline" ;; Emacs minor mode controlling mode line
    ;;"emacs-simple-modeline" ;; Simple mode-line configuration for Emacs
    "emacs-telephone-line" ;; Implementation of Powerline for Emacs 

    "emacs-f" ;; Emacs API for working with files and directories 
    "emacs-s" ;; Emacs string manipulation library
    "emacs-dash"

    "emacs-mixed-pitch" ;; Mix variable- and fixed-pitch fonts in the same Emacs buffer

    ;; FIXME: autolink don't work, see https://github.com/awth13/org-appear/issues/50
    ;;"emacs-org-appear" ;; Make invisible parts of Org fragments appear visible
    "emacs-toc-org" ;; Table of Contents generator for Emacs Org mode

    "emacs-mood-line" ;; Minimal mode-line for Emacs
    "font-fira-code"
    "font-fira-mono"
    "font-fira-sans"
    "font-iosevka-term" ;; Coders' typeface, built from code
    "font-iosevka" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-aile" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-hack" ;; Typeface designed for source code

    "emacs-general" ;; More convenient key definitions in emacs

    ;;"emacs-doom-modeline" ;; Fancy and fast mode-line inspired by minimalism design
    "emacs-minions" ;; Minor-mode menu for the mode line
    "emacs-spaceline-next" ;; Powerline theme from Spacemacs

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
    "emacs-geiser-guile" ;; Guile Scheme support for Geiser

    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries

    "emacs-doom-themes" ;; Wide collection of color themes for Emacs
    "emacs-gruvbox-theme" ;; Gruvbox is a retro groove color scheme ported from Vim
    "emacs-zenburn-theme" ;; Low contrast color theme for Emacs
    "emacs-dream-theme" ;; High-contrast Emacs theme
    "emacs-solarized-theme" ;; Port of the Solarized theme for Emacs
    "emacs-spacemacs-theme" ;; Light and dark theme for spacemacs that supports GUI and terminal  
    "emacs-monokai-theme" ;; High contrast color theme for Emacs

    "emacs-hide-mode-line" ;; Emacs plugin that hides the mode-line
    ;;"emacs-emms-mode-line-cycle" ;; Display the EMMS mode line as a ticker
    "emacs-powerline" ;; Mode-line plugin for Emacs

    ;;"emacs-emms" ;; The Emacs Multimedia System ;; miss mpd-prev
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    ;;"python-flake8" ;; The modular source code checker: pep8, pyflakes and co
    "emacs-mpv" ;; Control MPV for easy note taking
    ;;"emacs-emms-mode-line-cycle" ;;  Display the EMMS mode line as a ticker

    "python-lsp-server" ;; Python implementation of the Language Server Protocol


    "emacs-org-roam" ;; Non-hierarchical note-taking with Org mode
    "emacs-org-roam-ui" ;; Web User Interface for Org Roam
    "emacs-websocket" ;;  Emacs WebSocket client and server 
    "emacs-citar-org-roam" ;; Emacs package to provide tighter Citar and Org-Roam integration
    "emacs-consult-org-roam" ;; Consult integration for Org Roam

    "git"

    "emacs-ibuffer-vc" ;; Group Ibuffer's list by revision control system indications

    "emacs-sly" ;; Sylvester the Cat's Common Lisp IDE 

    "emacs-dashboard" ;; Startup screen extracted from Spacemacs ;; version make shortcut don't work with compilation, see https://github.com/emacs-dashboard/emacs-dashboard/issues/97
    "emacs-page-break-lines" ;; Display page breaks as tidy horizontal lines

    "emacs-langtool" ;; Emacs interface to LanguageTool
    "tree-sitter"

    ;;"emacs-straight-el" ;; Purely functional package manager for the Emacs hacker
    "emacs-poly-r" ;; Polymodes for the R language
    "emacs-polymode-markdown" ;; Polymode for Markdown mode

    "emacs-org-superstar" ;; Prettify headings and plain lists in Org mode
    "emacs-org-fancy-priorities" ;; Display org priorities as custom strings 
    "emacs-org-pomodoro" ;; Pomodoro technique for org-mode 
    ;;"mplayer" ;; Audio and video player
    "mpv" ;; Audio and video player
    "mpv-mpris" ;; MPRIS plugin for mpv

    "emacs-nyxt" ;; Interact with Nyxt from Emacs

    "emacs-pinentry" ;; GnuPG Pinentry server implementation
    "pinentry-emacs" ;; GnuPG's interface to passphrase input

    "emacs-auctex" ;; Integrated environment for TeX 
    "emacs-org-edit-latex" ;;  Edit a LaTeX fragment just like editing a source block
    "emacs-evil-tex" ;;  Evil oriented additions for editing LaTeX 

    "emacs-elfeed" ;; Atom/RSS feed reader for Emacs

    "zip" 

    "emacs-mastodon"


    "aspell" ;; Spell checker 
    "aspell-dict-fr" ;; French dictionary for GNU Aspell 
    "aspell-dict-en" ;; English dictionary for GNU Aspell  
    "emacs-flyspell-correct" ;; Correcting words with flyspell via custom interfaces
    "emacs-auto-dictionary-mode" ;; Automatic dictionary switcher for Emacs spell checking
    "emacs-writegood-mode" ;; Polish up poor writing on the fly


    "emacs-mpv" ;; Control MPV for easy note taking
    "emacs-bluetooth" ;; Manage Bluetooth devices using Emacs
    "emacs-mpdel" ;; Emacs user interface for Music Player Daemon
    ;;"emacs-simple-mpc" ;; Simple Emacs frontend to mpc
    "emacs-transmission" ;; Emacs interface to a Transmission session




    ;; Docker support
    "emacs-docker" ;; Manage docker from Emacs 
    "emacs-dockerfile-mode" ;; Major mode for editing Dockerfile
    ;; "emacs-docker-tramp" ;; TRAMP integration for docker containers ;; Obsolete...
    "emacs-docker-compose-mode" ;; Major mode for editing `docker-compose' files


    ;;
    "emacs-csv-mode" ;; Major mode for editing comma/char separated values


    ;; File manager
    "emacs-dirvish" ;; Improved version of the Emacs package Dired 
    "fd" ;; Simple, fast and user-friendly alternative to find
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    "poppler" ;; PDF rendering library
    ;;"emacs-pdf-tools" ;; Emacs support library for PDF files
    "ffmpegthumbnailer" ;; Create thumbnails from video files
    "mediainfo" ;; Utility for reading media metadata
    "tar" ;; Managing tar archives
    "unzip" ;; Decompression and file extraction utility


    "emacs-org-tree-slide" ;; Presentation tool for Org mode
    "emacs-hide-lines" ;; Commands for hiding lines based on a regexp

    "emacs-lua-mode" ;; Major mode for lua

    "openjdk" ;; Java development kit
    "java-slf4j-simple" ;; Simple implementation of simple logging facade for Java

    ;; LSP
    "ccls" ;; C/C++/Objective-C language server
    ;;"texlive-digestif" ;;Editor plugin for LaTeX, ConTeXt etc.

    ;; Eglot
    "emacs-consult-eglot" ;; Consulting-read interface for eglot 


    ;; Terminal
    "emacs-eat" ;; Terminal emulator in Emacs
    "emacs-vterm" ;; Emacs libvterm integration
    "emacs-vterm-toggle" ;; Toggle between a vterm buffer and other buffers
    "emacs-multi-vterm" ;; Manage multiple vterm buffers in Emacs

    ;; Lsp-bridge dependencies
    "python-epc" ;; Remote procedure call (RPC) stack for Emacs Lisp and Python
    "python-orjson" ;; Python JSON library supporting dataclasses, datetimes, and numpy
    "python-sexpdata" ;; S-expression parser for Python
    "python-six" ;; Python 2 and 3 compatibility utilities
    "python-paramiko" ;; SSHv2 protocol library
    "emacs-yasnippet" ;; Yet another snippet extension for Emacs

    "julia" ;; High-performance dynamic language for technical computing

    ;; LSP-mode
    "python-lsp-server" ;; Python implementation of the Language Server Protocol  
    "python-pylint" ;; Advanced Python code static checker
    ;;"emacs-lsp-mode" ;; Emacs client and library for the Language Server Protocol
    ;;"emacs-lsp-ui" ;; User interface extensions for `lsp-mode'
    ;; "emacs-dap-mode" ;; Emacs client/library for Debug Adapter Protocol

    ;;"emacs-pulseaudio-control" ;; Control Pulseaudio from Emacs
    "alsa-utils" ;; Utilities for the Advanced Linux Sound Architecture (ALSA)

    "emacs-nix-mode" ;; Emacs major mode for editing Nix expressions

    ;;"emacs-consult-lsp"

    ))
  (packages->manifest (list
		       emacs-julia-vterm
		       emacs-ob-julia-vterm
		       emacs-julia-ts-mode
		       emacs-r-vterm
		       emacs-cl-generic
		       ;;emacs-eglot-jl ;; manual set-up in test
		       emacs-dired-sidebar
		       emacs-ibuffer-sidebar
		       emacs-ibuffer-project
		       emacs-tabspaces
		       emacs-use-package
		       emacs-emms
		       ;;python-tinytag ;; don't work
		       emacs-doom-modeline
		       ;;emacs-ess-view-data
		       emacs-all-the-icons
		       ;; emacs-auctex-latexmk ;; dont't work
		       emacs-tab-bar-echo-area
		       emacs-org-appear
		       emacs-eglot-ltex
		       ;; emacs-dashboard ;; do work well with emacs 29
		       ;; emacs-org-pdftools ;; don't build
		       ;; emacs-lsp-bridge ;; TODO: try to build, failed, seems to search py file in building process
		       emacs-empv
		       emacs-r-ts-mode

		       ;; emacs-forge

		       emacs-lsp-mode ;; necessary for lsp-ltex
		       emacs-consult-lsp
		       emacs-lsp-ui
		       emacs-lsp-julia
		       emacs-lsp-ltex
		       emacs-lsp-scheme
		       emacs-flycheck
		       emacs-consult-flycheck
		       ;; emacs-pulseaudio-control ;; don't work, similar problem to https://github.com/flexibeast/pulseaudio-control/issues/10
		       emacs-org-gtd

		       ))
  ))
