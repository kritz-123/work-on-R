#File   : Module 3
#Project: Introduction to Analytics
#Author : Kayal Chandrasekaran

#
#Clean canvas ----
#clears the variables
rm(list=ls())
#clears the plots
dev.off() 

#Load library ----
library(tidyverse)
library(data.table)
#To see the list of packages loaded
(.packages())

#Import student table ----
setwd("C:/Users/kriti/Downloads/Student")
student  <- read.csv("C:/Users/kriti/Downloads/Student.csv", header=TRUE)

#Create vectors and dataframes --

age <- c(35,56,90,23,41,56,67,10,5)
hasdiab <- c(TRUE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE,FALSE,TRUE)
type <- c("Type 1","NA","Type 2","NA","Type 1","Type 2","Type 2","NA","Type 1")
status <- c("Improved","NA","Poor","NA","Poor","Improved","Improved","NA","Good")

patients <- data.frame(age, hasdiab, type, status)
patients
#Add total column----
#RowSums
student$Total <-   rowSums(student[c("Math", "Science","Social.Studies")])
student

#mutate
#mutate() adds new variables and preserves existing ones; 
#transmute() adds new variables and drops existing ones
student <-mutate(Total22 =  rowSums(student[c("Math", "Science","Social.Studies")]),student)
student

#Remove a  column
# by index
student <- student[,-8]
student

# by name
student <-mutate(Total22 =  rowSums(student[c("Math", "Science","Social.Studies")]),student)
student <- subset(student,select = -c(Total22))
student

# select subset using select
student1 <- subset(student,select = c(1:6))

#Remove NA ----
#removes rows with NA 
student_temp <-na.omit(student)
student_temp

#na.rm
student$total1 <- rowSums(student[,c("Math", "Science","Social.Studies")], na.rm=TRUE)        
student$RMean <- rowMeans(student[,c("Math", "Science","Social.Studies")], na.rm=TRUE)  
student

#Sort and order  ----
##sort is used for vectors----
sort(student$Total)

##order - returns a vector of the element----
student[order(student$Total),] #ascending notice the index at the beginning of the output #NA is at the end
student[order(student$Total, na.last = FALSE),]
student[order(student$Total, na.last = TRUE),]

student[order(-student$Total),] #descending

#student <- student[order(student$total),] #ascending

#Rename column
#Rename a specific column
names(student)[6] <- "Social_Studies"

#Merge
# Adding a new file
studentInfo  <- read.csv("Student_Info.csv", header=TRUE)

#Join two tables----
# Join the two tables using StudentID
all_student <- merge(student, studentInfo[, c("StudentID", "DOB")], by="StudentID" )
all_student <- merge(x=student[c(1:7)], y=studentInfo[, c("StudentID", "DOB")], by = "StudentID")
all_student

# Filtering ----
# using filter

top_student <- filter(student,student$RMean >= 90)
top_student

rm(top_student)

# using which
top_student <- student[which (student$RMean >= 90),]
top_student
top_student_mors <- student[which (student$Math >= 90 | student$Science >= 90),]
top_student_mors
top_student_mands <- student[which (student$Math >= 90 & student$Science >= 90),]
top_student_mands

# using subset
top_student2 <- subset(student,student$RMean >= 90)
top_student2

#Dates ----

Sys.Date() #notice the format in 'YYYY-MM-DD'

Dateformat <- "%m/%d/%y"

format(Sys.Date(), format=Dateformat)
format(Sys.Date(), format ="%d-%B-%y")

temp_date <- ("2021-01-27")
class(temp_date) #character datatype

temp_date <- as.Date("2021-01-27")
class(temp_date)  #date datatype

# Look at DOB in student file
class((all_student$DOB)) #imported as text
class(as.Date(all_student$DOB)) # Do you think the datatype has changed in the all_student dataframe?


all_student$DOB <-as.Date(all_student$DOB)  # assigning it to the data frame 

##Date calculations ----
#calculating ages
all_student$age <- round(difftime(Sys.Date(),as.Date(all_student$DOB),  unit = "auto"))
all_student # all in days
all_student$age1 <- round(trunc((Sys.Date() - as.Date(all_student$DOB))/365),2)
all_student$age1 # all in years

#SQL Manipulation----
#Ignore this if you do not have prior experience in SQL

install.packages("sqldf")
library(sqldf)

data()
DFCO2 <-data("CO2")
newdf <-sqldf("select * from CO2 where conc > 500")

rm(list = ls())


#************************************************************************************

# Aggregate function ----

medpres <- read.csv("Extra-Help-with-Medicare-Prescription-Drug-Plan-Cost.csv",skip = 4,header = TRUE)

#Renames the columns in the dataframe
colnames(medpres) <- c("Fiscal_Year", "State", "Decision_Made", "Eligible","Pct_Eligible")

# vector of New England States
NE <- c("Connecticut", "Vermont", "Massachusetts", "Rhode Island", "New Hampshire", "Maine")

# filter multiple values using i%in% function
NewEngland <- filter(medpres, medpres$State %in% NE)
structure(NewEngland)

# The following plot error out - saying duplicated values
barplot(as.character(State)~Fiscal_Year , data=NewEngland)

##Method # 1 aggregate data is using tapply. this creates an array ----
# create group summaries based on factor levels.
# Array has elements in the same data type.

temp_tapply <-tapply(NewEngland$Eligible, NewEngland$State, FUN=sum)

class(temp_tapply)
temp_tapply

# Example of a bar plot and color using Hex Codes

barplot(temp_tapply, col="#75BD97")
barplot(sort(temp_tapply), col="#75BD97")
barplot(sort(temp_tapply, decreasing=TRUE), col="Indian Red")

# barplot(temp_tapply, col = "Indian Red")
# barplot(temp_tapply, col = rgb(0.6,0.4,1,1))
# barplot(temp_tapply, col = colors()[987])
# barplot(temp_tapply, col = rgb(150,100,20,max=255))
#More than one color

barplot(sort(temp_tapply), col = c("#75BD97", "Indian Red"))

# Example of scatter plot
plot(temp_tapply)

##Method 2 aggregate the data using aggregate ----
aggNE <-aggregate(NewEngland$Eligible, by =list(State=NewEngland$State), sum)
class(aggNE)

# Rename x to Eligible
colnames(aggNE) <- c("State", "Eligible")

barplot(sort(Eligible)~State , data=aggNE, ylim = c(1000,40000), col="Dark Blue")

##Method 3 using gglplot, Automatically groups when you use- stat = "identity"----

# This line errors out
ggplot(NewEngland, aes(x=State, y= Eligible, group=1))  + geom_bar()

# Automatically groups - stat = "identity"
# gglot summarizes and uses y values to create values for the bar graphs

#If it is stat = "identity", we are asking R to use the y-value we provide for the dependent variable. 
# If we specify stat = "count" or leave geom_bar() blank, 
#    R will count the number of observations based on the x-variable groupings.
#
#https://bookdown.org/yih_huynh/Guide-to-R-Book/bar-graph.html 

ggplot(NewEngland, aes(x=State, y= Eligible)) +geom_bar(fill="Indian Red",stat="identity")
ggplot(NewEngland, aes(x=reorder(State, desc(Eligible)), y= Eligible)) +geom_bar(fill= "Sky Blue",stat="identity")

#Note: in your assignment you will be doing a count and not a sum.

#To experiment

lines()
box()
axis()
nrow(NewEngland)
cumsum()
NewEngland = mutate(cumc = cumsum(NewEngland$Decision_Made),NewEngland)

#Clean up ----
rm(list = ls())
dev.off()

