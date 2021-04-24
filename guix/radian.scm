(use-modules (guix)
             (guix licenses)
             (guix download)
             (guix git-download)
             (gnu packages statistics)
             (gnu packages python)
             (gnu packages python-science)
             (gnu packages python-xyz)
             (gnu packages libffi)
             (gnu packages check)
             (gnu packages terminals)
             (guix build-system python))

(define-public python-lineedit
  (package
    (name "python-lineedit")
    (version "0.1.6")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "lineedit" version))
        (sha256
          (base32
            "0gvggy22s3qlz3r5lrwr5f4hzwbq7anyd2vfrzchldaf2mwm8ygl"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f))
    (propagated-inputs
      `(("python-pygments" ,python-pygments)
        ("python-six" ,python-six)
        ("python-wcwidth" ,python-wcwidth)))
    (native-inputs
      `(("python-pexpect" ,python-pexpect)
        ("python-ptyprocess" ,python-ptyprocess)
        ("python-pyte" ,python-pyte)
        ("python-pytest" ,python-pytest)
        ("python-pytest-cov" ,python-pytest-cov)))
    (home-page "https://github.com/randy3k/lineedit")
    (synopsis
      "An readline library based on prompt_toolkit which supports multiple modes")
    (description
      "An readline library based on prompt_toolkit which supports multiple modes")
    (license #f)))

(define-public python-rchitect
  (package
    (name "python-rchitect")
    (version "0.3.30")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "rchitect" version))
        (sha256
          (base32
            "1bg5vrgp447czgmjjky84yqqk2mfzwwgnf0m99lqzs7jq15q8ziv"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f))
    (propagated-inputs
      `(("python-cffi" ,python-cffi)
        ("python-six" ,python-six)))
    (native-inputs
      `(("python-pytest" ,python-pytest)
        ("python-pytest-runner" ,python-pytest-runner)
        ("python-pytest-cov" ,python-pytest-cov)
        ("python-pytest-mock" ,python-pytest-mock)))
    (home-page "https://github.com/randy3k/rchitect")
    (synopsis "Mapping R API to Python")
    (description "Mapping R API to Python")
    (license #f)))

(define-public python-pyte
  (package
    (name "python-pyte")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pyte" version))
       (sha256
        (base32
         "1ic8b9xrg76z55qrvbgpwrgg0mcq0dqgy147pqn2cvrdjwzd0wby"))))
    (build-system python-build-system)
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'remove-failing-test
           ;; TODO: Reenable when the `captured` files required by this test
           ;; are included in the archive.
           (lambda _
             (delete-file "tests/test_input_output.py")
             #t)))))
    (propagated-inputs
     `(("python-wcwidth" ,python-wcwidth)))
    (native-inputs
     `(("python-pytest-runner" ,python-pytest-runner)
       ("python-pytest" ,python-pytest)))
    (home-page "https://pyte.readthedocs.io/")
    (synopsis "Simple VTXXX-compatible terminal emulator")
    (description "@code{pyte} is an in-memory VTxxx-compatible terminal
emulator.  @var{VTxxx} stands for a series of video terminals, developed by
DEC between 1970 and 1995.  The first and probably most famous one was the
VT100 terminal, which is now a de-facto standard for all virtual terminal
emulators.

pyte is a fork of vt102, which was an incomplete pure Python implementation
of VT100 terminal.")
    (license lgpl3+)))

(define-public python-radian
  (package
    (name "python-radian")
    (version "0.5.10")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "radian" version))
        (sha256
          (base32
            "0plkv3qdgfxyrmg2k6c866q5p7iirm46ivhq2ixs63zc05xdbg8s"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f))
    (propagated-inputs
      `(("python-lineedit" ,python-lineedit)
        ("python-pygments" ,python-pygments)
        ("python-rchitect" ,python-rchitect)
        ("python-six" ,python-six)))
    (native-inputs
      `(("python-coverage" ,python-coverage)
        ("python-pexpect" ,python-pexpect)
        ("python-ptyprocess" ,python-ptyprocess)
        ("python-pytest-runner" ,python-pytest-runner)
        ("python-pyte" ,python-pyte)
        ("python-pytest" ,python-pytest)))
    (home-page "https://github.com/randy3k/radian")
    (synopsis "A 21 century R console")
    (description "A 21 century R console")
    (license #f)))

;;
python-radian
