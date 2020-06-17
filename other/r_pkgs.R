
# to use user library
dir.create(Sys.getenv("R_LIBS_USER"), recursive=T)
.libPaths(Sys.getenv("R_LIBS_USER"))

install.packages("BiocManager", repos="https://cran.rstudio.com/")
# for FHtest
BiocManager::install("Icens", update = FALSE, ask = FALSE)

# other CRAN packages

install.packages(c("devtools", "tidyverse", "yaml",
			"Boruta", "DT", "FHtest", "RISmed", "ROCR","RPostgreSQL",
			"RSelenium", "Rcpp", "bayesplot",
			"blob", "caret", "data.table", "doMC", "e1071", "fastshap",
			"flexsurv", "formatR", "foreach", "ggplot2", "ggthemes",
			"glmnet", "glue", "gmodels", "gridExtra", 
			"httr", "iml", "jsonlite", "languageserver", "lubridate",
			"mgcv", "numDeriv", "profmem", "purrr", "randomForest",
			"randomForestSRC", "ranger", "rbenchmark", "rvest",
			"shiny", "sparklyr", "styler", "survminer", 
			"xml2", "rJava"),
		repos="https://cloud.r-project.org")

devtools::install_github("XiangdongGu/hkdata")
#devtools::install_github("tidymodels/parsnip")
#devtools::install_github("tidymodels/dials")

