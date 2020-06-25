(define-module (statistics-other)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix hg-download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system r)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cran)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages java)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages base)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (srfi srfi-1))

(define-public r-collections
  (package
    (name "r-collections")
    (version "0.3.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "collections" version))
        (sha256
          (base32
            "0v6ypmm71iyjbvzmgx90v4ihln27vdbackn2nps9r1ka8rvc196s"))))
    (properties `((upstream-name . "collections")))
    (build-system r-build-system)
    (propagated-inputs `(("r-digest" ,r-digest)))
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
    (version "0.3.6")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "languageserver" version))
        (sha256
          (base32
            "0kmpjz1f4lji477l40qjii889z4vy4z837ryc01p1i957ca0gyr2"))))
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
        ("r-stringi" ,r-stringi)
        ("r-styler" ,r-styler)
        ("r-xml2" ,r-xml2)
        ("r-xmlparsedata" ,r-xmlparsedata)))
    (home-page
      "https://github.com/REditorSupport/languageserver")
    (synopsis "Language Server Protocol")
    (description
      "An implementation of the Language Server Protocol for R.  The Language Server protocol is used by an editor client to integrate features like auto completion.  See <https://microsoft.github.io/language-server-protocol> for details.")
    (license expat)))

(define-public r-boruta
  (package
    (name "r-boruta")
    (version "7.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "Boruta" version))
        (sha256
          (base32
            "0y2w4wb45kfnzrxcrdsiwgal9fsnlr3wad1sqdc70qv8gp921xbg"))))
    (properties `((upstream-name . "Boruta")))
    (build-system r-build-system)
    (propagated-inputs `(("r-ranger" ,r-ranger)))
    (home-page "https://gitlab.com/mbq/Boruta/")
    (synopsis
      "Wrapper Algorithm for All Relevant Feature Selection")
    (description
      "An all relevant feature selection wrapper algorithm.  It finds relevant features by comparing original attributes' importance with importance achievable at random, estimated using their permuted copies (shadows).")
    (license gpl2+)))

(define-public r-rismed
  (package
    (name "r-rismed")
    (version "2.1.7")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "RISmed" version))
        (sha256
          (base32
            "08dmkkxsmwp9b4h2g1bbx03cijn793fsnzkmbima8x9d42vxnm1l"))))
    (properties `((upstream-name . "RISmed")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/RISmed")
    (synopsis "Download Content from NCBI Databases")
    (description
      "This package provides a set of tools to extract bibliographic content from the National Center for Biotechnology Information (NCBI) databases, including PubMed.  The name RISmed is a portmanteau of RIS (for Research Information Systems, a common tag format for bibliographic data) and PubMed.")
    (license gpl2+)))

(define-public r-semver
  (package
    (name "r-semver")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "semver" version))
        (sha256
          (base32
            "10wpkyms2cix3bsin2q0qhkbl445pwwpa5gm2s4jjw1989namkxy"))))
    (properties `((upstream-name . "semver")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-assertthat" ,r-assertthat)
        ("r-rcpp" ,r-rcpp)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/johndharrison/semver")
    (synopsis "'Semantic Versioning V2.0.0' Parser")
    (description
      "Tools and functions for parsing, rendering and operating on semantic version strings.  Semantic versioning is a simple set of rules and requirements that dictate how version numbers are assigned and incremented as outlined at <http://semver.org>.")
    (license expat)))

(define-public r-binman
  (package
    (name "r-binman")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "binman" version))
        (sha256
          (base32
            "0hm0h285p4v9lhrqjy8s22f1s1vmfpfla5iaycpj8vw3qb3632az"))))
    (properties `((upstream-name . "binman")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-assertthat" ,r-assertthat)
        ("r-httr" ,r-httr)
        ("r-jsonlite" ,r-jsonlite)
        ("r-rappdirs" ,r-rappdirs)
        ("r-semver" ,r-semver)
        ("r-xml2" ,r-xml2)
        ("r-yaml" ,r-yaml)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/ropensci/binman")
    (synopsis "A Binary Download Manager")
    (description
      "Tools and functions for managing the download of binary files.  Binary repositories are defined in 'YAML' format.  Defining new pre-download, download and post-download templates allow additional repositories to be added.")
    (license expat)))

(define-public r-wdman
  (package
    (name "r-wdman")
    (version "0.2.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "wdman" version))
        (sha256
          (base32
            "1yf41lsrr9dbf5n4f5hv9mlmzl736fhnp9gxkm2g9apws6gsig02"))))
    (properties `((upstream-name . "wdman")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-assertthat" ,r-assertthat)
        ("r-binman" ,r-binman)
        ("r-processx" ,r-processx)
        ("r-semver" ,r-semver)
        ("r-yaml" ,r-yaml)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://docs.ropensci.org/wdman")
    (synopsis
      "'Webdriver'/'Selenium' Binary Manager")
    (description
      "There are a number of binary files associated with the 'Webdriver'/'Selenium' project (see <http://www.seleniumhq.org/download/>, <https://sites.google.com/a/chromium.org/chromedriver/>, <https://github.com/mozilla/geckodriver>, <http://phantomjs.org/download.html> and <https://github.com/SeleniumHQ/selenium/wiki/InternetExplorerDriver> for more information).  This package provides functions to download these binaries and to manage processes involving them.")
    (license expat)))

(define-public r-rselenium
  (package
    (name "r-rselenium")
    (version "1.7.7")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "RSelenium" version))
        (sha256
          (base32
            "1xn5fdbzmq7b1f5fc9ls23g177bmnd8bn4p4d8aafr6z3jwkmfir"))))
    (properties `((upstream-name . "RSelenium")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-binman" ,r-binman)
        ("r-catools" ,r-catools)
        ("r-httr" ,r-httr)
        ("r-openssl" ,r-openssl)
        ("r-wdman" ,r-wdman)
        ("r-xml" ,r-xml)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "http://docs.ropensci.org/RSelenium")
    (synopsis "R Bindings for 'Selenium WebDriver'")
    (description
      "This package provides a set of R bindings for the 'Selenium 2.0 WebDriver' (see <https://selenium.dev/documentation/en/> for more information) using the 'JsonWireProtocol' (see <https://github.com/SeleniumHQ/selenium/wiki/JsonWireProtocol> for more information). 'Selenium 2.0 WebDriver' allows driving a web browser natively as a user would either locally or on a remote machine using the Selenium server it marks a leap forward in terms of web browser automation.  Selenium automates web browsers (commonly referred to as browsers).  Using RSelenium you can automate browsers locally or remotely.")
    (license agpl3+)))

(define-public r-shapforxgboost
  (package
    (name "r-shapforxgboost")
    (version "0.0.4")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "SHAPforxgboost" version))
        (sha256
          (base32
            "0k6bg27wqnkzv82bcahbapmqhiz6rvnx81m23zbjw58c7lwshgnq"))))
    (properties
      `((upstream-name . "SHAPforxgboost")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-bbmisc" ,r-bbmisc)
        ("r-data-table" ,r-data-table)
        ("r-ggextra" ,r-ggextra)
        ("r-ggforce" ,r-ggforce)
        ("r-ggplot2" ,r-ggplot2)
        ("r-ggpubr" ,r-ggpubr)
        ("r-rcolorbrewer" ,r-rcolorbrewer)
        ("r-xgboost" ,r-xgboost)))
    (home-page
      "https://github.com/liuyanguu/SHAPforxgboost")
    (synopsis "SHAP Plots for 'XGBoost'")
    (description
      "The aim of 'SHAPforxgboost' is to aid in visual data investigations using SHAP (SHapley Additive exPlanation) visualization plots for 'XGBoost'.  It provides summary plot, dependence plot, interaction plot, and force plot.  It relies on the 'dmlc/xgboost' package to produce SHAP values.  Please refer to 'slundberg/shap' for the original implementation of SHAP in 'Python'.")
    (license expat)))

(define-public r-fastshap
  (package
    (name "r-fastshap")
    (version "0.0.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "fastshap" version))
        (sha256
          (base32
            "08f25ib5mry6h8lvj0g3clc9kfl5g2wdd8x8bw455wwmbcm6x5vg"))))
    (properties `((upstream-name . "fastshap")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-abind" ,r-abind)
        ("r-ggplot2" ,r-ggplot2)
        ("r-gridextra" ,r-gridextra)
        ("r-matrixstats" ,r-matrixstats)
        ("r-plyr" ,r-plyr)
        ("r-rcpp" ,r-rcpp)
        ("r-rcpparmadillo" ,r-rcpparmadillo)
        ("r-tibble" ,r-tibble)))
    (home-page
      "https://github.com/bgreenwell/fastshap")
    (synopsis "Fast Approximate Shapley Values")
    (description
      "Computes fast (relative to other implementations) approximate Shapley values for any supervised learning model.  Shapley values help to explain the predictions from any black box model using ideas from game theory; see Strumbel and Kononenko (2014) <doi:10.1007/s10115-013-0679-x> for details.")
    (license gpl2+)))

(define-public r-muhaz
  (package
    (name "r-muhaz")
    (version "1.2.6.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "muhaz" version))
        (sha256
          (base32
            "08qh43zx6h3yby44q2vxphfvmfdmqxpgyp0734yn341sy9n8pkkk"))))
    (properties `((upstream-name . "muhaz")))
    (build-system r-build-system)
    (propagated-inputs `(("r-survival" ,r-survival)))
    (native-inputs `(("gfortran" ,gfortran)))
    (home-page
      "https://cran.r-project.org/web/packages/muhaz")
    (synopsis
      "Hazard Function Estimation in Survival Analysis")
    (description
      "Produces a smooth estimate of the hazard function for censored data.")
    (license (list gpl2+ gpl3+))))

(define-public r-flexsurv
  (package
    (name "r-flexsurv")
    (version "1.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "flexsurv" version))
        (sha256
          (base32
            "0x7p1rv51pplfyyzcg63ssb8z56mig7y0363hkr0219w3cvyq9nr"))))
    (properties `((upstream-name . "flexsurv")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-desolve" ,r-desolve)
        ("r-mstate" ,r-mstate)
        ("r-muhaz" ,r-muhaz)
        ("r-mvtnorm" ,r-mvtnorm)
        ("r-quadprog" ,r-quadprog)
        ("r-rcpp" ,r-rcpp)
        ("r-survival" ,r-survival)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/chjackson/flexsurv-dev")
    (synopsis
      "Flexible Parametric Survival and Multi-State Models")
    (description
      "Flexible parametric models for time-to-event data, including the Royston-Parmar spline model, generalized gamma and generalized F distributions.  Any user-defined parametric distribution can be fitted, given at least an R function defining the probability density or hazard.  There are also tools for fitting and predicting from fully parametric multi-state models.")
    (license gpl2+)))

(define-public r-metrics
  (package
    (name "r-metrics")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "Metrics" version))
        (sha256
          (base32
            "0fh8qbjlwzagh272lgwr4bxcqcjb1qpz53mgs8rzlvncax6nk5bk"))))
    (properties `((upstream-name . "Metrics")))
    (build-system r-build-system)
    (home-page "https://github.com/mfrasco/Metrics")
    (synopsis
      "Evaluation Metrics for Machine Learning")
    (description
      "An implementation of evaluation metrics in R that are commonly used in supervised machine learning.  It implements metrics for regression, time series, binary classification, classification, and information retrieval problems.  It has zero dependencies and a consistent, simple interface for all functions.")
    (license bsd-3)))

(define-public r-iml
  (package
    (name "r-iml")
    (version "0.10.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "iml" version))
        (sha256
          (base32
            "0xm3q42qahq798ilgg050df0mahhbdfd3fx3i7cpx606h38si0x7"))))
    (properties `((upstream-name . "iml")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-checkmate" ,r-checkmate)
        ("r-data-table" ,r-data-table)
        ("r-formula" ,r-formula)
        ("r-future" ,r-future)
        ("r-future-apply" ,r-future-apply)
        ("r-ggplot2" ,r-ggplot2)
        ("r-gridextra" ,r-gridextra)
        ("r-metrics" ,r-metrics)
        ("r-prediction" ,r-prediction)
        ("r-r6" ,r-r6)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/christophM/iml")
    (synopsis "Interpretable Machine Learning")
    (description
      "Interpretability methods to analyze the behavior and predictions of any machine learning model.  Implemented methods are: Feature importance described by Fisher et al. (2018) <arXiv:1801.01489>, accumulated local effects plots described by Apley (2018) <arXiv:1612.08468>, partial dependence plots described by Friedman (2001) <http://www.jstor.org/stable/2699986>, individual conditional expectation ('ice') plots described by Goldstein et al. (2013) <doi:10.1080/10618600.2014.907095>, local models (variant of 'lime') described by Ribeiro et.  al (2016) <arXiv:1602.04938>, the Shapley Value described by Strumbelj et.  al (2014) <doi:10.1007/s10115-013-0679-x>, feature interactions described by Friedman et.  al <doi:10.1214/07-AOAS148> and tree surrogate models.")
    (license expat)))

(define-public r-profmem
  (package
    (name "r-profmem")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "profmem" version))
        (sha256
          (base32
            "152dka39p9i17ydlhc92y6x6i8girn3wab1ycbqb9kva07j9d2h8"))))
    (properties `((upstream-name . "profmem")))
    (build-system r-build-system)
    (home-page
      "https://github.com/HenrikBengtsson/profmem")
    (synopsis "Simple Memory Profiling for R")
    (description
      "This package provides a simple and light-weight API for memory profiling of R expressions.  The profiling is built on top of R's built-in memory profiler ('utils::Rprofmem()'), which records every memory allocation done by R (also native code).")
    (license lgpl2.1+)))

(define-public r-randomforestsrc
  (package
    (name "r-randomforestsrc")
    (version "2.9.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "randomForestSRC" version))
        (sha256
          (base32
            "05ifvj49jv0n5p6k46milpgj9r10sc5aw23fypyyibdgwpwvwixw"))))
    (properties
      `((upstream-name . "randomForestSRC")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/randomForestSRC")
    (synopsis
      "Fast Unified Random Forests for Survival, Regression, and Classification (RF-SRC)")
    (description
      "Fast OpenMP parallel computing of Breiman's random forests for survival, competing risks, regression and classification based on Ishwaran and Kogalur's popular random survival forests (RSF) package.  Handles missing data and now includes multivariate, unsupervised forests, quantile regression and solutions for class imbalanced data.  New fast interface using subsampling and confidence regions for variable importance.")
    (license gpl3+)))

(define-public r-r2d3
  (package
    (name "r-r2d3")
    (version "0.2.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "r2d3" version))
        (sha256
          (base32
            "0v612mbzdjr8cq1ffall9hagbwxfv7fh963x8f0w5r84v1m3y2bl"))))
    (properties `((upstream-name . "r2d3")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-htmltools" ,r-htmltools)
        ("r-htmlwidgets" ,r-htmlwidgets)
        ("r-jsonlite" ,r-jsonlite)
        ("r-rstudioapi" ,r-rstudioapi)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/rstudio/r2d3")
    (synopsis "Interface to 'D3' Visualizations")
    (description
      "Suite of tools for using 'D3', a library for producing dynamic, interactive data visualizations.  Supports translating objects into 'D3' friendly data structures, rendering 'D3' scripts, publishing 'D3' visualizations, incorporating 'D3' in R Markdown, creating interactive 'D3' applications with Shiny, and distributing 'D3' based 'htmlwidgets' in R packages.")
    (license bsd-3)))

(define-public r-forge
  (package
    (name "r-forge")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "forge" version))
        (sha256
          (base32
            "0pjfzsc35agkh0zfw2czwajkbsyn6liys5irl5bhz5r1vim3jmwa"))))
    (properties `((upstream-name . "forge")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-magrittr" ,r-magrittr) ("r-rlang" ,r-rlang)))
    (home-page
      "https://cran.r-project.org/web/packages/forge")
    (synopsis "Casting Values into Shape")
    (description
      "Helper functions with a consistent interface to coerce and verify the types and shapes of values for input checking.")
    (license #f)))

(define-public r-config
  (package
    (name "r-config")
    (version "0.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "config" version))
        (sha256
          (base32
            "0l67nfpm42ssnk0bl4jmq6bibz8hawgfgh2s14s5c8mnimv6mpjs"))))
    (properties `((upstream-name . "config")))
    (build-system r-build-system)
    (propagated-inputs `(("r-yaml" ,r-yaml)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/rstudio/config")
    (synopsis
      "Manage Environment Specific Configuration Values")
    (description
      "Manage configuration values across multiple environments (e.g.  development, test, production).  Read values using a function that determines the current environment and returns the appropriate value.")
    (license gpl3)))

(define-public r-sparklyr
  (package
    (name "r-sparklyr")
    (version "1.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "sparklyr" version))
        (sha256
          (base32
            "1bj9ndyz6nb7mw1pq0gksmw3xpwfjrj0mfmiiazzs3rvp91ap47c"))))
    (properties `((upstream-name . "sparklyr")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-assertthat" ,r-assertthat)
        ("r-base64enc" ,r-base64enc)
        ("r-config" ,r-config)
        ("r-dbi" ,r-dbi)
        ("r-dbplyr" ,r-dbplyr)
        ("r-digest" ,r-digest)
        ("r-dplyr" ,r-dplyr)
        ("r-ellipsis" ,r-ellipsis)
        ("r-forge" ,r-forge)
        ("r-generics" ,r-generics)
        ("r-globals" ,r-globals)
        ("r-httr" ,r-httr)
        ("r-jsonlite" ,r-jsonlite)
        ("r-openssl" ,r-openssl)
        ("r-purrr" ,r-purrr)
        ("r-r2d3" ,r-r2d3)
        ("r-rappdirs" ,r-rappdirs)
        ("r-rjson" ,r-rjson)
        ("r-rlang" ,r-rlang)
        ("r-rprojroot" ,r-rprojroot)
        ("r-rstudioapi" ,r-rstudioapi)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)
        ("r-withr" ,r-withr)
        ("r-xml2" ,r-xml2)))
    (home-page "http://spark.rstudio.com")
    (synopsis "R Interface to Apache Spark")
    (description
      "R interface to Apache Spark, a fast and general engine for big data processing, see <http://spark.apache.org>.  This package supports connecting to local and remote Apache Spark clusters, provides a 'dplyr' compatible back-end, and provides an interface to Spark's built-in machine learning algorithms.")
    (license #f)))

(define-public r-km-ci
  (package
    (name "r-km-ci")
    (version "0.5-2")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "km.ci" version))
        (sha256
          (base32
            "1l6kw8jppaa1802yc5pbfwwgac56nhwc9p076ivylhms4w7cdf8v"))))
    (properties `((upstream-name . "km.ci")))
    (build-system r-build-system)
    (propagated-inputs `(("r-survival" ,r-survival)))
    (home-page
      "https://cran.r-project.org/web/packages/km.ci")
    (synopsis
      "Confidence intervals for the Kaplan-Meier estimator")
    (description
      "Computes various confidence intervals for the Kaplan-Meier estimator, namely: Petos CI, Rothman CI, CI's based on Greenwoods variance, Thomas and Grunkemeier CI and the simultaneous confidence bands by Nair and Hall and Wellner.")
    (license gpl2+)))

(define-public r-kmsurv
  (package
    (name "r-kmsurv")
    (version "0.1-5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "KMsurv" version))
        (sha256
          (base32
            "0hi5vvk584rl70gbrr75w9hc775xmbxnaig0dd6hlpi4071pnqjm"))))
    (properties `((upstream-name . "KMsurv")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/KMsurv")
    (synopsis
      "Data sets from Klein and Moeschberger (1997), Survival Analysis")
    (description
      "Data sets and functions for Klein and Moeschberger (1997), \"Survival Analysis, Techniques for Censored and Truncated Data\", Springer.")
    (license gpl3+)))

(define-public r-survmisc
  (package
    (name "r-survmisc")
    (version "0.5.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "survMisc" version))
        (sha256
          (base32
            "00nvvl8gz4477ab24rd0xvfksm8msv8h021b9ld5c9cizc41n2bm"))))
    (properties `((upstream-name . "survMisc")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-data-table" ,r-data-table)
        ("r-ggplot2" ,r-ggplot2)
        ("r-gridextra" ,r-gridextra)
        ("r-km-ci" ,r-km-ci)
        ("r-kmsurv" ,r-kmsurv)
        ("r-knitr" ,r-knitr)
        ("r-survival" ,r-survival)
        ("r-xtable" ,r-xtable)
        ("r-zoo" ,r-zoo)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://cran.r-project.org/web/packages/survMisc")
    (synopsis
      "Miscellaneous Functions for Survival Data")
    (description
      "This package provides a collection of functions to help in the analysis of right-censored survival data.  These extend the methods available in package:survival.")
    (license gpl2)))

(define-public r-exactranktests
  (package
    (name "r-exactranktests")
    (version "0.8-31")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "exactRankTests" version))
        (sha256
          (base32
            "1154dkcid3njhamdp87qs9bnx7l8bdqkcjsds9q9f2xmizs9x8gw"))))
    (properties
      `((upstream-name . "exactRankTests")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/exactRankTests")
    (synopsis
      "Exact Distributions for Rank and Permutation Tests")
    (description
      "Computes exact conditional p-values and quantiles using an implementation of the Shift-Algorithm by Streitberg & Roehmel.")
    (license gpl2+)))

(define-public r-maxstat
  (package
    (name "r-maxstat")
    (version "0.7-25")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "maxstat" version))
        (sha256
          (base32
            "114z1rwxwvk05ijjhdppzm148n1h192fp0w12ky10zkrhf6kphbg"))))
    (properties `((upstream-name . "maxstat")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-exactranktests" ,r-exactranktests)
        ("r-mvtnorm" ,r-mvtnorm)))
    (home-page
      "https://cran.r-project.org/web/packages/maxstat")
    (synopsis "Maximally Selected Rank Statistics")
    (description
      "Maximally selected rank statistics with several p-value approximations.")
    (license gpl2+)))

(define-public r-survminer
  (package
    (name "r-survminer")
    (version "0.4.7")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "survminer" version))
        (sha256
          (base32
            "1pdj3gs4aii8gn8wf4smbwmjymbzwkjwr3kxf90dxyy6i66mqq3v"))))
    (properties `((upstream-name . "survminer")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-broom" ,r-broom)
        ("r-dplyr" ,r-dplyr)
        ("r-ggplot2" ,r-ggplot2)
        ("r-ggpubr" ,r-ggpubr)
        ("r-gridextra" ,r-gridextra)
        ("r-magrittr" ,r-magrittr)
        ("r-maxstat" ,r-maxstat)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-scales" ,r-scales)
        ("r-survival" ,r-survival)
        ("r-survmisc" ,r-survmisc)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "http://www.sthda.com/english/rpkgs/survminer/")
    (synopsis
      "Drawing Survival Curves using 'ggplot2'")
    (description
      "Contains the function 'ggsurvplot()' for drawing easily beautiful and 'ready-to-publish' survival curves with the 'number at risk' table and 'censoring count plot'.  Other functions are also available to plot adjusted curves for `Cox` model and to visually examine 'Cox' model assumptions.")
    (license gpl2)))

(define-public r-hardhat
  (package
    (name "r-hardhat")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "hardhat" version))
        (sha256
          (base32
            "10x8fw0skaqci03v2qqpbradbra9arm3s5pskcwm4wricd2imr40"))))
    (properties `((upstream-name . "hardhat")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-glue" ,r-glue)
        ("r-rlang" ,r-rlang)
        ("r-tibble" ,r-tibble)
        ("r-vctrs" ,r-vctrs)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/tidymodels/hardhat")
    (synopsis "Construct Modeling Packages")
    (description
      "Building modeling packages is hard.  A large amount of effort generally goes into providing an implementation for a new method that is efficient, fast, and correct, but often less emphasis is put on the user interface.  A good interface requires specialized knowledge about S3 methods and formulas, which the average package developer might not have.  The goal of 'hardhat' is to reduce the burden around building new modeling packages by providing functionality for preprocessing, predicting, and validating input.")
    (license expat)))

(define-public r-workflows
  (package
    (name "r-workflows")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "workflows" version))
        (sha256
          (base32
            "14lzbszz7ybfzqa5zw1hfh81b8rbwwyza6x8nhpnknl6x4adqfql"))))
    (properties `((upstream-name . "workflows")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-cli" ,r-cli)
        ("r-ellipsis" ,r-ellipsis)
        ("r-generics" ,r-generics)
        ("r-glue" ,r-glue)
        ("r-hardhat" ,r-hardhat)
        ("r-parsnip" ,r-parsnip)
        ("r-rlang" ,r-rlang)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/tidymodels/workflows")
    (synopsis "Modeling Workflows")
    (description
      "Managing both a 'parsnip' model and a preprocessor, such as a model formula or recipe from 'recipes', can often be challenging.  The goal of 'workflows' is to streamline this process by bundling the model alongside the preprocessor, all within the same object.")
    (license expat)))

(define-public r-gpfit
  (package
    (name "r-gpfit")
    (version "1.0-8")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "GPfit" version))
        (sha256
          (base32
            "05mpiyi2vxv0wqp422n1mnxa8msc4daq40cwpnpngbcwqhlgqkby"))))
    (properties `((upstream-name . "GPfit")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-lattice" ,r-lattice) ("r-lhs" ,r-lhs)))
    (home-page
      "https://cran.r-project.org/web/packages/GPfit")
    (synopsis "Gaussian Processes Modeling")
    (description
      "This package provides a computationally stable approach of fitting a Gaussian Process (GP) model to a deterministic simulator.")
    (license gpl2)))

(define-public r-yardstick
  (package
    (name "r-yardstick")
    (version "0.0.6")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "yardstick" version))
        (sha256
          (base32
            "1qkvbvc0cnwl5mkk47swnd8by84zz0qpy1996fziapn35qxvx9qa"))))
    (properties `((upstream-name . "yardstick")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-generics" ,r-generics)
        ("r-proc" ,r-proc)
        ("r-rcpp" ,r-rcpp)
        ("r-rlang" ,r-rlang)
        ("r-tidyselect" ,r-tidyselect)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/tidymodels/yardstick")
    (synopsis
      "Tidy Characterizations of Model Performance")
    (description
      "Tidy tools for quantifying how well model fits to a data set such as confusion matrices, class probability curve summaries, and regression metrics (e.g., RMSE).")
    (license gpl2)))

(define-public r-tune
  (package
    (name "r-tune")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "tune" version))
        (sha256
          (base32
            "0xiidzkl0hbd0f7jh1v2kkg26wdgy33w74c9bmpjgy317ckhsz8h"))))
    (properties `((upstream-name . "tune")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-cli" ,r-cli)
        ("r-crayon" ,r-crayon)
        ("r-dials" ,r-dials)
        ("r-dplyr" ,r-dplyr)
        ("r-foreach" ,r-foreach)
        ("r-ggplot2" ,r-ggplot2)
        ("r-glue" ,r-glue)
        ("r-gpfit" ,r-gpfit)
        ("r-hardhat" ,r-hardhat)
        ("r-lifecycle" ,r-lifecycle)
        ("r-parsnip" ,r-parsnip)
        ("r-purrr" ,r-purrr)
        ("r-recipes" ,r-recipes)
        ("r-rlang" ,r-rlang)
        ("r-rsample" ,r-rsample)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)
        ("r-workflows" ,r-workflows)
        ("r-yardstick" ,r-yardstick)))
    (home-page "https://github.com/tidymodels/tune")
    (synopsis "Tidy Tuning Tools")
    (description
      "The ability to tune models is important. 'tune' contains functions and classes to be used in conjunction with other 'tidymodels' packages for finding reasonable values of hyper-parameters in models, pre-processing methods, and post-processing steps.")
    (license expat)))

(define-public r-tidyposterior
  (package
    (name "r-tidyposterior")
    (version "0.0.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "tidyposterior" version))
        (sha256
          (base32
            "0wsv800w056ziqbnwal7ncmdy4li8cn5yrdx07w35b7j8kl4mwhg"))))
    (properties `((upstream-name . "tidyposterior")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-generics" ,r-generics)
        ("r-ggplot2" ,r-ggplot2)
        ("r-lifecycle" ,r-lifecycle)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-rsample" ,r-rsample)
        ("r-rstanarm" ,r-rstanarm)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)
        ("r-vctrs" ,r-vctrs)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://tidyposterior.tidymodels.org")
    (synopsis
      "Bayesian Analysis to Compare Models using Resampling Statistics")
    (description
      "Bayesian analysis used here to answer the question: \"when looking at resampling results, are the differences between models 'real'?\" To answer this, a model can be created were the performance statistic is the resampling statistics (e.g.  accuracy or RMSE).  These values are explained by the model types.  In doing this, we can get parameter estimates for each model's affect on performance and make statistical (and practical) comparisons between models.  The methods included here are similar to Benavoli et al (2017) <http://jmlr.org/papers/v18/16-305.html>.")
    (license gpl2)))

(define-public r-tidypredict
  (package
    (name "r-tidypredict")
    (version "0.4.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "tidypredict" version))
        (sha256
          (base32
            "1i6zl6wjz6wbpkmkc9z9ikp8zgck3qh38lar0r6q2jzl8fxpimg4"))))
    (properties `((upstream-name . "tidypredict")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-generics" ,r-generics)
        ("r-knitr" ,r-knitr)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-tibble" ,r-tibble)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://tidymodels.github.io/tidypredict")
    (synopsis "Run Predictions Inside the Database")
    (description
      "It parses a fitted 'R' model object, and returns a formula in 'Tidy Eval' code that calculates the predictions.  It works with several databases back-ends because it leverages 'dplyr' and 'dbplyr' for the final 'SQL' translation of the algorithm.  It currently supports lm(), glm(), randomForest(), ranger(), earth(), xgb.Booster.complete(), cubist(), and ctree() models.")
    (license gpl3)))

(define-public r-janeaustenr
  (package
    (name "r-janeaustenr")
    (version "0.1.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "janeaustenr" version))
        (sha256
          (base32
            "1wyn4qc28a3sval8shmyi2d7s4nl3jh96s8pzq871brxcmrncbwr"))))
    (properties `((upstream-name . "janeaustenr")))
    (build-system r-build-system)
    (home-page
      "https://github.com/juliasilge/janeaustenr")
    (synopsis "Jane Austen's Complete Novels")
    (description
      "Full texts for Jane Austen's 6 completed novels, ready for text analysis.  These novels are \"Sense and Sensibility\", \"Pride and Prejudice\", \"Mansfield Park\", \"Emma\", \"Northanger Abbey\", and \"Persuasion\".")
    (license expat)))

(define-public r-tokenizers
  (package
    (name "r-tokenizers")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "tokenizers" version))
        (sha256
          (base32
            "006xf1vdrmp9skhpss9ldhmk4cwqk512cjp1pxm2gxfybpf7qq98"))))
    (properties `((upstream-name . "tokenizers")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-rcpp" ,r-rcpp)
        ("r-snowballc" ,r-snowballc)
        ("r-stringi" ,r-stringi)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://lincolnmullen.com/software/tokenizers/")
    (synopsis
      "Fast, Consistent Tokenization of Natural Language Text")
    (description
      "Convert natural language text into tokens.  Includes tokenizers for shingled n-grams, skip n-grams, words, word stems, sentences, paragraphs, characters, shingled characters, lines, tweets, Penn Treebank, regular expressions, as well as functions for counting characters, words, and sentences, and a function for splitting longer texts into separate documents, each with the same number of words.  The tokenizers have a consistent interface, and the package is built on the 'stringi' and 'Rcpp' packages for  fast yet correct tokenization in 'UTF-8'.")
    (license expat)))

(define-public r-hunspell
  (package
    (name "r-hunspell")
    (version "3.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "hunspell" version))
        (sha256
          (base32
            "0mwqw5p0ph083plm2hr2hqr50bjg2dw862dpsfm4l2fgyy3rryq1"))))
    (properties `((upstream-name . "hunspell")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-digest" ,r-digest) ("r-rcpp" ,r-rcpp)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/ropensci/hunspell#readmehttps://hunspell.github.io")
    (synopsis
      "High-Performance Stemmer, Tokenizer, and Spell Checker")
    (description
      "Low level spell checker and morphological analyzer based on the famous 'hunspell' library <https://hunspell.github.io>.  The package can analyze or check individual words as well as parse text, latex, html or xml documents.  For a more user-friendly interface use the 'spelling' package which builds on this package to automate checking of files, documentation and vignettes in all common formats.")
    (license #f)))

(define-public r-tidytext
  (package
    (name "r-tidytext")
    (version "0.2.4")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "tidytext" version))
        (sha256
          (base32
            "0gck3f039qkpkwn92jlyfan76w0xydg17bh6nsg9qlba7c35kzs6"))))
    (properties `((upstream-name . "tidytext")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-generics" ,r-generics)
        ("r-hunspell" ,r-hunspell)
        ("r-janeaustenr" ,r-janeaustenr)
        ("r-matrix" ,r-matrix)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-stopwords" ,r-stopwords)
        ("r-stringr" ,r-stringr)
        ("r-tokenizers" ,r-tokenizers)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "http://github.com/juliasilge/tidytext")
    (synopsis
      "Text Mining using 'dplyr', 'ggplot2', and Other Tidy Tools")
    (description
      "Text mining for word processing and sentiment analysis using 'dplyr', 'ggplot2', and other tidy tools.")
    (license expat)))

(define-public r-rsample
  (package
    (name "r-rsample")
    (version "0.0.7")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "rsample" version))
        (sha256
          (base32
            "0s6hgq0rcv3ianyidq3n9z34y5ww51gaggqkwmwns9yyxmwfjcm8"))))
    (properties `((upstream-name . "rsample")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-furrr" ,r-furrr)
        ("r-generics" ,r-generics)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)
        ("r-tidyselect" ,r-tidyselect)
        ("r-vctrs" ,r-vctrs)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://rsample.tidymodels.org")
    (synopsis "General Resampling Infrastructure")
    (description
      "Classes and functions to create and summarize different types of resampling objects (e.g.  bootstrap, cross-validation).")
    (license gpl2)))

(define-public r-parsnip
  (package
    (name "r-parsnip")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "parsnip" version))
        (sha256
          (base32
            "1p33absjd2lnq5aikr42him4b724qzxr1pzvdnazg789f763i47l"))))
    (properties `((upstream-name . "parsnip")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-generics" ,r-generics)
        ("r-globals" ,r-globals)
        ("r-glue" ,r-glue)
        ("r-magrittr" ,r-magrittr)
        ("r-prettyunits" ,r-prettyunits)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)
        ("r-vctrs" ,r-vctrs)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://tidymodels.github.io/parsnip")
    (synopsis
      "A Common API to Modeling and Analysis Functions")
    (description
      "This package provides a common interface is provided to allow users to specify a model without having to remember the different argument names across different functions or computational engines (e.g. 'R', 'Spark', 'Stan', etc).")
    (license gpl2)))

(define-public r-infer
  (package
    (name "r-infer")
    (version "0.5.2")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "infer" version))
        (sha256
          (base32
            "0m00xhzrvmskwj4jwncakwxhzivn9pyiylq4r8s6ny4yiwqg303m"))))
    (properties `((upstream-name . "infer")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-ggplot2" ,r-ggplot2)
        ("r-glue" ,r-glue)
        ("r-magrittr" ,r-magrittr)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-tibble" ,r-tibble)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/tidymodels/infer")
    (synopsis "Tidy Statistical Inference")
    (description
      "The objective of this package is to perform inference using an expressive statistical grammar that coheres with the tidy design framework.")
    (license #f)))

(define-public r-dicedesign
  (package
    (name "r-dicedesign")
    (version "1.8-1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "DiceDesign" version))
        (sha256
          (base32
            "11s1m543kxd6gv4amh8z6pph1n67sj9sfwm6hjy83wfs65syf5vp"))))
    (properties `((upstream-name . "DiceDesign")))
    (build-system r-build-system)
    (home-page "http://dice.emse.fr/")
    (synopsis "Designs of Computer Experiments")
    (description
      "Space-Filling Designs and Uniformity Criteria.")
    (license gpl3)))

(define-public r-dials
  (package
    (name "r-dials")
    (version "0.0.7")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "dials" version))
        (sha256
          (base32
            "0fqxdlgwdwpmni2760yagrzqbniz72yl547fcmlx9kzazhzszgq0"))))
    (properties `((upstream-name . "dials")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dicedesign" ,r-dicedesign)
        ("r-dplyr" ,r-dplyr)
        ("r-glue" ,r-glue)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-scales" ,r-scales)
        ("r-tibble" ,r-tibble)
        ("r-vctrs" ,r-vctrs)
        ("r-withr" ,r-withr)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://tidymodels.github.io/dials")
    (synopsis
      "Tools for Creating Tuning Parameter Values")
    (description
      "Many models contain tuning parameters (i.e.  parameters that cannot be directly estimated from the data).  These tools can be used to define objects for creating, simulating, or validating values for such parameters.")
    (license gpl2)))

(define-public r-tidymodels
  (package
    (name "r-tidymodels")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "tidymodels" version))
        (sha256
          (base32
            "1bi5vh80f6f2ibhyaapgnl7q1mkkx8425vj6ci0ml5rb7l8jhjm8"))))
    (properties `((upstream-name . "tidymodels")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-broom" ,r-broom)
        ("r-cli" ,r-cli)
        ("r-crayon" ,r-crayon)
        ("r-dials" ,r-dials)
        ("r-dplyr" ,r-dplyr)
        ("r-ggplot2" ,r-ggplot2)
        ("r-infer" ,r-infer)
        ("r-magrittr" ,r-magrittr)
        ("r-parsnip" ,r-parsnip)
        ("r-pillar" ,r-pillar)
        ("r-purrr" ,r-purrr)
        ("r-recipes" ,r-recipes)
        ("r-rlang" ,r-rlang)
        ("r-rsample" ,r-rsample)
        ("r-rstudioapi" ,r-rstudioapi)
        ("r-tibble" ,r-tibble)
        ("r-tidyposterior" ,r-tidyposterior)
        ("r-tidypredict" ,r-tidypredict)
        ("r-tidytext" ,r-tidytext)
        ("r-tune" ,r-tune)
        ("r-workflows" ,r-workflows)
        ("r-yardstick" ,r-yardstick)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/tidymodels/tidymodels")
    (synopsis
      "Easily Install and Load the 'Tidymodels' Packages")
    (description
      "The tidy modeling \"verse\" is a collection of packages for modeling and statistical analysis that share the underlying design philosophy, grammar, and data structures of the tidyverse.")
    (license #f)))
