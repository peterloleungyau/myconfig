(use-modules (guix)
             (guix licenses)
             (guix download)
             (guix git-download)
             (gnu packages cran)
             (gnu packages statistics)
             (guix build-system r))

(define-public r-collections
  (package
    (name "r-collections")
    (version "0.3.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "collections" version))
        (sha256
          (base32
            "053ig88pva78wxxwya3v7cz853k563dkpgxrf2xvd0l0d9fanxmz"))))
    (properties `((upstream-name . "collections")))
    (build-system r-build-system)
    (home-page
      "https://github.com/randy3k/collections")
    (synopsis
      "High Performance Container Data Types")
    (description
      "This package provides high performance container data types such as queues, stacks, deques, dicts and ordered dicts.  Benchmarks <https://randy3k.github.io/collections/articles/benchmark.html> have shown that these containers are asymptotically more efficient than those offered by other packages.")
    (license expat)))

(define-public r-languageserver
  (package
    (name "r-languageserver")
    (version "0.3.9")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "languageserver" version))
        (sha256
          (base32
            "1acjzc8ar3y0g8prwnsp7k3mgvg01h73mnyb4q2s3r7wkb4aqhrv"))))
    (properties
      `((upstream-name . "languageserver")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-callr" ,r-callr)
        ("r-collections" ,r-collections)
        ("r-desc" ,r-desc)
        ("r-fs" ,r-fs)
        ("r-jsonlite" ,r-jsonlite)
        ("r-lintr" ,r-lintr)
        ("r-r6" ,r-r6)
        ("r-repr" ,r-repr)
        ("r-roxygen2" ,r-roxygen2)
        ("r-stringi" ,r-stringi)
        ("r-styler" ,r-styler)
        ("r-xml2" ,r-xml2)
        ("r-xmlparsedata" ,r-xmlparsedata)))
    (home-page
      "https://github.com/REditorSupport/languageserver/")
    (synopsis "Language Server Protocol")
    (description
      "An implementation of the Language Server Protocol for R.  The Language Server protocol is used by an editor client to integrate features like auto completion.  See <https://microsoft.github.io/language-server-protocol/> for details.")
    (license expat)))

;;
r-languageserver
