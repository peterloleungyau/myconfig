# to install MM packages from local, this is to be called from the parent directory
library(devtools)

Sys.setenv("TAR" = "internal")
for(f in dir("mm_pkgs", pattern = "*.gz")) {
  cat("== ", f, "\n")
  devtools::install_local(file.path("mm_pkgs", f))
}
