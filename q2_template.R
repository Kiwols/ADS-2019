# Problem Set 1
# Question 2

# Name: Your Name
# Matrikelnummer: Your matriculation number

library(RCurl)
library(RJSONIO)
library(dplyr)
URL = "https://www.googleapis.com/books/v1/volumes?q=george+r+r+martin&maxResults=40"
response_parsed <- fromJSON(getURL(URL,ssl.verifyhost = 0L, ssl.verifypeer = 0L))

data.class(response_parsed)


print(getItems(response_parsed$items[[15]]))
      
print(map_df(response_parsed$items,getItems))


#a)
# Your code


#b)
# Your code

getItems <- function(items){
  data.frame( Title = c( ifelse(is.null(items$volumeInfo$title),"-",substring(items$volumeInfo$title,1,20))),
              Autor = c( ifelse(is.null(items$volumeInfo$authors),"-",items$volumeInfo$authors)),
              Publishing_Date = c( ifelse(is.null(items$volumeInfo$publishedDate),"-",items$volumeInfo$publishedDate)),
              Rating = c( ifelse(is.null(items$volumeInfo$maturityRating),"-",items$volumeInfo$maturityRating)))
  
}


#c) 
getBookList = function(numberOfItems) {
  # Your code

  
}

#d)
#getBookSalesInfo = function(response) {
  # Your code
#}