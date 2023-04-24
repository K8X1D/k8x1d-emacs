;;
;; Modules
;;


(use-modules
 (guix packages)
 (guix git-download)
 (guix build-system emacs)
 (guix build-system python)
 (gnu packages emacs-xyz)
 (gnu packages python-xyz)
 (gnu packages check)
 (guix download)
 (guix licenses)
;; (k8x1d packages emacs)
 ;; (emacs)
 ((guix licenses) #:prefix license:))

;;
;; Packages
;;

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
    "emacs-magit-todos" ;; Show source files' TODOs (and FIXMEs, etc) in Magit status buffer
    "emacs-magit-org-todos-el" ;; Get todo.org into Emacs Magit status

    "emacs-forge" ;; Access Git forges from Magit
    ;;"emacs-dired-sidebar" ;; Sidebar for Emacs using Dired ;; problem with git versioned project, version too old
    "emacs-dired-git-info" ;; Show git info in Emacs Dired
    "emacs-solaire-mode" ;; Change background of file-visiting buffers in Emacs
    "emacs-all-the-icons" ;; Collect icon fonts and propertize them within Emacs
    "emacs-all-the-icons-ibuffer" ;; Display icons for all buffers in ibuffer
    "emacs-all-the-icons-dired" ;; Show icons for each file in `dired-mode'
    "emacs-org-auto-tangle" ;; Automatically tangle code blocks on save

    "emacs-pass" ;; Major mode for `password-store.el'
    "emacs-password-store" ;; Password store (pass) support for Emacs
    "emacs-password-store-otp" ;; Interact with the `pass-otp' extension for `pass' from Emacs

    "emacs-geiser" ;; Collection of Emacs modes for Scheme hacking 

    "emacs-citar" ;; Emacs package to quickly find and act on bibliographic entries

    "emacs-doom-themes" ;; Wide collection of color themes for Emacs

    ;;"emacs-emms" ;; The Emacs Multimedia System ;; miss mpd-prev
    "imagemagick" ;; Create, edit, compose, or convert bitmap images
    ;;"python-flake8" ;; The modular source code checker: pep8, pyflakes and co
    "emacs-mpv" ;; Control MPV for easy note taking
    ;;"emacs-emms-mode-line-cycle" ;;  Display the EMMS mode line as a ticker

    "python-lsp-server" ;; Python implementation of the Language Server Protocol

    "emacs-bluetooth" ;; Manage Bluetooth devices using Emacs

    "emacs-org-roam" ;; Non-hierarchical note-taking with Org mode
    "emacs-org-roam-ui" ;; Web User Interface for Org Roam
    "emacs-citar-org-roam" ;; Emacs package to provide tighter Citar and Org-Roam integration
    "emacs-consult-org-roam" ;; Consult integration for Org Roam

    ;;"git"


    "emacs-sly" ;; Sylvester the Cat's Common Lisp IDE 

    "emacs-dashboard" ;; Startup screen extracted from Spacemacs
    "emacs-page-break-lines" ;; Display page breaks as tidy horizontal lines

    "emacs-langtool" ;; Emacs interface to LanguageTool
    ))
  (packages->manifest (list
		       emacs-julia-vterm
		       emacs-ob-julia-vterm
		       ;;emacs-cl-generic
		       ;;emacs-julia-ts-mode
		       ;;emacs-eglot-jl
		       emacs-dired-sidebar
		       emacs-ibuffer-sidebar
		       emacs-tabspaces
		       emacs-use-package
		       emacs-emms
		       ;;python-tinytag ;; don't work
		       ))
  ))
