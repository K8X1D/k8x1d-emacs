(list 
 ;; Melpa channel
 (channel
  (name 'emacs)
  (url "https://github.com/babariviere/guix-emacs")
  (branch "master")
  ;; (commit "d97e9dedc55101c6966000912e430b858e47cbfd")
  (introduction
   (make-channel-introduction
    "72ca4ef5b572fea10a4589c37264fa35d4564783"
    (openpgp-fingerprint
     "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18"))))
 (channel
  (name 'guix)
  (url "https://git.savannah.gnu.org/git/guix.git")
  (branch "master")
  ;; (commit "cc4cb24ed5d9f5104084169d284fbec53bcebebf")
  (introduction
   (make-channel-introduction
    "9edb3f66fd807b096b48283debdcddccfea34bad"
    (openpgp-fingerprint
     "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
 )
      
