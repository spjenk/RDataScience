library(httr)
library(base64enc)
apiKey <- ""
apiSecret <- ""
accessToken <- ""
accessTokenSecret <- ""

myapp <- oauth_app("SPJENKCourseraExample",key=apiKey,secret=apiSecret)
sig <- sign_oauth1.0(myapp,token=accessToken,token_secret = accessTokenSecret)

homeTL <- GET("https://api.twitter.com/1.1/search/tweets.json?q=%23datascience", sig)
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2