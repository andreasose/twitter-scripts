
tweetsFromList <- function (listOwner, listName, sleepTime = 7, n_tweets = 100, includeRts = F) {

    api_url <- paste0("https://api.twitter.com/1.1/lists/members.json?slug=",
                  listName, "&owner_screen_name=", listOwner, "&count=5000")
    response <- GET(api_url, config(token=twitteR:::get_oauth_sig()))

    response_data <- fromJSON(content(response, as = "text", encoding = "UTF-8"))
    ## If you want a list of their profile names, then remove the hastag underneath and
    ## add it to the return statement at the bottom.
    ## Useful if you need to verify identity of people.
    
    #user_title <- sapply(response_text$users, function(i) i$name)
    user_names <- sapply(response_data$users, function(i) i$screen_name)
    tweets <- list()
    
    ## Loops over list of users, use rbind() to add them to list.
    ## Sleeptime ticks inbetween to avoid rate limit.
        for (user in user_names) {
        ## Download user's timeline from Twitter  
        raw_data <- userTimeline(user, n = n_tweets,
                                 includeRts = includeRts,
                                 retryOnRateLimit = 2000)
        tweets <- rbind(tweets, raw_data)
        print('Sleeping to avoid rate limit')
        Sys.sleep(sleepTime); 
        }

rm(raw_data)
tweets <- twListToDF(tweets)
return(tweets)
}
