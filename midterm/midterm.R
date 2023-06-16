USArrests

setwd('C:/midterm')

foo <- dimnames(USArrests)[[1]]
foo

bar <- dimnames(USArrests)[[2]]
bar

foobar <- matrix(c(foo,bar))
foobar <- data.frame(foobar)
foobar

install.packages("wordcloud")
library(wordcloud)

names(foobar) <- c("지역명", "Assualt")

wordcloud(word = foobar$지역명,
          freq = foobar$Assault)

write.csv(foobar,file="C:/midterm/foobar.csv")
