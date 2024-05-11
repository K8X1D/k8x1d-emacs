(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "703ae431f4ad28658e34675310b4fdf58685ccdd")
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
          "6117adbb7e47db3eccf205364a0f3245b682a7bb")
        (introduction
          (make-channel-introduction
            "72ca4ef5b572fea10a4589c37264fa35d4564783"
            (openpgp-fingerprint
              "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18")))))
