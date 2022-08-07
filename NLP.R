#naturallanguage processing 
install.packages("tm")
install.packages("twitteR")
install.packages("wordcloud")
install.packages("RColorbrewer")
install.packages("e1071")
install.packages('class')
install.packages("openssl")
install.packages("httpuv")
library(openssl)
library(httpuv)
library(tm) # text manipulting 
library(twitteR)
library(wordcloud)
library(RColorBrewer)
library (e1071)
library(class)

#create twitter account 

#connect to twitter 

key=c('ZBeiRtCPMmVXwfLHcGO7epO7C')
skey=c('2OU79H4Cp9XYqK0AG3BxOriLG8Mce1aZzyQexIQXfaHMKTCcmZ')
token=c('1083653091147296769-BQ0CHqiqABTxN0htruZJ7qCpvWpJ3F')
sectoken= c('0tSzz2toA6If7zLgaoLpPYc6L3eCpZZreNdgdtSvYnPcj')

setup
setup_twitter_oauth(consumer_key ='ZBeiRtCPMmVXwfLHcGO7epO7C',
                    consumer_secret = '2OU79H4Cp9XYqK0AG3BxOriLG8Mce1aZzyQexIQXfaHMKTCcmZ',
                    access_token = '1083653091147296769-BQ0CHqiqABTxN0htruZJ7qCpvWpJ3F',
                    access_secret ='0tSzz2toA6If7zLgaoLpPYc6L3eCpZZreNdgdtSvYnPcj' )

soccer.tweets<- searchTwitter('soccer', n=1000, lang='en')

soccer.text<- sapply(soccer.tweets, function(x) x$getText())

#cleantext data 

soccer.text<- iconv(soccer.text, 'UTF-8','ASCII')

soccer.corpus <- corpus(VectorSource(soccer.text))

term.doc.matrix<-TermDocumentMatrix(soccer.corpus, control=list(removePunctuation=TRUE,
                                                                stopwords=c('soccer',stopwords('english')), 
                                                                removeNumbers=TRUE, tolower=TRUE ))

### CONVERT OBJECT TO MATRIX
term.doc.matrix<-as.matrix(term.doc.matrix)

# GET WROD COUNTS
word.freq <- sort(rowSums(term.doc.matrix), decreasing = T)
dm<- data.frame(word=names(word.freq), freq=word.freq)

#create the wordcloud

wordcloud(dm$word,dm$freq, random.order = FALSE, colors = brewer.pal(8,"Dark2"))



