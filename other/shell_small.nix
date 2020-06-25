# These packages could be installed globally with "nix-env -if mmds_hk.nix" in the command-line
with import <nixpkgs> {};
let 
  wanted-pkgs = with rPackages; [
        Boruta
        DT
        SHAPforxgboost
        #fastshap
        ggplot2
        glmnet
        glue
        iml
        jsonlite
        lubridate
        ranger
        rbenchmark
        rvest
        tidyverse
        xgboost
      ];
  R-with-needed-pkgs = rWrapper.override {
      packages = wanted-pkgs;
  };
  Rstudio-with-needed-pkgs = rstudioWrapper.override {
      packages = wanted-pkgs;
  };
in
mkShell rec {
  name = "ds-packages";
  buildInputs = 
    [
      R-with-needed-pkgs
      # Rstudio-with-needed-pkgs
    ];
}
