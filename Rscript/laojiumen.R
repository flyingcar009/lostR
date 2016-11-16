#老九门主角分析

library(rJava) 
library(Rwordseg) 
library("RColorBrewer") 
library("wordcloud")
####insertWords("二月红")
###deleteWords("二月红")
myfile<-read.csv(file.choose(),header=FALSE)
myfile.res <- myfile[myfile!="../files/老九门.txt"] 
myfile.words <- unlist(lapply(X = myfile.res,FUN = segmentCN))
myfile.words <- gsub(pattern="http:[a-zA-Z\\/\\.0-9]+","",myfile.words)
myfile.words <- gsub("\n","",myfile.words) 
myfile.words <- gsub("　","",myfile.words)
myfile.words<-subset(myfile.words,nchar(as.character(myfile.words))>1)
myfile.freq <- table(unlist(myfile.words)) 
myfile.freq <- rev(sort(myfile.freq)) 
myfile.freq <- data.frame(word=names(myfile.freq), freq=myfile.freq);   
myfile.freq2=subset(myfile.freq, myfile.freq$freq>=2) 
mycolors <- brewer.pal(8,"Dark2") 
windowsFonts(myFont=windowsFont("华文彩云")) 
wordcloud(myfile.freq$word,myfile.freq$freq,min.freq=3,random.order=FALSE,random.color=FALSE,colors=mycolors,family="myFont")

