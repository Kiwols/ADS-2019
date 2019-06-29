# Problem Set 2
# Question 1

# Name: Your Name
# Matrikelnummer: Your matriculation number
library(rvest)
library(tidyverse)
library(RcppRoll)
library(purrr)
library(stringr)

#url of wegpage
url = "http://quotes.toscrape.com/"

#safe url in variable webpage
url %>%
read_html() -> webpage


#Get all authors of a page
getAuthors = function(page){
  
  page %>%
    
    html_nodes(".author") %>%
    html_text() -> author
  
}
#Get all Text of a page
getText = function(page){
  
  page %>%
    
    html_nodes(".text") %>%
    html_text() -> text
  
 # print(text)
  
}
#Get all tags of a page trim all withspace in the end an begining, squish(remove) all repeated whitespace
getTags = function(page){
  
  page %>%
    
    html_nodes(".tags") %>%
    html_text() %>%
    str_remove_all("Tags:") %>% 
    str_remove_all("\\n") %>%
    str_trim(side = "both") %>%
    str_squish() -> tags
    
   
  
 # print(tags)
  
}

#get autors, text and Tags of a page and safes it into a data frame
getQuoteInformation = function(page){
  
  getAuthors(page) -> authors
  
  getText(page) -> text
  
  getTags(page) -> tag
  
  
  data.frame(authors = authors, text = text, tag = tag) -> result
 # print(result)
}


#Aufgabe 1

#load all nodes .quite
webpage %>%
html_nodes(".quote") -> colm



#call function getQuoteInformation on all list elements from colm
map_df(colm,getQuoteInformation) -> resultT1
#print(resultT1)




#Aufgabe2
quotesOverAllPages = list(length = 10)
#iterates throw each page
for (i in 1:10){

  url2 = paste ("http://quotes.toscrape.com/page/","/", sep = toString(i))  
  
  url2 %>%
  read_html() -> webpage2
  
  webpage2 %>%
  html_nodes(".quote") -> colm2
  
  map_df(colm2,getQuoteInformation) -> newPage
  #saves each informations of on page into the df of all page Infomations
  quotesOverAllPages [[i]] = newPage
}

#print(quotesOverAllPages)






#Aufgabe3

getAuthorUrl = function(url){
#get the Url of the Author detal page 
  
  url %>%
  read_html() %>%
  html_nodes(".quote span a") %>%
  html_attr("href") %>% 
  unique()-> AuthorURLs
  
 
  print(AuthorURLs)
  
  #past the string "http://quotes.toscrape.com/" bevor each String in AuthorURLs
  paste0("http://quotes.toscrape.com/",AuthorURLs,sep="")
}


getAuthorUrl(url)->authorurls
print(authorurls)

#Aufgabe 4

getAuthorInformation = function (url){
 #get the information of an Author of his Autor detail page
  
  url %>%
    read_html() -> page
  
  page %>%
    html_nodes(".author-description") %>%
    html_text() -> authorDescription
  
  page %>%
    html_nodes(".author-title") %>%
    html_text() -> authorName
  
  page %>%
    html_nodes(".author-born-date") %>%
    html_text() -> bornDate
  
  data.frame(authorName = authorName, authorDescription = authorDescription, bornDate = bornDate) -> result
}

map_df(authorurls,getAuthorInformation) -> resultT4


#Aufgabe 5.1

#seperates the 3 colom by " " and put it into new colm
str_split(resultT4[[3]]," ", simplify = TRUE) -> birthSep

mutate()

#change the colnnames to Month, Day and Year
colnames(birthSep) <- c("Month","Day","Year")

#Delete the 3 colom
resultT4[[3]] <- NULL

#put both data frames together
data.frame(resultT4,birthSep) -> authorInformation_df


CountAthoursByBirthYear = function(dataFrame,from,until){
  
  #select colm Year, filter where Year > from and Year <until, count how many 
  dataFrame %>%
    select(Year) %>%
    filter(as.numeric(levels(Year))[Year] > from) %>%
    filter(as.numeric(levels(Year))[Year] < until) %>%
    count() -> amount
}

sprintf( "Es gibt %s Autoren die in den Jahren von 1800-1899 geboren sind.", CountAthoursByBirthYear(authorInformation_df,1800,1899))


#Aufgabe 5.2

#1

getAuthorWithMostQuotes = function(DataList){
  
  #group by authors, count, and sort descendent
    data.frame(DataList) %>%
    group_by(authors)  %>%
     count() %>%
      arrange(desc(n))-> result

}

  map_df(quotesOverAllPages,getAuthorWithMostQuotes)%>%
  arrange(desc(n))%>%
    head(1) -> mostQuotsAuthor 

sprintf( "Der Autor mit den meisten Quots ist %s", mostQuotsAuthor[1,1])



#2

averageQuotsOfAuthors = function (DataList){
  
  data.frame(DataList) %>%
    group_by(authors)  %>%
    count() %>%
    summarize(averige = mean(n)) %>% 
    select(averige) %>%
    colMeans() -> result
print(result)
}
#take the row mean 
map_df(quotesOverAllPages,averageQuotsOfAuthors)%>% 
       rowMeans() -> averigeOfQuotsOverAllPages

sprintf( "Der Durchschnitt an Quots pro Autor ist %s", averigeOfQuotsOverAllPages)



#3
findQuoteByTag = function (DataList){
  
  data.frame(DataList) %>%
    filter(grepl("life", tag)) -> result
    
}


# FRAGE:wie kann man in einer map funktion der anzuwendenden funktion mehrere Parameter übergeben? 
map_df(quotesOverAllPages,findQuoteByTag) -> QuotesWithSpecialTag


#Aufgabe 3