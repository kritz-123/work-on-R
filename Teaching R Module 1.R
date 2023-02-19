#File   : Module 1.
#Project: Introduction to Analytics
#Author : Kayal Chandrasekaran

# Case sensitive language ####
help()

Help ()

HELP()

# Adding comments####
# Why add a comment?
# You can use ====, ----, #### .

# 1 hash at the beginning creates Comments
# 4 hashes at the end creates header

# You can use one # for Level 1, 2 # for Level 2 and 3 # for Level 3.
#   Level 1 Header
##  Level 2 Header
### Level 3 Header

# Simple statements####

#Simple Math
2+3

#Sequences
1:100

seq(200) #generates numbers 1 through 200

seq(200,100) #generates numbers 200 through 100 in reverse

seq(200,0, by=-3)  #generates numbers 200 through 0 in reverse, steps down by 3


# Simple Assignment 
a<-3

#Multiple assignments
a <- b<- c<- 5

#Assigning to vectors
age <- c(3,4,5,2,1,6,7,4)
weight <-c(20,17.4,14.2,6.5,5.5,3,30,23)

#Simple out-of-the-box functions----
mean(age)
plot(sort(age))
hist(age)

plot(weight, age )

sort(age) # Only sorts in the output
age <- sort(age) 
sort(weight)
weight <- sort(weight) 

# Simple commands----
# working directories
getwd()

setwd("C:/Users/kayal/Desktop/Kayal/NEU Classes/ALY6000/Teaching R/Data")

getwd()

#lists all the variables
ls()

#removes a variables
rm("age")
#removes all variables
rm(list = ls())

#quit
#q()

#Packages----
#data sets
library(help = "datasets")


##Install packages----
installed.packages()

# to install a package
install.packages("tidyverse")

#to install multiple packages 
#install.packages("magrittr",   "plyr", "dplyr", "plotrix", "ggplot2", "moments", "tidyr", "tidyverse")


#library path
.libPaths()

#help on this package
#every package  has a pdf
help(package="tidyverse")
?tidyverse

#lists all the packages loaded including base packages
(.packages())

##Load packages----
#to load the package in the R session
library(tidyverse) # important package, attaches several other packages

(.packages()) #see additional packages loaded

#library - lists all the packages available
library()

library(pacman)
library(vcd)

##Unload packages----
#Unload packages - part of pacman 
p_unload(vcd)

#list packages
(.packages())

#unloads all third party (contributed) packages, not base packages
p_unload(all)

# see list of packages now
(.packages())

#another way to load package - use "require"
require(vcd)

#another way to detach a package
library(vcd)
detach(package:vcd)

#Also look at left-lower screen, Packages tab

#Data Types----
##numeric----

typeof(a) # stores as double

##character----

course <- 'Analytics' #single quote
typeof(course)
course <- "Analytics" #double quotes
typeof(course)

longstr <- 'Welcome to Analytics'
typeof(longstr) # in other languages it may be called string

##logical----

IsIt <- TRUE
typeof(IsIt)

IsIt <- T
typeof(IsIt)

#Data Structures----
##Vector----
age <- c(3,4,5,2,1,6,7,4)

##Matrix----
#need to be the same type
k <- matrix(1:20, nrow = 5, ncol = 4 , byrow = TRUE)
k

k1 <- matrix(1:20, nrow = 5, ncol = 4 , byrow = FALSE)
k1

fruitnames <-matrix (c("Apple", "Orange", "Mango", "Pineapple"), nrow=2)
fruitnames

# type of an object is its datatype type
# class of show how it is stored in the memory

class(fruitnames)
typeof(fruitnames)

logicmat <-matrix (c(F,T,F,T,T ,F), nrow=2)
logicmat

logicmat <-matrix (c('FALSE','TRUE',"FALSE",T,T ,F), nrow=2)
logicmat

logicmat <-matrix (c('FALSE','TRUE','FALSE','TRUE'), nrow=2)
logicmat

##DataFrame----
kids <-  data.frame(age, weight)
kids

kids[1]
kids[2]

kids[c("age")]

#Diabetes data

age <- c(35,56,90,23,41,56,67,10,5)
hasdiab <- c(TRUE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE,FALSE,TRUE)
type <- c("Type 1","NA","Type 2","NA","Type 1","Type 2","Type 2","NA","Type 1")
status <- c("Improved","NA","Poor","NA","Poor","Improved","Improved","NA","Good")

patients <- data.frame(age, hasdiab, type, status)

patients[c("age","hasdiab")]

patientid <- c(1,2,3,4,5,6,7,8,9)

patients <-cbind.data.frame(patientid, patients,row.names=patientid)

class(patients)
str(patients) # str stands for structure
summary(patients)

diabetes <-factor(status)
diabetes

diabetes <-factor(status, order= TRUE, levels =c("NA", "Good", "Improved", "Poor"))
diabetes

##List----
newlist <-list(age, k, diabetes)

newlist[[1]]

#Reading data ####

##csv----
diabpatients <- read.csv("diabpatient.csv")

##xlsx----

#install.packages("RODBC")
#Always list all the libraries at the beginning of the pgm. This is just an example.
library(RODBC)
library(openxlsx)
diabxlsx <- read.xlsx("diabpatient.xlsx")

#The entire command with brackets will load and display few records
(diabxlsx <- read.xlsx("diabpatient.xlsx"))

##inbuilt datasets----

data()
mtcars_data <-data(mtcars)

##from url----

walmart_data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/1962_2006_walmart_store_openings.csv")

#Other useful functions----

#look at contents for reference
diabpatients

length(diabpatients)
dim(patients)
str(patients)

class(patients)
class(patients$hasdiab)
names(diabpatients)

head(patients, 2)

tail(patients, 2)

# Clean up ----
#clears the variables
rm(list=ls())
#clears the plots
dev.off() 

