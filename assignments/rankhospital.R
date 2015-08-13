rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state, outcome and num are valid
  states <- unique(data[,7])
  if(!is.element(state, states)) stop("Invalid State")
  
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
  
  #Lets reduce the data we are working with to just the columns and the state we are interested in
  cols <- c(2, 7, outcomeCol)
  stateBools <- data[,7] == state
  data <- data[stateBools,cols]
  #and lets get rid of Not Available data
  data <- data[data[,3] != "Not Available",]
  
  #Sort and return
  orderdata <- data[order(as.numeric(data[,3]),data[,1]),]
  returnValue <- NULL
  if (num == "best") {
    returnValue <- as.character(head(orderdata[1], n = 1L))
  } else if (num == "worst") {
    returnValue <- as.character(tail(orderdata[1], n = 1L))
  } else if (is.numeric(num)) {
    returnValue <- as.character(orderdata[num,1])
  } else {
    stop("Invalid num")
  }
  returnValue
}

