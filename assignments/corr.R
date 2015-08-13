corr <- function(directory, threshold = 0) {
  
  files <- list.files(directory, full.names=TRUE)
  
  df = complete(directory)
  
  v <- c()
  x <- 1
  for (i in 1:nrow(df)) {
    if (df[i, 2] > threshold) {
      temp <- read.csv(files[i])
      cc <- complete.cases(temp[, 2:3])
      v[x] <- cor(temp[cc, 2], temp[cc, 3])
      x <- x + 1
    }
  }
  v
}