textScrubber <- function(dataframe) {
    dataframe$text <- gsub("[[:punct:]]", "", dataframe$text)
    dataframe$text <-  gsub("[[:digit:]]", "", dataframe$text)
    dataframe$text <-  gsub("http\\w+", "", dataframe$text)
    dataframe$text <-  gsub("[ \t]{2,}", "", dataframe$text)
    dataframe$text <-  gsub("^\\s+|\\s+$", "", dataframe$text)
    return(dataframe)
}
