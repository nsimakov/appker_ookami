# Title     : Convert Raw Data into R data tables

library(data.table)
library(XML)
library(DBI)
library(dplyr)
# read xml from file
read_results_xml <- function(results_dir_path, exe_type="std", problem_size="akstd", nruns=10L, results_file_prefix="result_") {
    results <- NULL
    for(i in seq(1,nruns)) {
        resultpath <- file.path(results_dir_path, paste0(results_file_prefix, i, ".xml"))

        xml_doc <- xmlParse(file = resultpath)
        params <- xmlToDataFrame(nodes = getNodeSet(xml_doc, "//body/performance/benchmark/parameters/parameter"))
        params$metric_type <- "parameter"
        stats <- xmlToDataFrame(nodes = getNodeSet(xml_doc, "//body/performance/benchmark/statistics/statistic"))
        stats$metric_type <- "statistic"

        result <- rbind(params,stats)
        result$run_id <- i
        results <- rbind(results,result)
    }
    results$exe_type <- exe_type
    results$problem_size <- problem_size
    results$metric <- results$ID
    results[c("exe_type", "problem_size", "run_id", "metric_type", "metric", "value", "units")]
}

# read xml from db
read_results_xml_from_db <- function(con, resource_name, app_name, nodes, exe_type="akstd", nruns=10L) {

    problem_size <- "akstd"

    rs <- dbSendQuery(con, paste0("SELECT instance_id,collected,resource,reporter,reporternickname,body
    FROM akrr_xdmod_instanceinfo
    WHERE resource='", resource_name,"' AND status=1 AND reporternickname='",app_name,".", nodes,"'
    ORDER BY instance_id DESC
    LIMIT ", nruns,";"))
    raw <- dbFetch(rs)
    dbClearResult(rs)

    results <- NULL
    for(i in seq(1,nrow(raw))) {
        xml_doc <- xmlParse(raw$body[[i]])
        params <- xmlToDataFrame(nodes = getNodeSet(xml_doc, "//parameters/parameter"))
        params$metric_type <- "parameter"
        stats <- xmlToDataFrame(nodes = getNodeSet(xml_doc, "//statistics/statistic"))
        stats$metric_type <- "statistic"

        result <- rbind(params,stats)
        result$run_id <- i
        results <- rbind(results,result)
    }
    results$exe_type <- exe_type
    results$problem_size <- problem_size
    results$metric <- results$ID
    results[c("exe_type", "problem_size", "run_id", "metric_type", "metric", "value", "units")]
}

# hpcc
# Koinu
hpcc_results <- NULL
resource <- "Koinu (CPU ARM ThunderX2 32(128) cores x2)"

exe_type <- "openmpi/sysblas/intfft"
results <- read_results_xml(
    file.path("appsout", "hpcc", "sysblas", "std_64x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 64L

hpcc_results <- rbind(hpcc_results,results)
results <- read_results_xml(
    file.path("appsout", "hpcc", "sysblas", "std_128x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 128L
hpcc_results <- rbind(hpcc_results,results)

results <- read_results_xml(
    file.path("appsout", "hpcc", "sysblas", "std_256x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 256L
hpcc_results <- rbind(hpcc_results,results)

exe_type <- "openmpi/armpl/intfft"
results <- read_results_xml(
    file.path("appsout", "hpcc", "amdplblas", "std_64x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 64L

hpcc_results <- rbind(hpcc_results,results)
results <- read_results_xml(
    file.path("appsout", "hpcc", "amdplblas", "std_128x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 128L
hpcc_results <- rbind(hpcc_results,results)

results <- read_results_xml(
    file.path("appsout", "hpcc", "amdplblas", "std_256x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 256L
hpcc_results <- rbind(hpcc_results,results)

exe_type <- "openmpi/openblas/intfft"
results <- read_results_xml(
    file.path("appsout", "hpcc", "openblas", "std_64x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 64L

hpcc_results <- rbind(hpcc_results,results)
results <- read_results_xml(
    file.path("appsout", "hpcc", "openblas", "std_128x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 128L
hpcc_results <- rbind(hpcc_results,results)

results <- read_results_xml(
    file.path("appsout", "hpcc", "openblas", "std_256x1"),
    exe_type=exe_type)
results$resource <- resource
results$nodes <- 1L
results$cpus <- 256L
hpcc_results <- rbind(hpcc_results,results)

# XSEDE systems
con_xsede <- dbConnect(RMySQL::MySQL(), group = "appkernel", dbname="mod_akrr")

# Stampede2 SKX
app_name <- "hpcc"
results <- read_results_xml_from_db(con_xsede, "stampede2-skx", app_name, 1L, exe_type="impi/mkl",nruns=10L)
results$resource <- "Stampede2 SKX (CPU Intel Xeon Platinum 8160 24(48) cores x2)"
results$nodes <- 1L
results$cpus <- 48L
hpcc_results <- rbind(hpcc_results,results)

# Stampede2 KNL

results <- read_results_xml_from_db(con_xsede, "stampede2-knl", app_name, 1L, exe_type="impi/mkl", nruns=10L)
results$resource <- "Stampede2 KNL (CPU Intel Xeon Phi 7250 68(272) cores x2)"
results$nodes <- 1L
results$cpus <- 68L
hpcc_results <- rbind(hpcc_results,results)

# Comet
results <- read_results_xml_from_db(con_xsede, "comet", app_name, 1L, exe_type="mvapich2/mkl", nruns=10L)
results$resource <- "Comet (CPU Intel Xeon E5-2680v3 12 cores x2, Haswell)"
results$nodes <- 1L
results$cpus <- 24L
hpcc_results <- rbind(hpcc_results,results)

# Bridges
results <- read_results_xml_from_db(con_xsede, "bridges", app_name, 1L, exe_type="impi/mkl", nruns=10L)
results$resource <- "Bridges (Intel E5-2695 v3 14 cores x2, Haswell)"
results$nodes <- 1L
results$cpus <- 28L
hpcc_results <- rbind(hpcc_results,results)

dbDisconnect(con_xsede)


hpcc_results <- hpcc_results %>% filter(!metric %in% c("App:ExeBinSignature", "RunEnv:Nodes", "app", "resource"))
# "App:Version" can be removed too eventially

write.csv(hpcc_results, file="hpcc.csv")
