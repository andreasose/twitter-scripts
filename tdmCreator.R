tdmCreator <- function(dataframe, stemDoc = T, rmStopwords = T){
    
    corpus <- Corpus(VectorSource(dataframe$text))
    if (isTRUE(rmStopwords)) {
        corpus <- tm_map(corpus, removeWords, stopwords())
    }
    if (isTRUE(stemDoc)) {
        corpus <- tm_map(corpus, stemDocument)
    }
    tdm <- TermDocumentMatrix(corpus, control = list(wordLengths = c(1, Inf)))
    tdm <- removeSparseTerms(tdm, sparse= 0.97)
    termFreq <- rowSums(as.matrix(tdm))
    termFreq <- sort(termFreq, decreasing = T)
    df <- data.frame(term = names(termFreq), freq = termFreq)
    return(df)
}