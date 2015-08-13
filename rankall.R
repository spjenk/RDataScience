rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that outcome and num are valid
  outcomes <- rbind(c("heart attack", 11), c("heart failure", 17), c("pneumonia", 23))
  if(!is.element(outcome, outcomes)) stop("Invalid Outcome")
  
  #get column to use
  outcomeCol <- 0
  for(i in 1:3) {
    if (outcome == outcomes[i,1]) {
      outcomeCol <- as.numeric(outcomes[i,2])
      return
    }
  }
  
  #Lets reduce the data we are working with to just the columns we are interested in
  cols <- c(2, 7, outcomeCol)
  data <- data[,cols]
  #and lets get rid of Not Available data
  data <- data[data[,3] != "Not Available",]
  
  #Sort and return
  colnames(data) <- c("hospital", "state", "mortality")
  l <- split(data,data$state)
  l <- lapply(l,function(x) {x[order(as.numeric(x$mortality),x$hospital),]})

  if (num == "best") {
    l <- lapply(l,function(x) {(x[1,])})
  } else if (num == "worst") {
    l <- lapply(l,function(x) {tail(x, n=1L)})
  } else if (is.numeric(num)) {
    l <- lapply(l,function(x) {x[num,]})
  } else {
    stop("Invalid num")
  }
  df <- do.call(rbind.data.frame, l)
  df[,1:2]
}

