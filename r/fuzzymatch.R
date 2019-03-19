# Fuzzy Matching: applying different string matching methods
# Daniel Tihanyi
# code borrowed/edited from stackexchange and other sources

# methods fullname ------------------------------------------------------------ eval

# osa     Optimal string aligment (restricted Damerau-Levenshtein distance)   - probably the best for typos
# lv      Levenshtein distance (as in Rs native adist)                        - classic approach 
# dl      Full Damerau-Levenshtein distance                                   - classic approach, with mods
# hamming Hamming distance (a and b must have same nr of characters)          - explicitly for typos in strict length fields
# lcs     Longest common substring distance                                   - slower
# qgram   q-gram distance                                                     - good but resource intensive
# cosine  cosine distance between q-gram profiles                             - also good but still resource intensive
# jaccard Jaccard distance between q-gram profiles                            - good but resource intensive
# jw      Jaro or Jaro-Winker distance                                        - probably the best for short strings like individual names

#install.packages('stringdist')
#install.packages('readr')
#install.packages('reshape2')
#install.packages('fuzzyjoin')
#install.packages('dplyr')
library(stringdist)
library(readr)
library(reshape2)
library(fuzzyjoin)
library(dplyr)

# Method: using the native R dist heuristics
data1<-read_delim("data1.csv", "|", escape_double = FALSE, trim_ws = TRUE)
data2<-read_delim("data2.csv", "|", escape_double = FALSE, trim_ws = TRUE)

# subset data by known exclusive categories
#data1_ca <- select(filter(data1, state == "California"))
#data2_ca <- select(filter(data2, state == "California"))

# To make sure we are dealing with charts
data1$strvar<-as.character(data1$cleanname)
data2$strvar<-as.character(data2$cleanname)

#define distance methods
distance.methods<-c('osa','lv','dl','hamming','lcs','qgram','cosine','jaccard','jw')

#method 1 - basic stringdist_join using native fuzzyjoin
  stringdist_join(data1, data2, 
                  by = "strvar",
                  mode = "left",
                  ignore_case = FALSE, 
                  method = "osa", 
                  max_dist = 99, 
                  distance_col = "dist"
  ) %>%
    top_n(1, -dist)

# method 2 - using function with iterative match
  fuzzymatch<-function(data1,data2,string1,string2,meth,id1,id2){
    matchfile <-NULL #iterate appends, initialize vars
    x<-nrow(dat1) #count number of rows in input, for max number of runs
    if(missing(id1)){id1=NULL} # check for null values - allow for simple list match
    if(missing(id2)){id2=NULL}
    dat1[,string1]<-as.character(tolower(dat1[,string1])) # force to lower characters, if values are factors
    dat2[,string2]<-as.character(tolower(dat2[,string2]))
    #Loop through first dataset iteratively, allowing large datasets to be matched - will run as long as data fits in memory
    for(i in 1:x) {
      d<-merge(dat1[i,c(string1,id1), drop=FALSE],dat2[,c(string2,id2), drop=FALSE]) # drop=FALSE to preserve 1var dataframe
      d$dist <- stringdist(d[,string1],d[,string2], method=meth) # calculate stringdist with method
      d<- d[order(d[,string1], d$dist, decreasing = FALSE),] # deduplicates names on the smallest distance
      d<- d[!duplicated(d[,string1]),]
      matchfile <- rbind(matchfile,d) # append demos on matched file
      print(paste(round(i/x*100,2),"% complete",sep='')) # give us a status
    }
    return(matchfile)
  }  
  
  merged<-fuzzymatch(data1,data2,"strvar","strvar",meth="osa")
  
#check results
View(merged)
