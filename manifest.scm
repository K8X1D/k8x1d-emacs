(use-modules (guix packages)
	     (guix git-download)
	     (gnu packages)
	     (gnu packages commencement)
	     (gnu packages emacs)
	     (gnu packages shellutils))


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


(define* (emacs->emacs-next emacs #:optional name
                            #:key (version (package-version emacs-next-minimal))
                            (source (package-source emacs-next-minimal)))
  (package
   (inherit emacs)
   (name (or name
             (and (string-prefix? "emacs" (package-name emacs))
                  (string-append "emacs-next"
                                 (string-drop (package-name emacs)
                                              (string-length "emacs"))))))
   (version version)
   (source source)))

(define-public emacs-next-pgtk-xwidgets (emacs->emacs-next emacs-pgtk-xwidgets))


(packages->manifest
 (list emacs-next-pgtk-xwidgets
       direnv
       ))
