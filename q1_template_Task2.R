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
quotesPages = list(length = 10)
#iterates throw each page
for (i in 1:10){

  url2 = paste ("http://quotes.toscrape.com/page/","/", sep = toString(i))  
  
  url2 %>%
  read_html() -> webpage2
  
  webpage2 %>%
  html_nodes(".quote") -> colm2
  
  map_df(colm2,getQuoteInformation) -> newPage
  #saves each informations of on page into the df of all page Infomations
  quotesPages [[i]] = newPage
}
#print(quotesPages)






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


str_split(resultT4[[3]]," ", simplify = TRUE) -> resultT5


print(resultT5)
