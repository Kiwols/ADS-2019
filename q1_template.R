# Problem Set 1
# Question 1

# Name: Your Name
# Matrikelnummer: Your matriculation number
rowNumberOfCar  <- 20

mtcars
#call function 
createFormattedAdsWithComparisons(mtcars,2)



#a)
createAd <- function(vehicleData){
  # schreibt die Zeile rowNumberOfCar herraus
  vehicleData[rowNumberOfCar,] 
}


#b)
createFormattedAd <- function(vehicleData){
  # Your code
 carIdentityList <- createAd(vehicleData)
 
#print(row.names(vehicleData[rowNumberOfCar,]))
#print( paste("Horsepower:",  carIdentityList[rowNumberOfCar,4]))
#print(paste( "Cylinders:",  carIdentityList[rowNumberOfCar,2]))
#print(paste("Fuel Efficiency:",  carIdentityList[rowNumberOfCar,1],"mpg"))
#print(paste("1/4 mile time:",  carIdentityList[rowNumberOfCar,7], "seconds"))
 
# kreiert eine neue Data Frame mit den colm Category,Values,Unity und füllt die rows mit den einzelnen Elementen aus
Category = c(row.names(carIdentityList[1,]),"Horsepower:", "Cylinders:", "Fuel Efficiency:", "1/4 mile time:")
Values   = c("",carIdentityList[1,4],carIdentityList[1,2], carIdentityList[1,1],carIdentityList[1,7] )
Unity    = c("","","","mpg","seconds")

df = data.frame(Category,Values,Unity)

}


#c)
createFormattedAdWithComparison <- function(vehicleData){
  # Your code
  
 
#ordert die Einzelnen colms der gemamten Daten Matrix, sodass man weiß  welchem Rand der Wert des "eigene" Auto hat.
    orderedDF <- order(vehicleData[,4])
    orderedDF1 <- order(vehicleData[,2])
    orderedDF2 <- order(vehicleData[,1])
    orderedDF3 <- order(vehicleData[,7])
  
  carIdentityList <- createAd(vehicleData)
  
  
 # print(row.names(vehicleData[rowNumberOfCar,]))
 # print( paste("Horsepower:",  carIdentityList[rowNumberOfCar,4],"Top", (orderedDF[rowNumberOfCar] / nrow(vehicleData) * 100), "%"))
 # print(paste( "Cylinders:",  carIdentityList[rowNumberOfCar,2]))
 # print(paste("Fuel Efficiency:",  carIdentityList[rowNumberOfCar,1],"mpg"))
 # print(paste("1/4 mile time:",  carIdentityList[rowNumberOfCar,7], "seconds"))
  
  
 formattedCar<- createFormattedAd(vehicleData)

 

 #erstellt die neue row TopXPercentage und berechnet unter welchen Top % das Wert des "eigenen" Autos steht
 TopXPercentage = c("",orderedDF[rowNumberOfCar] / nrow(vehicleData) * 100,orderedDF1[rowNumberOfCar] / nrow(vehicleData) * 100,orderedDF2[rowNumberOfCar] / nrow(vehicleData) * 100,orderedDF3[rowNumberOfCar] / nrow(vehicleData) * 100)

 formattedCar = data.frame(formattedCar,TopXPercentage)

}

#d)
createFormattedAdsWithComparisons <- function(vehicleData, n){
  

  # Your code
  #Creates a vector with n rondom Nr. from 1: vehicleData.row
  carListNumber <- sample(1:nrow(vehicleData),n,replace = FALSE)
  
  
  formattedCarDataFrame <- data.frame()
  
 
  
  #generate a formatted list for each number in carListNumber
  for (nr in carListNumber) {
  
    rowNumberOfCar <<- nr
    #print (createFormattedAdWithComparison(vehicleData))
    if(nrow(formattedCarDataFrame) == 0){
      formattedCarDataFrame <- createFormattedAdWithComparison(vehicleData)
    }
    else{
      formattedCarDataFrame <- data.frame(formattedCarDataFrame, createFormattedAdWithComparison(vehicleData))
    }
     
    
  }
 
  print(formattedCarDataFrame)
}

#e)
# Your code

#load csv Data 
datMileage <- read.csv("C:/Users/Sebup/Documents/ADS19/Problem Sets/01/Data/carMileage.csv", header = TRUE)
dataPrices <- read.csv("C:/Users/Sebup/Documents/ADS19/Problem Sets/01/Data/carPrices.csv", header = TRUE)

#combinde two data frames by colomn
mtcarsComplete <- cbind(datMileage,dataPrices, mtcars)

#prints the complete car data frame
print(mtcarsComplete)
