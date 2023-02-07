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


;; Old
;;(define-public emacs-29
;;  (let ((commit "ea1bb263153d406479e782872820af4f9926ac7d")
;;        (revision "4"))
;;    (package
;;     (inherit emacs)
;;     (name "emacs-29")
;;     (version (git-version "29.0.60" revision commit))
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
;;         "11ay53wplp5zm4p709bbi8l9xcg8vpvmd2rhwway6a8fb8xmmki1"))))
;;     (inputs
;;      (modify-inputs (package-inputs emacs)
;;                     (prepend sqlite)))
;;     (native-inputs
;;      (modify-inputs (package-native-inputs emacs)
;;                     (prepend autoconf))))))



(concatenate-manifests
 (list
  (specifications->manifest
   '(
     "emacs-next"
     "plantuml" ;; Draw UML diagrams from simple textual description
     ))
  (packages->manifest (list
		       ;;emacs-29
		       ))
  ))
