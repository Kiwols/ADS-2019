# Problem Set 1
# Question 2

# Name: Your Name
# Matrikelnummer: Your matriculation number

library(RCurl)
library(RJSONIO)
URL = "https://www.googleapis.com/books/v1/volumes?q=george+r+r+martin&maxResults=40"
response_parsed <- fromJSON(getURL(URL,ssl.verifyhost = 0L, ssl.verifypeer = 0L))

data.class(response_parsed)


print(response_parsed$items[[12]])
      



#a)
# Your code
getItems <- function(items){
 data.frame( Title = c( ifelse(is.null(items$volumeInfo$title),"-",items$volumeInfo$title))
             Autor = c( ifelse(is.null(items$volumeInfo$authors),"-",items$volumeInfo$authors))
             Publishing_Date = c( ifelse(is.null(items$volumeInfo$title),"-",items$volumeInfo$title))
             Rating = c( ifelse(is.null(items$volumeInfo$title),"-",items$volumeInfo$title)))
}


#b)
# Your code

#c) 
#getBookList = function(numberOfItems) {
  # Your code
#}

#d)
#getBookSalesInfo = function(response) {
  # Your code
#}