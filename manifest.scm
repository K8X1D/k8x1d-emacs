

;;
;; Manifest
;;
  (specifications->manifest
   (list
    "font-iosevka" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-aile" ;; Iosevka is a slender monospace sans-serif or slab-serif typeface
    "font-iosevka-term" ;; Coders' typeface, built from code

    "gcc-toolchain" ;; Complete GCC tool chain for C/C++ development
    "cmake" ;; Cross-platform build system
    "libvterm" ;; VT220/xterm/ECMA-48 terminal emulator library
    "python-lsp-server" ;; Python implementation of the Language Server Protocol
    "emacs-next-pgtk-xwidgets" ;; Emacs text editor with `xwidgets' and `pgtk' support

    "texlive-bin" ;; TeX Live, a package of the TeX typesetting system
    "texlive-digestif" ;; Editor plugin for LaTeX, ConTeXt etc.
    "texlive-dvipng" ;; DVI to PNG/GIF converter
    "texlive-luatex" ;; Extended version of pdfTeX using Lua
    "r-languageserver" ;; Language Server for R
    "qtlanguageserver" ;;  Implementation of the Language Server Protocol for Qt
    ))
