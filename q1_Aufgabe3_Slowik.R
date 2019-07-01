# Problem Set 3
# Question 1

# Name: Your Name
# Matrikelnummer: Your matriculation number

library(RCurl)
library(RJSONIO)
library(dplyr)
library(purrr)
library(ggplot2)

#1a
#läd die csv datein und setzt alle lehren stellen als na 
read.csv2('https://www.bundeswahlleiter.de/dam/jcr/5441f564-1f29-4971-9ae2-b8860c1724d1/ew19_kerg2.csv',encoding="UTF-8", header = FALSE, na.strings = c("", "NA")) -> election_Data



election_Data[-c(1,2,3,4,5,6,7,8,9),]  -> election_Data

#nimmt die erste Zeile als Colnnames
colnames(election_Data) = as.character(unlist(election_Data[1,])) # the first row will be the header
#löscht die erste Zeile
election_Data = election_Data[-1, ] 



election_Data %>%
  filter(Gebietsart == "Land")-> election_Data
  
  #select("Gebietsname","Gruppenname","Prozent") 


election_Data[,13]


#1b

round_df <- function(x, digits) {
  # round all numeric variables
  # x: data frame 
  # digits: number of digits to round
  numeric_columns <- sapply(x, mode) == 'numeric'
  x[numeric_columns] <-  round(x[numeric_columns], digits)
  x
}


election_Data %>%
  filter(Gruppenname == "CDU" | Gruppenname == "SPD" | Gruppenname == "GRÜNE" | Gruppenname == "DIE LINKE" | Gruppenname == "FDP" | Gruppenname == "AfD" ) -> election_Data_bigPartisStates



# 
# g = ggplot(election_Data_bigPartisStates, aes(y = Anzahl, x = as.factor(Gebietsname), fill = Gruppenname))
# g = g + geom_bar(position = "fill")
# g = g + scale_fill_brewer(palette="Paired")
# g
# 


ggplot(election_Data_bigPartisStates,aes(y=Prozent,x=Gruppenname)) + geom_col()+
  facet_wrap(~ Gebietsname, nrow = 4)

#c
ggplot(election_Data_bigPartisStates,aes(y=Prozent,x=Gebietsname)) + geom_col()+
  facet_wrap(~ Gruppenname, nrow = 5)

#d
#aggregate(election_Data_bigPartisStates,list(election_Data_bigPartisStates$Gebietsname),FUN = max)->lalilu

election_Data_bigPartisStates %>%
  group_by(Gebietsname,Gruppenname)%>%
  filter(Prozent == max(Prozent)) ->lalilu
 