(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "c4b9f726e3a1889b92a4b14a2af1c25f10798469")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (branch "master")
        (commit
          "454aa47bee3c841c5b6f7bc0bc71ed7a65d91d38")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
        (name 'guix-science)
        (url "https://github.com/guix-science/guix-science.git")
        (branch "master")
        (commit
          "1ad5192cff0d7b34a2f74592c6896f901d1c9ccd")
        (introduction
          (make-channel-introduction
            "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
            (openpgp-fingerprint
              "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
      (channel
        (name 'home-service-dwl-guile)
        (url "https://github.com/engstrand-config/home-service-dwl-guile")
        (branch "main")
        (commit
          "179ce7f0cb8db17987e876422d86b6d4e3717025")
        (introduction
          (make-channel-introduction
            "314453a87634d67e914cfdf51d357638902dd9fe"
            (openpgp-fingerprint
              "C9BE B8A0 4458 FDDF 1268  1B39 029D 8EB7 7E18 D68C"))))
      (channel
        (name 'home-service-dtao-guile)
        (url "https://github.com/engstrand-config/home-service-dtao-guile")
        (branch "main")
        (commit
          "ad32455058d588452519edf49f761eb298c9e9bd")
        (introduction
          (make-channel-introduction
            "64d0b70c547095ddc840dd07424b9a46ccc2e64e"
            (openpgp-fingerprint
              "C9BE B8A0 4458 FDDF 1268  1B39 029D 8EB7 7E18 D68C")))))
