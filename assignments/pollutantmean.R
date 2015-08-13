pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  files <- list.files(directory, full.names=TRUE)

  data <- data.frame()
  for (i in id) {
    data <- rbind(data, read.csv(files[i]))
  }
  str(data)
  head(data)
  
  naValues <- is.na(data[, pollutant])
  mean(data[!naValues, pollutant])
}