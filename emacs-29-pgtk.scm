(use-modules (guix packages)
             (gnu packages autotools)
             (gnu packages webkit)
             (gnu packages emacs)
             (gnu packages sqlite)
             (gnu packages gnome)
             (guix download)
             (guix git-download)
             (guix gexp)
             (guix utils)
             (gnu packages)
             )



;;(define-public emacs-next
;;  (let ((commit "6adc193ad66445acd84caba6973424ecbd21da26")
;;        (revision "4"))
;;    (package
;;     (inherit emacs)
;;     (name "emacs-next")
;;     (version (git-version "29.0.50" revision commit))
;;     (source
;;      (origin
;;       (inherit (package-source emacs))
;;       (method git-fetch)
;;       (uri (git-reference
;;             (url "https://git.savannah.gnu.org/git/emacs.git/")
;;             (commit commit)))
;;       (file-name (git-file-name name version))
;;       ;; emacs-source-date-epoch.patch is no longer necessary
;;       (patches (search-patches "emacs-exec-path.patch"
;;                                "emacs-fix-scheme-indent-function.patch"
;;                                "emacs-native-comp-driver-options.patch"))
;;       (sha256
;;        (base32
;;         "0b48qg9w7fzvhva78gzi3cs2m6asj11fk0kgys49fqhwskigzg1f"))))
;;     (inputs
;;      (modify-inputs (package-inputs emacs)
;;                     (prepend sqlite)))
;;     (native-inputs
;;      (modify-inputs (package-native-inputs emacs)
;;                     (prepend autoconf))))))
;;
;;(define-public emacs-next-pgtk
;;  (package
;;   (inherit emacs-next)
;;   (name "emacs-next-pgtk")
;;   (source
;;    (origin
;;     (inherit (package-source emacs-next))
;;     (patches
;;      (append (search-patches "emacs-pgtk-super-key-fix.patch")
;;              (origin-patches (package-source emacs-next))))))
;;   (arguments
;;    (substitute-keyword-arguments (package-arguments emacs-next)
;;                                  ((#:configure-flags flags #~'())
;;                                   #~(cons* "--with-pgtk" "--with-xwidgets" #$flags))))
;;   (propagated-inputs
;;    (list gsettings-desktop-schemas glib-networking))
;;   (inputs
;;    (modify-inputs (package-inputs emacs-next)
;;                   (prepend webkitgtk-with-libsoup2)))
;;   (home-page "https://github.com/masm11/emacs")
;;   (synopsis "Emacs text editor with @code{pgtk} and @code{xwidgets} support")
;;   (description "This Emacs build implements graphical UI purely in terms of
;;GTK and also enables xwidgets.")))



(define-public emacs-29-pgtk
  (let ((commit "ea1bb263153d406479e782872820af4f9926ac7d")
        (revision "4"))
    (package
      (inherit emacs)
      (name "emacs-29-pgtk")
      (version (git-version "29.0.60" revision commit))
      (source
       (origin
         (inherit (package-source emacs))
         (method git-fetch)
         (uri (git-reference
               (url "https://git.savannah.gnu.org/git/emacs.git/")
               (commit commit)))
         (file-name (git-file-name name version))
         ;; emacs-source-date-epoch.patch is no longer necessary
         (patches (search-patches "emacs-exec-path.patch"
                                  "emacs-fix-scheme-indent-function.patch"
                                  "emacs-native-comp-driver-options.patch"
                                  "emacs-pgtk-super-key-fix.patch"))
         (sha256
          (base32
           "11ay53wplp5zm4p709bbi8l9xcg8vpvmd2rhwway6a8fb8xmmki1"))))
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-next)
       ((#:configure-flags flags #~'())
        #~(cons* "--with-pgtk" "--with-xwidgets" #$flags))))
      (inputs
       (modify-inputs (package-inputs emacs)
         (prepend sqlite)))
      (native-inputs
       (modify-inputs (package-native-inputs emacs)
         (prepend autoconf webkitgtk-with-libsoup2))))))



;;(define-public emacs-29-pgtk
;;  (let ((commit "ea1bb263153d406479e782872820af4f9926ac7d")
;;        (revision "4"))
;;    (package
;;     (inherit emacs-next-pgtk)
;;     (name "emacs-29-pgtk")
;;     (version (git-version "29.0.60" revision commit))
;;     (source
;;      (origin
;;       (inherit (package-source emacs))
;;       (method git-fetch)
;;       (uri (git-reference
;;             (url "https://git.savannah.gnu.org/git/emacs.git/")
;;             (commit commit)))
;;       (file-name (git-file-name name version))
;;       (sha256
;;        (base32
;;         "11ay53wplp5zm4p709bbi8l9xcg8vpvmd2rhwway6a8fb8xmmki1")))))))



(packages->manifest (list
                     emacs-29-pgtk
                     ))
