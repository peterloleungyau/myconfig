
install.packages("BiocManager", repos="https://cloud.r-project.org")
# for FHtest
BiocManager::install("Icens", update = FALSE, ask = FALSE)

# other CRAN packages

install.packages(c("devtools", "tidyverse", "yaml",
			"Boruta", "DT", "FHtest", "RISmed", "ROCR","RPostgreSQL",
			"RSelenium", "Rcpp", "SHAPforxgboost", "bayesplot",
			"blob", "caret", "data.table", "doMC", "e1071", "fastshap",
			"flexsurv", "formatR", "foreach", "ggplot2", "ggthemes",
			"glmnet", "glue", "gmodels", "gridExtra",
			"httr", "iml", "jsonlite", "languageserver", "lubridate",
			"mgcv", "numDeriv", "profmem", "purrr", "randomForest",
			"randomForestSRC", "ranger", "rbenchmark", "rvest",
			"shiny", "sparklyr", "styler", "survminer", "tidymodels",
			"xgboost", "xml2", "rJava"),
		repos="https://cloud.r-project.org")

