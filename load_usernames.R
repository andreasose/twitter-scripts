library(twitteR)
library(rjson)
library(httr)


twitter_list <- "journalister"
twitter_name <- "andreasose"
api.url <- paste0("https://api.twitter.com/1.1/lists/members.json?slug=",
                  twitter_list, "&owner_screen_name=", twitter_name, "&count=5000")
response <- POST(api.url, config(token=twitteR:::get_oauth_sig()))

response.list <- fromJSON(content(response, as = "text", encoding = "UTF-8"))
users.names <- sapply(response.list$users, function(i) i$name)
users.screennames <- sapply(response.list$users, function(i) i$screen_name)
