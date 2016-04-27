library(plyr)
library(twitteR)
library(rjson)


twitter_list <- "name_of_list"
    twitter_name <- "your_twitter_name"
    api_url <- paste0("https://api.twitter.com/1.1/lists/members.json?slug=",
                      twitter_list, "&owner_screen_name=", twitter_name, "&count=5000")
response <- POST(api_url, config(token=twitteR:::get_oauth_sig()))

response_data <- fromJSON(content(response, as = "text", encoding = "UTF-8"))
## If you want a list of their profile names, then remove the hastag underneath.
## Useful if you need to verify identity of people.
#user_title <- sapply(response_text$users, function(i) i$name)
user_names <- sapply(response_data$users, function(i) i$screen_name)

sleepTime <- 6
tweets <- list()
## Loops over list of users, use rbind() to add them to list.
## 6sec ticks inbetween to avoid rate limit.
for (user in user_names)
{
    #Download user's timeline from Twitter  
    raw_data <- userTimeline(user, n = 500, includeRts = FALSE, retryOnRateLimit = 2000)
    tweets <- rbind(tweets, raw_data)
    print('Sleeping for 6 seconds...')
    Sys.sleep(sleepTime); 
}
rm(raw_data)
tweets <- twListToDF(tweets)
write.csv(tweets, file =paste0(twitter_list, ".csv"))
