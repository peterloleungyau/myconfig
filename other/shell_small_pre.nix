# refer to https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2018-09-12";
  # Commit hash for nix git as of 2020-04-21, before switching R from 3.6.3 to 4.0.0
  url = "https://github.com/NixOS/nixpkgs/archive/ff2f2644f8ea1b364dde5dfee2bc76027afccaf9.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0y2nfzwxpsjcwvhl1sih1cxknm88nb824ldk8qgv1cv7wp4hn04m";
}) {};
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
