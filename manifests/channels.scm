(list
 ;; Access to nongnu packages ;; necessery for laptop wifi and cpu updates
 (channel
  (name 'nonguix)
  (url "https://gitlab.com/nonguix/nonguix")
  (branch "master")
  ;;(commit "9d58bb6e3e93a444d35bf62d4ca98a126ae4f295")
  (commit "51b5ce6902b6c7bacfc2ed43e8810ac0bca7f8e7")
  (introduction
   (make-channel-introduction
    "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
    (openpgp-fingerprint
     "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
 ;; Defaults guix channel
 (channel
  (name 'guix)
  (url "https://git.savannah.gnu.org/git/guix.git")
  (branch "master")
  ;;(commit "8b855dc1f4a3e31c002c229ad4d91525f4ce97d3")
  (commit "b3adba7b5ef3bb56509710b1596225017f1342cc")
  (introduction
   (make-channel-introduction
    "9edb3f66fd807b096b48283debdcddccfea34bad"
    (openpgp-fingerprint
     "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
 )
