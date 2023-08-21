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

;; Set emacs version according to window system
(define emacs-distribution 
  (if (equal? (getenv "XDG_SESSION_TYPE") "x11")
      "emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
      "emacs-next-pgtk") ;; Emacs text editor with `pgtk' and `tree-sitter' support
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
    "alsa-utils" ;; Utilities for the Advanced Linux Sound Architecture (ALSA)
    "aspell" ;; Spell checker 
    "aspell-dict-en" ;; English dictionary for GNU Aspell  
    "aspell-dict-fr" ;; French dictionary for GNU Aspell 
    "ccls" ;; C/C++/Objective-C language server
    "coreutils" ;; Core GNU utilities (file, text, shell)
    "emacs-all-the-icons" ;; Collect icon fonts and propertize them within Emacs
    "emacs-all-the-icons-completion" ;; Add icons to completion candidates 
    "emacs-all-the-icons-dired" ;; Show icons for each file in `dired-mode'
    "emacs-all-the-icons-ibuffer" ;; Display icons for all buffers in ibuffer
    "emacs-auctex" ;; Integrated environment for TeX 
    "emacs-auto-dictionary-mode" ;; Automatic dictionary switcher for Emacs spell checking
    ;; FIXME: conflict with emacs-pass on emacs-dash
    ;;"emacs-bluetooth" ;; Manage Bluetooth devices using Emacs
    "emacs-cape" ;; Completion at point extensions for Emacs
    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries
    "emacs-citar-org-roam" ;; Emacs package to provide tighter Citar and Org-Roam integration
    "emacs-company"
    "emacs-company-posframe"
    "emacs-consult-eglot" ;; Consulting-read interface for eglot 
    "emacs-consult-flycheck"
    "emacs-consult-lsp"
    "emacs-consult-org-roam" ;; Consult integration for Org Roam
    "emacs-corfu" ;; Completion overlay region function
    "emacs-corfu-doc" ;; Documentation popup for Corfu
    "emacs-csv-mode" ;; Major mode for editing comma/char separated values
    "emacs-dash"
    "emacs-dashboard" ;; Startup screen extracted from Spacemacs ;; version make shortcut don't work with compilation, see https://github.com/emacs-dashboard/emacs-dashboard/issues/97
    "emacs-dired-git-info" ;; Show git info in Emacs Dired
    "emacs-dired-sidebar"
    "emacs-dirvish" ;; Improved version of the Emacs package Dired 
    "emacs-docker" ;; Manage docker from Emacs 
    "emacs-docker-compose-mode" ;; Major mode for editing `docker-compose' files
    "emacs-dockerfile-mode" ;; Major mode for editing Dockerfile
    "emacs-doom-modeline" ;; Fancy and fast mode-line inspired by minimalism design
    "emacs-doom-themes" ;; Wide collection of color themes for Emacs
    "emacs-dream-theme" ;; High-contrast Emacs theme
    "emacs-eat" ;; Terminal emulator in Emacs
    "emacs-elfeed" ;; Atom/RSS feed reader for Emacs
    "emacs-embark" ;; Emacs mini-buffer actions rooted in keymaps
    "emacs-emms"
    "emacs-emprise" ;; Control MPRIS supported media players from Emacs
    "emacs-empv"
    "emacs-evil" ;; Extensible Vi layer for Emacs
    "emacs-evil-collection" ;; Collection of Evil bindings for many major and minor modes
    "emacs-evil-org" ;; Evil keybindings for Org mode
    "emacs-evil-tex" ;;  Evil oriented additions for editing LaTeX 
    "emacs-flycheck"
    "emacs-flyspell-correct" ;; Correcting words with flyspell via custom interfaces
    "emacs-geiser" ;; Collection of Emacs modes for Scheme hacking 
    "emacs-geiser-guile" ;; Guile Scheme support for Geiser
    "emacs-general" ;; More convenient key definitions in emacs
    "emacs-gruvbox-theme" ;; Gruvbox is a retro groove color scheme ported from Vim
    "emacs-hide-lines" ;; Commands for hiding lines based on a regexp
    "emacs-hide-mode-line" ;; Emacs plugin that hides the mode-line
    "emacs-ibuffer-project"
    "emacs-ibuffer-sidebar"
    "emacs-ibuffer-vc" ;; Group Ibuffer's list by revision control system indications
    "emacs-julia-ts-mode"
    "emacs-julia-vterm"
    "emacs-kind-icon" ;; Completion kind icons in Emacs 
    "emacs-langtool" ;; Emacs interface to LanguageTool
    "emacs-lsp-julia"
    "emacs-lsp-ltex"
    "emacs-lsp-mode"
    "emacs-lsp-julia" ;; Julia support for lsp-mode
    "emacs-lsp-scheme"
    "emacs-lsp-ui"
    "emacs-lua-mode" ;; Major mode for lua
    "emacs-magit" ;; Emacs interface for the Git version control system
    "emacs-magit-todos" ;; Show source files' TODOs (and FIXMEs, etc) in Magit status buffer
    "emacs-marginalia" ;; Marginalia in the minibuffer completions
    "emacs-mastodon"
    "emacs-minions" ;; Minor-mode menu for the mode line
    "emacs-mixed-pitch" ;; Mix variable- and fixed-pitch fonts in the same Emacs buffer
    "emacs-monokai-theme" ;; High contrast color theme for Emacs
    "emacs-mood-line" ;; Minimal mode-line for Emacs
    "emacs-mpdel" ;; Emacs user interface for Music Player Daemon
    "emacs-mpv" ;; Control MPV for easy note taking
    "emacs-mpv" ;; Control MPV for easy note taking
    "emacs-multi-vterm" ;; Manage multiple vterm buffers in Emacs
    "emacs-nix-mode" ;; Emacs major mode for editing Nix expressions
    "emacs-no-littering" ;; Help keep `~/.emacs.d/' clean
    "emacs-ob-julia-vterm"
    "emacs-orderless" ;; Emacs completion style that matches multiple regexps in any order
    "emacs-org-appear"
    "emacs-org-auto-tangle" ;; Automatically tangle code blocks on save
    "emacs-org-edit-latex" ;;  Edit a LaTeX fragment just like editing a source block
    "emacs-org-fancy-priorities" ;; Display org priorities as custom strings 
    "emacs-org-gtd"
    "emacs-org-modern" ;; Modern Org Style
    "emacs-org-pomodoro" ;; Pomodoro technique for org-mode 
    "emacs-org-roam" ;; Non-hierarchical note-taking with Org mode
    "emacs-org-roam-ui" ;; Web User Interface for Org Roam
    "emacs-org-superstar" ;; Prettify headings and plain lists in Org mode
    "emacs-org-tree-slide" ;; Presentation tool for Org mode
    "emacs-page-break-lines" ;; Display page breaks as tidy horizontal lines
    "emacs-pass" ;; Major mode for `password-store.el'
    "emacs-password-store" ;; Password store (pass) support for Emacs
    "emacs-password-store-otp" ;; Interact with the `pass-otp' extension for `pass' from Emacs
    "emacs-pdf-tools" ;; Emacs support library for PDF files
    "emacs-pinentry" ;; GnuPG Pinentry server implementation
    "emacs-poly-r" ;; Polymodes for the R language
    "emacs-powerline" ;; Mode-line plugin for Emacs
    "emacs-s" ;; Emacs string manipulation library
    "emacs-sly" ;; Sylvester the Cat's Common Lisp IDE 
    "emacs-solaire-mode" ;; Change background of file-visiting buffers in Emacs
    "emacs-solarized-theme" ;; Port of the Solarized theme for Emacs
    "emacs-spacemacs-theme" ;; Light and dark theme for spacemacs that supports GUI and terminal  
    "emacs-svg-lib" ;; Emacs SVG library for creating tags, icons and bars 
    "emacs-svg-tag-mode" ;; Replace keywords with SVG tags 
    "emacs-tab-bar-echo-area"
    "emacs-tabspaces"
    "emacs-telephone-line" ;; Implementation of Powerline for Emacs 
    "emacs-toc-org" ;; Table of Contents generator for Emacs Org mode
    "emacs-transmission" ;; Emacs interface to a Transmission session
    "emacs-undo-fu" ;; Simple, stable linear undo with redo for Emacs
    "emacs-use-package"
    "emacs-vertico" ;; Vertical interactive completion
    "emacs-vterm" ;; Emacs libvterm integration
    "emacs-vterm-toggle" ;; Toggle between a vterm buffer and other buffers
    "emacs-websocket" ;;  Emacs WebSocket client and server 
    "emacs-which-key" ;; Display available key bindings in popup 
    "emacs-writegood-mode" ;; Polish up poor writing on the fly
    "emacs-yasnippet" ;; Yet another snippet extension for Emacs
    "emacs-zenburn-theme" ;; Low contrast color theme for Emacs
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
    "git" ;; Distributed version control system
    "hicolor-icon-theme" ;; Freedesktop icon theme 
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    "java-slf4j-simple" ;; Simple implementation of simple logging facade for Java
    "julia" ;; High-performance dynamic language for technical computing
    "mediainfo" ;; Utility for reading media metadata
    "mpv" ;; Audio and video player
    "mpv-mpris" ;; MPRIS plugin for mpv
    "nss-certs" ;; CA certificates from Mozilla
    "openjdk" ;; Java development kit
    "pinentry-emacs" ;; GnuPG's interface to passphrase input
    "poppler" ;; PDF rendering library
    "python-epc" ;; Remote procedure call (RPC) stack for Emacs Lisp and Python
    "python-lsp-server" ;; Python implementation of the Language Server Protocol
    "python-lsp-server" ;; Python implementation of the Language Server Protocol  
    "python-orjson" ;; Python JSON library supporting dataclasses, datetimes, and numpy
    "python-paramiko" ;; SSHv2 protocol library
    "python-pylint" ;; Advanced Python code static checker
    "python-sexpdata" ;; S-expression parser for Python
    "python-six" ;; Python 2 and 3 compatibility utilities
    "tar" ;; Managing tar archives
    "tree-sitter"
    "unzip" ;; Decompression and file extraction utility
    "zip" 
    ))
    ;;
    ;; "emacs-dap-mode" ;; Emacs client/library for Debug Adapter Protocol
    ;; "emacs-docker-tramp" ;; TRAMP integration for docker containers ;; Obsolete...
    ;; "emacs-nyxt" ;; Interact with Nyxt from Emacs
    ;; "emacs-polymode-markdown" ;; Polymode for Markdown mode
    ;; Docker support
    ;; Eglot
    ;; FIXME: autolink don't work, see https://github.com/awth13/org-appear/issues/50
    ;; FIXME: collide with emacs magit
    ;; FIXME: collide with emacs magit
    ;; FIXME: collide with emacs-magit through emacs-transient
    ;; FIXME: collide with emacs-marginalia
    ;; FIXME: collide with emacs-poly-r 
    ;; FIXME: collide with emacs-sly
    ;; FIXME: conflic with emacs-org-gtd on emacs-dash
    ;; File manager
    ;; LSP
    ;; LSP-mode
    ;; Lsp-bridge dependencies
    ;; Terminal
    ;;"emacs-dired-sidebar" ;; Sidebar for Emacs using Dired ;; problem with git versioned project, version too old
    ;;"emacs-emms" ;; The Emacs Multimedia System ;; miss mpd-prev
    ;;"emacs-emms-mode-line-cycle" ;;  Display the EMMS mode line as a ticker
    ;;"emacs-emms-mode-line-cycle" ;; Display the EMMS mode line as a ticker
    ;;"emacs-ess" ;; Emacs mode for statistical analysis programs
    ;;"emacs-f" ;; Emacs API for working with files and directories 
    ;;"emacs-forge" ;; Access Git forges from Magit
    ;;"emacs-guix" ;; Emacs interface for GNU Guix
    ;;"emacs-julia-mode" ;; Major mode for Julia
    ;;"emacs-julia-repl" ;; Minor mode for interacting with a Julia REPL ;; Replaced by julia-vterm since support org-babel via ob-julia-vterm
    ;;"emacs-lsp-mode" ;; Emacs client and library for the Language Server Protocol
    ;;"emacs-lsp-ui" ;; User interface extensions for `lsp-mode'
    ;;"emacs-magit-org-todos-el" ;; Get todo.org into Emacs Magit status
    ;;"emacs-marginalia-emprise" ;; Annotate Emprise with Marginalia
    ;;"emacs-nano-modeline" ;; Emacs minor mode controlling mode line
    ;;"emacs-next-pgtk" ;; Emacs text editor with `pgtk' and `tree-sitter' support
    ;;"emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
    ;;"emacs-org-appear" ;; Make invisible parts of Org fragments appear visible
    ;;"emacs-pdf-tools" ;; Emacs support library for PDF files
    ;;"emacs-pulseaudio-control" ;; Control Pulseaudio from Emacs
    ;;"emacs-simple-modeline" ;; Simple mode-line configuration for Emacs
    ;;"emacs-simple-mpc" ;; Simple Emacs frontend to mpc
    ;;"emacs-straight-el" ;; Purely functional package manager for the Emacs hacker
    ;;"mplayer" ;; Audio and video player
    ;;"python-flake8" ;; The modular source code checker: pep8, pyflakes and co
    ;;"texlive-digestif" ;;Editor plugin for LaTeX, ConTeXt etc.
  (packages->manifest (list

		       ;; FIXME: collide with emacs-vterm
		       ;;emacs-r-vterm

		       ;; FIXME: collide with emacs-guix through emacs-dash
		       ;;emacs-eglot-ltex
		       ))
  ))
