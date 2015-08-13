complete <- function(directory, id = 1:332) {

  files <- list.files(directory, full.names=TRUE)
  
  v <- c()
  x <- 1
  for (i in id) {
    temp <- read.csv(files[i])
    cc <- complete.cases(temp[, 2:3])
    v[x] <- nrow(temp[cc, ])
    x <- x + 1
  }
  
  data.frame(id, nobs = v)
}