;;
;; Modules
;;

(use-modules (guix packages)
	     (guix git-download)

	     (guix build-system emacs)
	     (guix build-system python)
	     (guix build-system gnu)
	     (guix build-system cargo)

	     (gnu packages emacs-xyz)
	     (gnu packages python-xyz)
	     (gnu packages check)
	     (gnu packages statistics)
	     (gnu packages crates-io)

	     (guix download)
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

	     (guix packages)
	     (gnu packages package-management)
	     ((guix licenses) #:prefix license:)
	     (guix download)
	     (guix git-download)
	     (guix gexp)
	     (guix build-system gnu)
	     (gnu packages)
	     (gnu packages autotools)
	     (gnu packages guile)
	     (gnu packages pkg-config)
	     (gnu packages texinfo)
	     (ice-9 rdelim)
	     (ice-9 popen)
	     (gnu packages guile-xyz)

	     (emacs packages melpa)
	     (gnu packages gtk)
	     (gnu packages glib)
	     (gnu packages image)
	     (gnu packages pdf)
	     (gnu packages emacs)
	     (gnu packages compression)
	     (gnu packages emacs-xyz)

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
 
(define-public rust-dashmap-5
  (package
    (name "rust-dashmap")
    (version "5.5.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dashmap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0a1fz4vpynfil30rj7b4jriks667vpgdn6v41kqwd69qja9j9mzd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-lock-api" ,rust-lock-api-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-parking-lot-core" ,rust-parking-lot-core-0.9)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/xacrimon/dashmap")
    (synopsis "Blazing fast concurrent HashMap for Rust.")
    (description "Blazing fast concurrent @code{HashMap} for Rust.")
    (license license:expat)))

(define-public rust-human-name-2
  (package
    (name "rust-human-name")
    (version "2.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "human-name" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nkzhjz2b636srhzjwj6a50bmkzynn0b89jdxm760q85c4rqbdki"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-phf" ,rust-phf-0.11)
                       ("rust-phf-codegen" ,rust-phf-codegen-0.11)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-smallstr" ,rust-smallstr-0.3)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-unicode-case-mapping" ,rust-unicode-case-mapping-0.4)
                       ("rust-unicode-normalization" ,rust-unicode-normalization-0.1)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-unidecode" ,rust-unidecode-0.3))
       #:cargo-development-inputs (("rust-alloc-counter" ,rust-alloc-counter-0.0.4))))
    (home-page "https://github.com/djudd/human-name")
    (synopsis "A library for parsing and comparing human names")
    (description
     "This package provides a library for parsing and comparing human names")
    (license license:asl2.0)))

(define-public rust-isocountry-0.3
  (package
    (name "rust-isocountry")
    (version "0.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "isocountry" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "011y6sb6rs2i85g2jvifx5s54clw7nprinzzhfx08jgvy15xr88y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/sifton/isocountry-rs")
    (synopsis "ISO 3166-1 enumeration for Rust")
    (description "ISO 3166-1 enumeration for Rust")
    (license license:expat)))

(define-public rust-logos-0.12
  (package
    (name "rust-logos")
    (version "0.12.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "logos" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1w82qm3hck5cr6ax3j3yzrpf4zzbffahz126ahyqwyn6h8b072xz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-logos-derive" ,rust-logos-derive-0.13))))
    (home-page "https://github.com/maciejhirsz/logos")
    (synopsis "Create ridiculously fast Lexers")
    (description "Create ridiculously fast Lexers")
    (license (list license:expat license:asl2.0))))

(define-public rust-lsp-server-0.6
  (package
    (name "rust-lsp-server")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lsp-server" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0nkp6sy5dmvishsg5rjvv3q57h87ald21zmq5506bxlwqb0p01gp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1))
       #:cargo-development-inputs (("rust-lsp-types" ,rust-lsp-types-0.94))))
    (home-page
     "https://github.com/rust-lang/rust-analyzer/tree/master/lib/lsp-server")
    (synopsis "Generic LSP server scaffold.")
    (description "Generic LSP server scaffold.")
    (license (list license:expat license:asl2.0))))

(define-public rust-lsp-types-0.93
  (package
    (name "rust-lsp-types")
    (version "0.93.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lsp-types" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lfawrvxq3k6jpblyikfvzh1759zf3zpl39pfhcnb3yiwb3ykrlv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-repr" ,rust-serde-repr-0.1)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/gluon-lang/lsp-types")
    (synopsis
     "Types for interaction with a language server, using VSCode's Language Server Protocol")
    (description
     "Types for interaction with a language server, using VSCode's Language Server
Protocol")
    (license license:expat)))

(define-public rust-serde-millis-0.1
  (package
    (name "rust-serde-millis")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde-millis" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "002d8dk3fwidh5j44aixjbzw80q24w0d208xklv2rvm51iwdrqp6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-serde-derive" ,rust-serde-derive-1)
                                   ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/tailhook/serde-millis")
    (synopsis
     "    A serde wrapper that stores integer millisecond value for timestamps
    and durations (used similarly to serde_bytes)
")
    (description
     "This package provides a serde wrapper that stores integer millisecond value for
timestamps and durations (used similarly to serde_bytes)")
    (license (list license:expat license:asl2.0))))

(define-public rust-serde-regex-1
  (package
    (name "rust-serde-regex")
    (version "1.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde-regex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1pxsnxb8c198szghk1hvzvhva36w2q5zs70hqkmdf5d89qd6y4x8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-serde-derive" ,rust-serde-derive-1)
                                   ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/tailhook/serde-regex")
    (synopsis "    A serde wrapper that (de)serializes regex as strings
")
    (description
     "This package provides a serde wrapper that (de)serializes regex as strings")
    (license (list license:expat license:asl2.0))))

(define-public rust-strum-0.24
  (package
    (name "rust-strum")
    (version "0.24.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1y77vshrhm1grlgcfmnm0nxpsv0pb5zcb97zy6rbh106nz0wysp9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf" ,rust-phf-0.10)
                       ("rust-strum-macros" ,rust-strum-macros-0.25))
       #:cargo-development-inputs (("rust-strum-macros" ,rust-strum-macros-0.25))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))






(define-public rust-titlecase-2
  (package
    (name "rust-titlecase")
    (version "2.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "titlecase" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hi0hkh2x78rvq7rhdgdzsgwcnlpvvb59hgnifsgwz01vf67lf9q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-joinery" ,rust-joinery-2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/wezm/titlecase")
    (synopsis
     "A tool and library that capitalizes text according to a style defined by John Gruber for post titles on his website Daring Fireball.")
    (description
     "This package provides a tool and library that capitalizes text according to a
style defined by John Gruber for post titles on his website Daring Fireball.")
    (license license:expat)))

(define-public rust-typed-builder-0.11
  (package
    (name "rust-typed-builder")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "typed-builder" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "07nlizmjyya5f792qy0zdrqa4lz0ildxc34h421rxwxz1nj2d8a7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-typed-builder-macro" ,rust-typed-builder-macro-0.15))))
    (home-page "https://github.com/idanarye/rust-typed-builder")
    (synopsis "Compile-time type-checked builder derive")
    (description "Compile-time type-checked builder derive")
    (license (list license:expat license:asl2.0))))

(define-public rust-assert-unordered-0.3
  (package
    (name "rust-assert-unordered")
    (version "0.3.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "assert-unordered" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0r123d4az6rhivpsymwmg0k4hn9iagp0hkhka6rkwcl1g0xk4x0w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ansi-term" ,rust-ansi-term-0.12))))
    (home-page "https://github.com/nu11ptr/assert_unordered")
    (synopsis "A direct replacement for `assert_eq` for unordered collections")
    (description
     "This package provides a direct replacement for `assert_eq` for unordered
collections")
    (license (list license:expat license:asl2.0))))

(define-public rust-hashbrown-0.14
  (package
    (name "rust-hashbrown")
    (version "0.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hashbrown" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0yj3nf0w30pf30w503kgaw4sbjnh62l5cbmc7dd0mnczzywh2qic"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ahash" ,rust-ahash-0.8)
                       ("rust-allocator-api2" ,rust-allocator-api2-0.2)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rkyv" ,rust-rkyv-0.7)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-bumpalo" ,rust-bumpalo-3)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-fnv" ,rust-fnv-1)
                                   ("rust-lazy-static" ,rust-lazy-static-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-rayon" ,rust-rayon-1)
                                   ("rust-rkyv" ,rust-rkyv-0.7)
                                   ("rust-serde-test" ,rust-serde-test-1))))
    (home-page "https://github.com/rust-lang/hashbrown")
    (synopsis "A Rust port of Google's SwissTable hash map")
    (description
     "This package provides a Rust port of Google's @code{SwissTable} hash map")
    (license (list license:expat license:asl2.0))))

(define-public rust-phf-0.11
  (package
    (name "rust-phf")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p03rsw66l7naqhpgr1a34r9yzi1gv9jh16g3fsk6wrwyfwdiqmd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf-macros" ,rust-phf-macros-0.11)
                       ("rust-phf-shared" ,rust-phf-shared-0.11)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Runtime support for perfect hash function data structures")
    (description "Runtime support for perfect hash function data structures")
    (license license:expat)))

(define-public rust-phf-codegen-0.11
  (package
    (name "rust-phf-codegen")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf-codegen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0nia6h4qfwaypvfch3pnq1nd2qj64dif4a6kai3b7rjrsf49dlz8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf-generator" ,rust-phf-generator-0.11)
                       ("rust-phf-shared" ,rust-phf-shared-0.11))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Codegen library for PHF types")
    (description "Codegen library for PHF types")
    (license license:expat)))

(define-public rust-smallstr-0.3
  (package
    (name "rust-smallstr")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "smallstr" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17fzs6nnp4hj5b002v11f0gsypdhm8qmzcfhvvw5yww0ygysxcb3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-smallvec" ,rust-smallvec-1))
       #:cargo-development-inputs (("rust-bincode" ,rust-bincode-1))))
    (home-page "https://github.com/murarth/smallstr")
    (synopsis "String-like container based on smallvec")
    (description "String-like container based on smallvec")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-case-mapping-0.4
  (package
    (name "rust-unicode-case-mapping")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unicode-case-mapping" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17rrnk7vbk995qdcm0jdj0hhslrvx59s7bzx41i5pg7zc8f3jsli"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/yeslogic/unicode-case-mapping")
    (synopsis
     "Fast lowercase, uppercase, and titlecase mapping for characters")
    (description
     "Fast lowercase, uppercase, and titlecase mapping for characters")
    (license license:asl2.0)))

(define-public rust-unidecode-0.3
  (package
    (name "rust-unidecode")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unidecode" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p0sm8j9223kw3iincv60s746s88k09xcaqf8nkx3w83isfv2as0"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/chowdhurya/rust-unidecode/")
    (synopsis "Provides pure ASCII transliterations of Unicode strings.")
    (description
     "This package provides pure ASCII transliterations of Unicode strings.")
    (license license:bsd-3)))
 
(define-public rust-alloc-counter-0.0.4
  (package
    (name "rust-alloc-counter")
    (version "0.0.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "alloc-counter" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1agxzprqi37bcy9hh3clbsl3n0awbb34vrlv4rp5afib8w53m31s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-alloc-counter-macro" ,rust-alloc-counter-macro-0.0.2)
                       ("rust-pin-utils" ,rust-pin-utils-0.1))
       #:cargo-development-inputs (("rust-futures-executor" ,rust-futures-executor-0.3))))
    (home-page "https://gitlab.com/sio4/code/alloc-counter")
    (synopsis
     "Count allocations, reallocations, deallocations. Allow, deny, or forbid allocations on an expression or function basis.")
    (description
     "Count allocations, reallocations, deallocations.  Allow, deny, or forbid
allocations on an expression or function basis.")
    (license (list license:expat license:asl2.0))))

(define-public rust-logos-derive-0.13
  (package
    (name "rust-logos-derive")
    (version "0.12.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "logos-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0v295x78vcskab88hshl530w9d1vn61cmlaic4d6dydsila4kn51"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-logos-codegen" ,rust-logos-codegen-0.13))))
    (home-page "https://github.com/maciejhirsz/logos")
    (synopsis "Create ridiculously fast Lexers")
    (description "Create ridiculously fast Lexers")
    (license (list license:expat license:asl2.0))))

(define-public rust-lsp-types-0.94
  (package
    (name "rust-lsp-types")
    (version "0.94.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lsp-types" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "18aym1qfgyaf9f9504yz911gssck5rv190izzr3hdqbal12gssy6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-repr" ,rust-serde-repr-0.1)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/gluon-lang/lsp-types")
    (synopsis
     "Types for interaction with a language server, using VSCode's Language Server Protocol")
    (description
     "Types for interaction with a language server, using VSCode's Language Server
Protocol")
    (license license:expat)))

(define-public rust-strum-macros-0.25
  (package
    (name "rust-strum-macros")
    (version "0.24.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12wig3cx2l9hj50jb4ly1p9pgfnj9w2zj00qq0b47ycg1vhbvbjg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-syn" ,rust-syn-2))
       #:cargo-development-inputs (("rust-strum" ,rust-strum-0.25))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define-public rust-joinery-2
  (package
    (name "rust-joinery")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "joinery" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1fbpjk2b5xjj5mv5wlw1iigjvps5613sn7x2bna6lcz8n5lck9c5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1))))
    (home-page "https://github.com/Lucretiel/joinery")
    (synopsis
     "A small crate for generically joining iterators with a separator")
    (description
     "This package provides a small crate for generically joining iterators with a
separator")
    (license license:expat)))

(define-public rust-typed-builder-macro-0.15
  (package
    (name "rust-typed-builder-macro")
    (version "0.15.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "typed-builder-macro" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qncxrwrhsznqyk5b8bkcvq0wmil8k1av60z04ykxcfh84f1b8r9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/idanarye/rust-typed-builder")
    (synopsis "Compile-time type-checked builder derive")
    (description "Compile-time type-checked builder derive")
    (license (list license:expat license:asl2.0))))

(define-public rust-ansi-term-0.12
  (package
    (name "rust-ansi-term")
    (version "0.12.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ansi-term" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ljmkbilxgmhavxvxqa7qvm6f3fjggi7q2l3a72q9x0cxjvrnanm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-winapi" ,rust-winapi-0.3))
       #:cargo-development-inputs (("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-regex" ,rust-regex-1)
                                   ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/ogham/rust-ansi-term")
    (synopsis "Library for ANSI terminal colours and styles (bold, underline)")
    (description
     "Library for ANSI terminal colours and styles (bold, underline)")
    (license license:expat)))

(define-public rust-allocator-api2-0.2
  (package
    (name "rust-allocator-api2")
    (version "0.2.16")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "allocator-api2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1iayppgq4wqbfbfcqmsbwgamj0s65012sskfvyx07pxavk3gyhh9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/zakarumych/allocator-api2")
    (synopsis "Mirror of Rust's allocator API")
    (description "Mirror of Rust's allocator API")
    (license (list license:expat license:asl2.0))))

(define-public rust-phf-generator-0.11
  (package
    (name "rust-phf-generator")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf-generator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c14pjyxbcpwkdgw109f7581cc5fa3fnkzdq1ikvx7mdq9jcrr28"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-criterion" ,rust-criterion-0.3)
                       ("rust-phf-shared" ,rust-phf-shared-0.11)
                       ("rust-rand" ,rust-rand-0.8))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "PHF generation logic")
    (description "PHF generation logic")
    (license license:expat)))

(define-public rust-phf-shared-0.11
  (package
    (name "rust-phf-shared")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf-shared" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0azphb0a330ypqx3qvyffal5saqnks0xvl8rj73jlk3qxxgbkz4h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-siphasher" ,rust-siphasher-0.3)
                       ("rust-uncased" ,rust-uncased-0.9)
                       ("rust-unicase" ,rust-unicase-2))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Support code shared by PHF libraries")
    (description "Support code shared by PHF libraries")
    (license license:expat)))

(define-public rust-phf-macros-0.11
  (package
    (name "rust-phf-macros")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0js61lc0bhzzrbd9vhpcqp11vvwckdkz3g7k95z5h1k651p68i1l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf-generator" ,rust-phf-generator-0.11)
                       ("rust-phf-shared" ,rust-phf-shared-0.11)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-unicase" ,rust-unicase-2))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Macros to generate types in the phf crate")
    (description "Macros to generate types in the phf crate")
    (license license:expat)))

(define-public rust-logos-codegen-0.13
  (package
    (name "rust-logos-codegen")
    (version "0.13.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "logos-codegen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0s7drl8vfp9viw9mfyz8dll1gfvp1dc6np82abj0402y548p6j6w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-beef" ,rust-beef-0.5)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-regex-syntax" ,rust-regex-syntax-0.6)
                       ("rust-syn" ,rust-syn-2))
       #:cargo-development-inputs (("rust-pretty-assertions" ,rust-pretty-assertions-0.6))))
    (home-page "https://github.com/maciejhirsz/logos")
    (synopsis
     "Implementation details for logos-codegen and logos-derive. Not for public consumption.")
    (description
     "Implementation details for logos-codegen and logos-derive.  Not for public
consumption.")
    (license (list license:expat license:asl2.0))))

(define-public rust-strum-0.25
  (package
    (name "rust-strum")
    (version "0.25.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09g1q55ms8vax1z0mxlbva3vm8n2r1179kfvbccnkjcidzm58399"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf" ,rust-phf-0.10)
                       ("rust-strum-macros" ,rust-strum-macros-0.25))
       #:cargo-development-inputs (("rust-strum-macros" ,rust-strum-macros-0.25))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define-public rust-fern-0.6
  (package
    (name "rust-fern")
    (version "0.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fern" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ahys5fmc10vcgf6yyai0jiypl8pqwidydhqkbp7jph79447pp9v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-chrono" ,rust-chrono-0.4)
                       ("rust-colored" ,rust-colored-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-reopen" ,rust-reopen-0.3)
                       ("rust-reopen" ,rust-reopen-1)
                       ("rust-syslog" ,rust-syslog-3)
                       ("rust-syslog" ,rust-syslog-4)
                       ("rust-syslog" ,rust-syslog-6))
       #:cargo-development-inputs (("rust-clap" ,rust-clap-2)
                                   ("rust-humantime" ,rust-humantime-2)
                                   ("rust-tempfile" ,rust-tempfile-3))))
    (home-page "https://github.com/daboross/fern")
    (synopsis "Simple, efficient logging")
    (description "Simple, efficient logging")
    (license license:expat)))

(define-public rust-reopen-1
  (package
    (name "rust-reopen")
    (version "1.0.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "reopen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14w2v7a4dav23jzfrxj9lgacp731xizvng4bn7slan7qmk1wwhpz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-signal-hook" ,rust-signal-hook-0.3))
       #:cargo-development-inputs (("rust-log" ,rust-log-0.4)
                                   ("rust-partial-io" ,rust-partial-io-0.3)
                                   ("rust-simple-logging" ,rust-simple-logging-2)
                                   ("rust-version-sync" ,rust-version-sync-0.9))))
    (home-page "https://github.com/vorner/reopen")
    (synopsis "File reopening utility")
    (description "File reopening utility")
    (license (list license:asl2.0 license:expat))))

(define-public rust-syslog-6
  (package
    (name "rust-syslog")
    (version "6.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syslog" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vzrwwv3v9bwfinp7yz4kcdxxs00ikz89gzl61fj3qfcridyjd3l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-error-chain" ,rust-error-chain-0.12)
                       ("rust-hostname" ,rust-hostname-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-time" ,rust-time-0.3))))
    (home-page "https://github.com/Geal/rust-syslog")
    (synopsis "Send log messages to syslog")
    (description "Send log messages to syslog")
    (license license:expat)))

(define-public rust-simple-logging-2
  (package
    (name "rust-simple-logging")
    (version "2.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "simple-logging" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hmm523f0ax76yljf3z178rn9cm0q6knwa52haqnnckmavl4h3dh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-thread-id" ,rust-thread-id-3))
       #:cargo-development-inputs (("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/Ereski/simple-logging")
    (synopsis "A simple logger for the log facade")
    (description "This package provides a simple logger for the log facade")
    (license license:bsd-3)))

(define-public rust-petgraph-0.6
  (package
    (name "rust-petgraph")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "petgraph" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hw1i1s49f82sg34ngfhgmg8qraa7d26gak2rrwiacx1ad103mg6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-fixedbitset" ,rust-fixedbitset-0.4)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-quickcheck" ,rust-quickcheck-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1))
       #:cargo-development-inputs (("rust-bincode" ,rust-bincode-1)
                                   ("rust-defmac" ,rust-defmac-0.2)
                                   ("rust-itertools" ,rust-itertools-0.11)
                                   ("rust-odds" ,rust-odds-0.4)
                                   ("rust-rand" ,rust-rand-0.5))))
    (home-page "https://github.com/petgraph/petgraph")
    (synopsis
     "Graph data structure library. Provides graph types and graph algorithms.")
    (description
     "Graph data structure library.  Provides graph types and graph algorithms.")
    (license (list license:expat license:asl2.0))))

(define-public rust-indexmap-2
  (package
    (name "rust-indexmap")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "indexmap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0pdnbvv6gnyxx2li8mks8p00fya3ynmhx3n6infpcy8a4gi7yiym"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-equivalent" ,rust-equivalent-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rustc-rayon" ,rust-rustc-rayon-0.5)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-fnv" ,rust-fnv-1)
                                   ("rust-fxhash" ,rust-fxhash-0.2)
                                   ("rust-itertools" ,rust-itertools-0.10)
                                   ("rust-lazy-static" ,rust-lazy-static-1)
                                   ("rust-quickcheck" ,rust-quickcheck-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://github.com/bluss/indexmap")
    (synopsis "A hash table with consistent order and fast iteration.")
    (description
     "This package provides a hash table with consistent order and fast iteration.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-itertools-0.11
  (package
    (name "rust-itertools")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "itertools" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mzyqcc59azx9g5cg6fs8k529gvh4463smmka6jvzs3cd2jp7hdi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-either" ,rust-either-1))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.4)
                                   ("rust-paste" ,rust-paste-1)
                                   ("rust-permutohedron" ,rust-permutohedron-0.2)
                                   ("rust-quickcheck" ,rust-quickcheck-0.9)
                                   ("rust-rand" ,rust-rand-0.7))))
    (home-page "https://github.com/rust-itertools/itertools")
    (synopsis
     "Extra iterator adaptors, iterator methods, free functions, and macros.")
    (description
     "Extra iterator adaptors, iterator methods, free functions, and macros.")
    (license (list license:expat license:asl2.0))))

(define-public rust-odds-0.4
  (package
    (name "rust-odds")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "odds" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17jd5fjcrlya7dbnnj0v8s83l3jhlajyljmkcy49pxsvxj9zdsdz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-rawpointer" ,rust-rawpointer-0.2)
                       ("rust-rawslice" ,rust-rawslice-0.1)
                       ("rust-unchecked-index" ,rust-unchecked-index-0.2))
       #:cargo-development-inputs (("rust-itertools" ,rust-itertools-0.8)
                                   ("rust-lazy-static" ,rust-lazy-static-1)
                                   ("rust-memchr" ,rust-memchr-2)
                                   ("rust-quickcheck" ,rust-quickcheck-0.9))))
    (home-page "https://github.com/bluss/odds")
    (synopsis
     "Odds and ends â collection miscellania. Extra functionality for slices (`.find()`, `RevSlice`), strings and other things. Things in odds may move to more appropriate crates if we find them.
")
    (description
     "Odds and ends â collection miscellania.  Extra functionality for slices
(`.find()`, @code{`RevSlice`),} strings and other things.  Things in odds may
move to more appropriate crates if we find them.")
    (license (list license:expat license:asl2.0))))

(define-public rust-equivalent-1
  (package
    (name "rust-equivalent")
    (version "1.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "equivalent" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1malmx5f4lkfvqasz319lq6gb3ddg19yzf9s8cykfsgzdmyq0hsl"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/cuviper/equivalent")
    (synopsis "Traits for key comparison in maps.")
    (description "Traits for key comparison in maps.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-rustc-rayon-0.5
  (package
    (name "rust-rustc-rayon")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustc-rayon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "040p2am25g3isnpsixrcrjrv70yz2lzkbq8gpv76xjipi3fam0gb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-either" ,rust-either-1)
                       ("rust-rustc-rayon-core" ,rust-rustc-rayon-core-0.5))
       #:cargo-development-inputs (("rust-rand" ,rust-rand-0.8)
                                   ("rust-rand-xorshift" ,rust-rand-xorshift-0.3))))
    (home-page "https://github.com/rust-lang/rustc-rayon")
    (synopsis "Simple work-stealing parallelism for Rust - fork for rustc")
    (description "Simple work-stealing parallelism for Rust - fork for rustc")
    (license (list license:expat license:asl2.0))))

(define-public rust-rustc-rayon-core-0.5
  (package
    (name "rust-rustc-rayon-core")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustc-rayon-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0zqbr87x58j2g9rgm2lc0254b6yqabb41jvddw99qd8fy2m8srk7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-crossbeam-deque" ,rust-crossbeam-deque-0.8)
                       ("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8)
                       ("rust-num-cpus" ,rust-num-cpus-1))
       #:cargo-development-inputs (("rust-libc" ,rust-libc-0.2)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-rand-xorshift" ,rust-rand-xorshift-0.3)
                                   ("rust-scoped-tls" ,rust-scoped-tls-1))))
    (home-page "https://github.com/rust-lang/rustc-rayon")
    (synopsis "Core APIs for Rayon - fork for rustc")
    (description "Core APIs for Rayon - fork for rustc")
    (license (list license:expat license:asl2.0))))

(define-public rust-rowan-0.15
  (package
    (name "rust-rowan")
    (version "0.15.10")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rowan" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0cpkf6m93kkwhhy5459x3w80mms01nqym34cwhzr07m3gdz584aq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-countme" ,rust-countme-3)
                       ("rust-hashbrown" ,rust-hashbrown-0.12)
                       ("rust-memoffset" ,rust-memoffset-0.8)
                       ("rust-rustc-hash" ,rust-rustc-hash-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-text-size" ,rust-text-size-1))
       #:cargo-development-inputs (("rust-m-lexer" ,rust-m-lexer-0.0.4))))
    (home-page "https://github.com/rust-analyzer/rowan")
    (synopsis "Library for generic lossless syntax trees")
    (description "Library for generic lossless syntax trees")
    (license (list license:expat license:asl2.0))))


(define-public rust-memoffset-0.8
  (package
    (name "rust-memoffset")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "memoffset" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1sl1dkcpcqyvmqv952b5jzsmxp5r9fz7hp3nhpzgmyxrgb6f4pwp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-autocfg" ,rust-autocfg-1))
       #:cargo-development-inputs (("rust-doc-comment" ,rust-doc-comment-0.3))))
    (home-page "https://github.com/Gilnaa/memoffset")
    (synopsis "offset_of functionality for Rust structs.")
    (description "offset_of functionality for Rust structs.")
    (license license:expat)))

(define-public rust-smol-str-0.1
  (package
    (name "rust-smol-str")
    (version "0.1.23")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "smol-str" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0i5b6mm2hbmvyvch3rhfx6bfl9jmijx320ffazhs5qxp52512xbl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-proptest" ,rust-proptest-1)
                                   ("rust-serde" ,rust-serde-1)
                                   ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/rust-analyzer/smol_str")
    (synopsis "small-string optimized string type with O(1) clone")
    (description "small-string optimized string type with O(1) clone")
    (license (list license:expat license:asl2.0))))

(define-public rust-strum-0.24
  (package
    (name "rust-strum")
    (version "0.24.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gz6cjhlps5idwasznklxdh2zsas6mxf99vr0n27j876q12n0gh6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf" ,rust-phf-0.10)
                       ("rust-strum-macros" ,rust-strum-macros-0.25))
       #:cargo-development-inputs (("rust-strum-macros" ,rust-strum-macros-0.25))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define-public rust-unicode-normalization-0.1
  (package
    (name "rust-unicode-normalization")
    (version "0.1.22")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unicode-normalization" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "08d95g7b1irc578b2iyhzv4xhsa4pfvwsqxcl9lbcpabzkq16msw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-tinyvec" ,rust-tinyvec-1))))
    (home-page "https://github.com/unicode-rs/unicode-normalization")
    (synopsis "This crate provides functions for normalization of
Unicode strings, including Canonical and Compatible
Decomposition and Recomposition, as described in
Unicode Standard Annex #15.
")
    (description
     "This crate provides functions for normalization of Unicode strings, including
Canonical and Compatible Decomposition and Recomposition, as described in
Unicode Standard Annex #15.")
    (license (list license:expat license:asl2.0))))

(define-public rust-lock-api-0.4
  (package
    (name "rust-lock-api")
    (version "0.4.10")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lock-api" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05nd9nzxqidg24d1k8y5vlc8lz9gscpskrikycib46qbl8brgk61"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-owning-ref" ,rust-owning-ref-0.4)
                       ("rust-scopeguard" ,rust-scopeguard-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/Amanieu/parking_lot")
    (synopsis
     "Wrappers to create fully-featured Mutex and RwLock types. Compatible with no_std.")
    (description
     "Wrappers to create fully-featured Mutex and @code{RwLock} types.  Compatible
with no_std.")
    (license (list license:expat license:asl2.0))))

(define-public rust-once-cell-1
  (package
    (name "rust-once-cell")
    (version "1.18.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "once-cell" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vapcd5ambwck95wyz3ymlim35jirgnqn9a0qmi19msymv95v2yx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-atomic-polyfill" ,rust-atomic-polyfill-1)
                       ("rust-critical-section" ,rust-critical-section-1)
                       ("rust-parking-lot-core" ,rust-parking-lot-core-0.9))
       #:cargo-development-inputs (("rust-critical-section" ,rust-critical-section-1)
                                   ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/matklad/once_cell")
    (synopsis "Single assignment cells and lazy values.")
    (description "Single assignment cells and lazy values.")
    (license (list license:expat license:asl2.0))))

(define-public rust-parking-lot-core-0.9
  (package
    (name "rust-parking-lot-core")
    (version "0.9.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "parking-lot-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ixlak319bpzldq20yvyfqk0y1vi736zxbw101jvzjp7by30rw4k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-petgraph" ,rust-petgraph-0.6)
                       ("rust-redox-syscall" ,rust-redox-syscall-0.3)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-thread-id" ,rust-thread-id-4)
                       ("rust-windows-targets" ,rust-windows-targets-0.48))))
    (home-page "https://github.com/Amanieu/parking_lot")
    (synopsis
     "An advanced API for creating custom synchronization primitives.")
    (description
     "An advanced API for creating custom synchronization primitives.")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-targets-0.48
  (package
    (name "rust-windows-targets")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-targets" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-windows-aarch64-gnullvm" ,rust-windows-aarch64-gnullvm-0.48)
                       ("rust-windows-aarch64-msvc" ,rust-windows-aarch64-msvc-0.48)
                       ("rust-windows-i686-gnu" ,rust-windows-i686-gnu-0.48)
                       ("rust-windows-i686-msvc" ,rust-windows-i686-msvc-0.48)
                       ("rust-windows-x86-64-gnu" ,rust-windows-x86-64-gnu-0.48)
                       ("rust-windows-x86-64-gnullvm" ,rust-windows-x86-64-gnullvm-0.48)
                       ("rust-windows-x86-64-msvc" ,rust-windows-x86-64-msvc-0.48))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import libs for Windows")
    (description "Import libs for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-gnullvm-0.48
  (package
    (name "rust-windows-aarch64-gnullvm")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-aarch64-gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-msvc-0.48
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-aarch64-msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-gnu-0.48
  (package
    (name "rust-windows-i686-gnu")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-i686-gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-msvc-0.48
  (package
    (name "rust-windows-i686-msvc")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-i686-msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnu-0.48
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-x86-64-gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnullvm-0.48
  (package
    (name "rust-windows-x86-64-gnullvm")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-x86-64-gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-msvc-0.48
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-x86-64-msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-segmentation-1
  (package
    (name "rust-unicode-segmentation")
    (version "1.9.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unicode-segmentation" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16gxxda9aya0arcqs9aa9lb31b3i54i34dmyqi6j5xkpszsj123y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-quickcheck" ,rust-quickcheck-0.7))))
    (home-page "https://github.com/unicode-rs/unicode-segmentation")
    (synopsis
     "This crate provides Grapheme Cluster, Word and Sentence boundaries
according to Unicode Standard Annex #29 rules.
")
    (description
     "This crate provides Grapheme Cluster, Word and Sentence boundaries according to
Unicode Standard Annex #29 rules.")
    (license (list license:expat license:asl2.0))))

(define-public rust-texlab-4
  (package
   (name "rust-texlab")
   (version "4.3.2")
   (source (origin
	    (method url-fetch)
	    (uri (crate-uri "texlab" version))
	    (file-name (string-append name "-" version ".tar.gz"))
	    (sha256
	     (base32
	      "0laxg7qprbixp20cqdy824vrxq692c2x92aqigw5a84s0b69dbrn"))))
   (build-system cargo-build-system)
   (arguments
    `(#:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
		      ("rust-byteorder" ,rust-byteorder-1)
		      ("rust-chrono" ,rust-chrono-0.4)
		      ("rust-clap" ,rust-clap-4)
		      ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
		      ("rust-dashmap" ,rust-dashmap-5)
		      ("rust-derive-more" ,rust-derive-more-0.99)
		      ("rust-dirs" ,rust-dirs-4)
		      ("rust-encoding-rs" ,rust-encoding-rs-0.8)
		      ("rust-encoding-rs-io" ,rust-encoding-rs-io-0.1)
		      ("rust-fern" ,rust-fern-0.6)
		      ("rust-flate2" ,rust-flate2-1)
		      ("rust-fuzzy-matcher" ,rust-fuzzy-matcher-0.3)
		      ("rust-human-name" ,rust-human-name-2)
		      ("rust-isocountry" ,rust-isocountry-0.3)
		      ("rust-itertools" ,rust-itertools-0.10)
		      ("rust-log" ,rust-log-0.4)
		      ("rust-logos" ,rust-logos-0.12)
		      ("rust-lsp-server" ,rust-lsp-server-0.6)
		      ("rust-lsp-types" ,rust-lsp-types-0.93)
		      ("rust-notify" ,rust-notify-5)
		      ("rust-once-cell" ,rust-once-cell-1)
		      ("rust-petgraph" ,rust-petgraph-0.6)
		      ("rust-regex" ,rust-regex-1)
		      ("rust-rowan" ,rust-rowan-0.15)
		      ("rust-rustc-hash" ,rust-rustc-hash-1)
		      ("rust-serde" ,rust-serde-1)
		      ("rust-serde-json" ,rust-serde-json-1)
		      ("rust-serde-millis" ,rust-serde-millis-0.1)
		      ("rust-serde-regex" ,rust-serde-regex-1)
		      ("rust-serde-repr" ,rust-serde-repr-0.1)
		      ("rust-smol-str" ,rust-smol-str-0.1)
		      ("rust-strum" ,rust-strum-0.24)
		      ("rust-tempfile" ,rust-tempfile-3)
		      ("rust-threadpool" ,rust-threadpool-1)
		      ("rust-titlecase" ,rust-titlecase-2)
		      ("rust-typed-builder" ,rust-typed-builder-0.11)
		      ("rust-unicode-normalization" ,rust-unicode-normalization-0.1)
		      ("rust-url" ,rust-url-2)
		      ("rust-uuid" ,rust-uuid-1))
      #:cargo-development-inputs (("rust-assert-unordered" ,rust-assert-unordered-0.3)
				  ("rust-criterion" ,rust-criterion-0.4)
				  ("rust-env-logger" ,rust-env-logger-0.9)
				  ("rust-insta" ,rust-insta-1)
				  ("rust-jod-thread" ,rust-jod-thread-0.1))))
   (home-page "https://github.com/latex-lsp/texlab")
   (synopsis "LaTeX Language Server")
   (description "@code{LaTeX} Language Server")
   (license license:gpl3))) 

;; Set emacs version according to window system
(define emacs-distribution 
  (if (equal? (getenv "XDG_SESSION_TYPE") "x11")
      "emacs-next-tree-sitter" ;; Emacs text editor `tree-sitter' support
      "emacs-next-pgtk") ;; Emacs text editor with `pgtk' and `tree-sitter' support
  )


(define-public emacs-pdf-tools
  (package
    (name "emacs-pdf-tools")
    (version "20230611.239")
    ;; (version "1.1.0")
    ;; (source
    ;;  (origin
    ;;    (method git-fetch)
    ;;    (uri (git-reference
    ;;          (url "https://github.com/vedang/pdf-tools")
    ;;          (commit (string-append "v" version))))
    ;;    (file-name (git-file-name name version))
    ;;    (sha256
    ;;     (base32 "1v861fpzck3ky21m4g42h6a6y0cbhc4sjzpzqx0zxd7sfi7rn768"))))
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/vedang/pdf-tools.git")
               (commit
                 "c69e7656a4678fe25afbd29f3503dd19ee7f9896")))
        (sha256
          (base32
            "02l1mwil0r8zgg3377i6zy8cz6kl48hncgyl8x6aigxrrqzsxvza"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; there are no tests
       #:modules ((guix build gnu-build-system)
                  ((guix build emacs-build-system) #:prefix emacs:)
                  (guix build utils)
                  (guix build emacs-utils))
       #:imported-modules (,@%gnu-build-system-modules
                           (guix build emacs-build-system)
                           (guix build emacs-utils))
       #:phases
       (modify-phases %standard-phases
         ;; Build server side using 'gnu-build-system'.
         (add-after 'unpack 'enter-server-dir
           (lambda _ (chdir "server")))
         (add-after 'enter-server-dir 'autogen
           (lambda _
             (invoke "bash" "autogen.sh")))
         ;; Build emacs side using 'emacs-build-system'.
         (add-after 'compress-documentation 'enter-lisp-dir
           (lambda _ (chdir "../lisp")))
         (add-after 'enter-lisp-dir 'emacs-patch-variables
           (lambda* (#:key outputs #:allow-other-keys)
             (for-each make-file-writable (find-files "."))

             ;; Set path to epdfinfo program.
             (emacs-substitute-variables "pdf-info.el"
               ("pdf-info-epdfinfo-program"
                (string-append (assoc-ref outputs "out")
                               "/bin/epdfinfo")))
             ;; Set 'pdf-tools-handle-upgrades' to nil to avoid "auto
             ;; upgrading" that pdf-tools tries to perform.
             (emacs-substitute-variables "pdf-tools.el"
               ("pdf-tools-handle-upgrades" '()))))
         (add-after 'emacs-patch-variables 'emacs-expand-load-path
           (assoc-ref emacs:%standard-phases 'expand-load-path))
         (add-after 'emacs-expand-load-path 'emacs-add-install-to-native-load-path
           (assoc-ref emacs:%standard-phases 'add-install-to-native-load-path))
         (add-after 'emacs-add-install-to-native-load-path 'emacs-install
           (assoc-ref emacs:%standard-phases 'install))
         (add-after 'emacs-install 'emacs-build
           (assoc-ref emacs:%standard-phases 'build))
         (add-after 'emacs-install 'emacs-make-autoloads
           (assoc-ref emacs:%standard-phases 'make-autoloads)))))
    (native-inputs
     (list autoconf automake emacs-minimal pkg-config))
    (inputs
     (list cairo glib libpng poppler zlib))
    (propagated-inputs
     (list emacs-tablist))
    (home-page "https://github.com/vedang/pdf-tools")
    (synopsis "Emacs support library for PDF files")
    (description
     "PDF Tools is, among other things, a replacement of DocView for PDF
files.  The key difference is that pages are not pre-rendered by
e.g. ghostscript and stored in the file-system, but rather created on-demand
and stored in memory.")
    (license license:gpl3+)))


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
    "emacs-lsp-julia" ;; Julia support for lsp-mode
    "emacs-lsp-latex" ;; LSP-mode client for LaTeX, on texlab
    "emacs-lsp-ltex"
    "emacs-lsp-mode"
    "emacs-lsp-julia" ;; Julia support for lsp-mode
    "emacs-lsp-scheme"

    "autoconf"
    "automake"
    "pkg-config"
    "texinfo"
    "guile@3.0"
    "guile-srfi-145"
    "guile-srfi-180"
    "guile-irregex"



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
    ;; "emacs-pdf-tools" ;; Emacs support library for PDF files
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
    "python-orjson" ;; Python JSON library supporting dataclasses, datetimes, and numpy
    "python-paramiko" ;; SSHv2 protocol library
    "python-pylint" ;; Advanced Python code static checker
    "python-sexpdata" ;; S-expression parser for Python
    "python-six" ;; Python 2 and 3 compatibility utilities
    "sqls" ;; SQL language server written in Go
    ;; "texlive-scripts" ;; TeX Live infrastructure programs 
    ;; "texlive-luatex" ;; Extended version of pdfTeX using Lua
    ;; "texlive-digestif" ;; Editor plugin for LaTeX, ConTeXt etc.
    "tar" ;; Managing tar archives
    "tree-sitter"
    "unzip" ;; Decompression and file extraction utility
    "zip" 
    ;;"texlive-digestif" ;;Editor plugin for LaTeX, ConTeXt etc.
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
    ;;"emacs-pulseaudio-control" ;; Control Pulseaudio from Emacs
    ;;"emacs-simple-modeline" ;; Simple mode-line configuration for Emacs
    ;;"emacs-simple-mpc" ;; Simple Emacs frontend to mpc
    ;;"emacs-straight-el" ;; Purely functional package manager for the Emacs hacker
    ;;"mplayer" ;; Audio and video player
    ;;"python-flake8" ;; The modular source code checker: pep8, pyflakes and co
  (packages->manifest (list
		       ;; Under diffinition
		       ;; rust-texlab-4
		       ;; FIXME: collide with emacs-vterm
		       ;;emacs-r-vterm

		       ;; FIXME: collide with emacs-guix through emacs-dash
		       ;;emacs-eglot-ltex

		   ;;    emacs-pdf-tools-alt ;; don't work
		       ;;emacs-pdf-tools-alt2 ;; don't work
		       ;;emacs-pdf-tools-alt3
		       emacs-pdf-tools
		       ))
  ))
