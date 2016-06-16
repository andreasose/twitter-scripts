textScrubber <- function(dataframe) {
    
    dataframe$text <-  gsub("—", " ", dataframe$text)
    dataframe$text <-  gsub("&amp;", "", dataframe$text)
    dataframe$text <-  gsub("[[:punct:]]", "", dataframe$text)
    dataframe$text <-  gsub("[[:digit:]]", "", dataframe$text)
    dataframe$text <-  gsub("http\\w+", "", dataframe$text)
    dataframe$text <-  gsub("\n", " ", dataframe$text)
    dataframe$text <-  gsub("[ \t]{2,}", "", dataframe$text)
    dataframe$text <-  gsub("^\\s+|\\s+$", "", dataframe$text)
    dataframe$text <-  tolower(dataframe$text)
    
    return(dataframe)
}
