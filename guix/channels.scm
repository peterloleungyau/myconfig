(list (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (commit
          "51dc6fb07ea1984f2ce55a44b0ce998200fb0e5c")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
        (name 'guix)
        (url "https://git.sjtu.edu.cn/sjtug/guix.git")
        (commit
          "0efd68681dcec50d445a4fd080c315b999164828")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
