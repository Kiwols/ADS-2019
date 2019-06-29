# Problem Set 1
# Question 2

# Name: Your Name
# Matrikelnummer: Your matriculation number

/library(RCurl)
library(RJSONIO)
library(dplyr)
library(purrr)
URL = "https://www.googleapis.com/books/v1/volumes?q=george+r+r+martin&maxResults=40"
response_parsed <- fromJSON(getURL(URL,ssl.verifyhost = 0L, ssl.verifypeer = 0L))

data.class(response_parsed)


print(response_parsed$items)

#Aufgabe b      
#print(map_df(response_parsed$items,getItems))

#Aufgabe c 
#print(getBookList(25))

#Aufgabe d
print(getBookSalesInfo("KtxRDwAAQBAJ"))

#a)
# Your code


#b)

#kreiert ein data frame mit den Spalten Title,Autor,Publishing_Date,Rating aus der Liste items
getItems <- function(items){
  data.frame( Title = c( ifelse(is.null(items$volumeInfo$title),"-",substring(items$volumeInfo$title,1,20))),
              Autor = c( ifelse(is.null(items$volumeInfo$authors),"-",items$volumeInfo$authors)),
              Publishing_Date = c( ifelse(is.null(items$volumeInfo$publishedDate),"-",items$volumeInfo$publishedDate)),
              Rating = c( ifelse(is.null(items$volumeInfo$maturityRating),"-",items$volumeInfo$maturityRating)))
  
}



#c) 
getBookList = function(numberOfItems) {
  
# dplyr pipe with the functions  slice()//selektiere von x:y, arrange()//sortiere
map_df(response_parsed$items,getItems) %>% slice(1:numberOfItems) %>%  arrange(Publishing_Date,Title)
  
}

#d)
getBookSalesInfo = function(response) {
  
  map_df(response_parsed$items,getItemsForBaying) %>% filter(id == response) 
  
}

getItemsForBaying <- function(items){
  data.frame( id = c( ifelse(is.null(items$id),"-",items$id)),
              Available  = c( ifelse(is.null(items$volumeInfo$infoLink),"-",items$volumeInfo$infoLink)),
              Price  = c( ifelse(is.null(as.factor(items$saleInfo$listPrice$amount)),"-",as.factor(items$saleInfo$listPrice$amount))),
              Link = c( ifelse(is.null(items$saleInfo$buyLink),"-",items$saleInfo$buyLink)))
  
}