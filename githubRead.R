library(httr)

myapp <- oauth_app("xx", "xx", secret = "xx")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

req <- GET("https://api.github.com/repos/spjenk/RDataScience", config(token = github_token))
stop_for_status(req)
content(req)