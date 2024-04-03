(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
         "14210b7f58ad76605fa9859395a1b57666a5c7c4")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'emacs)
        (url "https://github.com/babariviere/guix-emacs")
        (branch "master")
        (commit
          "15d5b95289cc9a96fb71e73b62096ddce0986c7f")
        (introduction
          (make-channel-introduction
            "72ca4ef5b572fea10a4589c37264fa35d4564783"
            (openpgp-fingerprint
              "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18")))))
