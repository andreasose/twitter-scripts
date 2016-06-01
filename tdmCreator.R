tdmCreator <- function(dataframe, term.freq = 10, stemDoc = F ){
    library(tm)

corpus <- Corpus(VectorSource(dataframe$text))
corpus <- tm_map(corpus, removeWords, stopwords())
if (isTRUE(stemDoc)) {
    corpus <- tm_map(corpus, stemDocument)
}
tdm <- TermDocumentMatrix(corpus, control = list(wordLengths = c(1, Inf)))
term.freq <- rowSums(as.matrix(tdm))
term.freq <- subset(term.freq, term.freq >= term.freq)
df <- data.frame(term = names(term.freq), freq = term.freq)
return(df)
}