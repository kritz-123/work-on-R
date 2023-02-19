#File   : Module 2
#Project: Introduction to Analytics
#Author : Kayal Chandrasekaran

#
#Clean canvas ----
#clears the variables
rm(list=ls())
#clears the plots
dev.off() 

# Libraries ----
#library(FSA)
library(tidyverse)        


#To see the list of packages loaded
(.packages())

#Set working directory ----

setwd("C:/Users/kayal/Desktop/Kayal/NEU Classes/ALY6000/Teaching R/Data")


# Read files 
# skips first 4 lines and loads the data

medpres <- read.csv("Extra-Help-with-Medicare-Prescription-Drug-Plan-Cost.csv",skip = 4,
                    header = TRUE,stringsAsFactors = TRUE )

# Your data is stored more efficiently, because each unique string gets a number 
# For the command below - note State (sting variable is set as factor)
class(medpres)

#Take a look into dataframe and pay attention to the data types
str(medpres)

#Look at all column names and basic statistics
summary(medpres)

#Summary for categorical/qualitative variables (counts/frequencies)
summary(medpres$State)

#Summary for numerical/quantitative variables is the 5 point summary + mean
summary(medpres$Eligible)

##Renames the columns in the dataframe
colnames(medpres) <- c("Fiscal_Year", "State", "Decision_Made", "Eligible","Pct_Eligible")


###Method 2  to rename columns in a dataframe
# This method renames one column at a time
colnames(medpres)[1] <- "Fiscal_Year"
colnames(medpres)[2] <- "State"
colnames(medpres)[3] <- "Decision_Made"
colnames(medpres)[4] <- "Eligible"
colnames(medpres)[5] <- "Pct_Eligible"

###Method 3
#  %>% is called the "pipe" operator. 
# This function provided by the magrittr package
# This operator will forward a value, or the result of an expression, into the next function call/expression

# You can intentionally set column names using this method.
medpres <-medpres %>% 
  rename(
    Fiscal_Year = Fiscal.Year,
    Decisions_Made = Decisions.Made 
  )

#Look at the column names
summary(medpres)

#Unique list of values in the field
levels(medpres$State)

#Filters ----
# Filter function is available in library(dplr)
# filter only one value

##Method # 1 ----
All_States0 <-filter(medpres, State=="TOTAL")

##Method # 2 ----
# You are write this using pipe operator as follows
All_States0 <-medpres  %>% filter(State=="TOTAL")

##Method # 3 ----
# uses which
All_States00 <- medpres[which (medpres$State=="TOTAL"),]
#levels(All_States00$State)

##Method # 4 ----
#Subset function, you can choose column with this function
All_States1 <-  subset(medpres, State =="TOTAL", 
                       select =c("Fiscal_Year", "State", "Decision_Made", "Eligible","Pct_Eligible") )
#levels(All_States1$State)

##Method # 5 ----
#Slicing data
All_States2 <-  medpres[medpres$State =="TOTAL",]
#levels(All_States2$State)

str(All_States0)
levels(All_States0$State) # although you've filtered on TOTAL, all state values appears.

str(All_States2)
plot(Eligible~State, data=All_States2)



#Droplevels drops all the unused level
#The function droplevels is used to drop unused levels from a factor or, 
#more commonly, from factors in a data frame.

#Method 1
All_States3 <-  droplevels(filter(medpres, State=="TOTAL"))
str(All_States3)
levels(All_States3$State)
plot(Eligible~State, data=All_States3)

#Method 2
All_States4 <-  droplevels(All_States0)
levels(All_States4$State)

#Start from a clean state
rm(list=ls())


# FilterD function is available only in library("FSA")
#All_States <-  filterD(medpres, State=="TOTAL")
#str(All_States)
#levels(All_States$State)

#Reimporting the files having state as factors ----
medpres <- read.csv("Extra-Help-with-Medicare-Prescription-Drug-Plan-Cost.csv",
                    skip = 4,header = TRUE,stringsAsFactors = FALSE )
colnames(medpres) <- c("Fiscal_Year", "State", "Decision_Made", "Eligible","Pct_Eligible")
str(medpres)

#No need for droplevels when State is not set as factor. Here stringsAsFactors = FALSE 
All_States <-  (filter(medpres, State=="TOTAL"))
str(All_States)
levels(All_States$State)


#Getting started with plots

# Simple plot auto generated based by R automatically based on the data type of the variables.
plot(Eligible~Fiscal_Year, data=All_States)
#Box plot ----
boxplot(data=medpres,
        Pct_Eligible~Fiscal_Year, 
        ylab = "Pct Eligible", 
        xlab = "Fiscal Year",
        main = "Box Plot",
        col= "thistle3")


# vector of New England States
NE <- c("Connecticut", "Vermont", "Massachusetts", "Rhode Island", "New Hampshire", "Maine")

# filter multiple values using i%in% function
# filterD is in FSA library
NewEngland <- (filter(medpres, medpres$State %in% NE))
summary(NewEngland)

 # Add key column -- paste function
NewEngland <- cbind.data.frame(paste(NewEngland$State, NewEngland$Fiscal_Year), NewEngland)

# Renames the first columns
colnames(NewEngland)[1] <- c("rowid")
summary(NewEngland)

#Scatterplot ----
# The following plot is auto-generated by R based on the variable types
plot(Eligible~Pct_Eligible, 
    data=NewEngland,  
    col = "Red",
    pch = 18, # gives a diamond shape
    main = "Basic scatter plot"
    )

# adds data labels to the plot above.
text( Eligible ~ Pct_Eligible, 
      data= NewEngland,paste(State, "=", Fiscal_Year), 
      pos=1, 
      col="Dark Green", 
      cex=0.75)

# Histogram
hist(NewEngland$Pct_Eligible, 
     xlab = "Pct Eligible",
     main = "Histogram", 
     col= "thistle3")

#Line Plot 
# Do not forget to use sort when using line graph

## Without sort ----
plot(Eligible~(Pct_Eligible),  
     data=NewEngland,  
     col = "Purple", 
     type = "o" ,# this type specifies its a line plot
     main = "Line graph w/o sorting data"
)

## With sort ----
plot(Eligible~sort(Pct_Eligible),  
     data=NewEngland,  
     col = "Purple", 
     type = "o", # this type specifies its a line plot
     main = "Line graph with sorted data"
     )

#Summarize ----
# In order to cohesively present data by state, we can summarize

NESumm <- data.frame(
  NewEngland %>%
    group_by(State) %>%
    summarise(
      Decision_Made   = sum(Decision_Made),
      Eligible  = sum(Eligible),
      Pct_Eligible = mean(Pct_Eligible)
    ))
# draws a line plot
plot(Eligible~sort(Pct_Eligible),  
     data=NESumm,  
     col = "Purple", 
     type = "o", # this is responsible for the line plot
     main = "Line graph with summarized data")

# adds labels to the plot
text( Eligible ~ Pct_Eligible, 
      data= NESumm, State,  
      col="Dark Green", 
      cex=0.75)


# Bar Plot ----
# make sure you sort the data before you chart the graph (except for Time based variables)

barplot(sort(Decision_Made)~State, 
        ylab = "Decision Made",
        data=NESumm,  
        col = "Steel Blue")

lines(sort(NESumm$Decision_Made), 
      col = "Dark Blue", 
      lty =2, 
      lwd=2) #gets superimposed on barplot

# Pie Chart ----
pie(NESumm$Pct_Eligible, 
    labels = paste(NESumm$State," - ",NESumm$Eligible),    
    main="Pie Chart of States", 
    col = rainbow(6) # try terrain.colors(6)
    )
legend("topleft", inset=-.005, 
       legend= (NESumm$State), 
       text.col = rainbow(6), 
       bty = "n")
       
#Plotting using data ----
##Method #1 using data ----
plot(Eligible~ Fiscal_Year , 
     data=All_States,  
     col="Dark green", 
     pch=20,
     main = "Eligible by Fiscal Year (green plot)",
     col.main = "Dark green")

##Method #2 using df_name$column_name ----
plot(All_States$Eligible~ All_States$Fiscal_Year ,  
     col="red", 
     pch =16,
     main = "Eligible by Fiscal Year (red plot)",
     col.main = "red")

# Plot parameters----
##Method #1 Using par() ---- 
par(pch = 19)
plot(Eligible~ Fiscal_Year , 
     data=All_States,
     main = "Provided par separately")

#list of all par values set
par()

##Method #2 using parameters in the command ----
plot( Fiscal_Year~Pct_Eligible , 
      data=All_States, 
      pch = 18, 
      col="Purple",
      main ="par integrated")


# pch and lty - http://www.sthda.com/english/wiki/graphical-parameters
# colors - https://htmlcolorcodes.com/color-names/ 
# pch = shape, lty = type of line, col = color

## Color, LTY, PCH ----
?colors
help(color)

colors()  # lists all colors

par(pch = 19,  
    col = "Black", 
    col.axis = "Blue", 
    col.main = "Red")

plot(Eligible ~ Decision_Made, 
     data= All_States, 
     main = "Decisions Made Vs Elig")

## Cex ----
#cex is the size of the text

par(cex = 0.9, 
    cex.main = 1.5, 
    cex.axis = 0.7) #Why is the title red?
plot(Eligible ~ Decision_Made, 
     data= All_States, 
     main = "Decisions Made Vs Elig")

## Font ----
#font is font of the text
# 1 = plain
# 2 = bold
# 3 = italic
# 4 = bold italic
# 5 = symbol

par(font.main = 3)
plot(Eligible ~ Decision_Made, data= All_States, main = "Decisions Made Vs Elig")

##Resetting par colors to be black----
par(pch = 19,  
    col = "Black", 
    col.axis = "Black", 
    col.main = "Black",
    cex = 1, 
    cex.main = 1.5, 
    cex.axis = 0.9,
    font =1)


## Border----
#pin plot dimensions
###mai ----
#numerical vector indicating margin size c(bottom, left, top, right) in inches
par(pin =c(3,4), 
    mai=c(0.5,1,0.82,0.42))
plot(Eligible ~ Decision_Made, 
     data= All_States, 
     main = "Decisions Made Vs Elig")

###mar ----
par(pin =c(3,4), mar=c(4,4,4,4))
plot(Eligible ~ Decision_Made, data= All_States, main = "Decisions Made Vs Elig")

## Title ----
#follows the plot unlike par function that precedes plot

par(pin =c(4,4), mar=c(5,5,5,5))
plot(Eligible ~ Decision_Made, data= All_States)   
title(main = "Main title", sub = "Decision Vs Elig" ) # sub title shows up in bottom
  
##Remove default ----
 #ann = FALSE removes default titles and labels
 #xaxt = "n", yaxt = "n" removes default labels

plot(Eligible ~ Decision_Made, 
     data= All_States, 
     ann = FALSE, 
     xaxt="n", 
     yaxt="n") 
title(main = "Decisions Vs Elig", 
      sub = "Decision Vs Elig", 
      xlab = "Decision" , ylab="Eligible")

#Axis----
#las - for labels 
  # 0 = always parallel to the axis - default
  # 1 = always horizontal 
  # 2 = always perpendicular to the axis 
  # 3 = always vertical
#tck - tick mark 
  # 0 - suppresses ticks, 1 = creates gridlines, -ve tick creates tick outside
#side - 
  #1 = bottom, 2=left,3=top, 4= right

axis(side = 2,  tck=0, las = 1) #tck = 0 suppresses it
axis(side = 1,  tck=1, las = 1) # tck = 1 draws gridlines inside
axis(side = 2,  tck= -0.01, las = 2) #tck = -ve value draws outside the plot

# Reference line ----
#lm linear regression line lm is linear model
# ~ says its a function of 

abline(lm(Eligible ~ Decision_Made, data= All_States),col="Red", lwd=3)

# Text----
 #paste function to concatenate  values 
text( Eligible ~ Decision_Made, data= All_States,paste("Year = ", Fiscal_Year), 
      pos=1, col="Dark Green", cex=0.75)

# Legend ----

pchst <- c(15,16,17,18,19,25)
pchst[ factor(NewEngland$State)]
pchst1 <-pchst[ factor(NewEngland$State)]

colst <- c("SteelBlue", "OliveDrab", "Orchid", "Gold", "Brown", "Tomato")
colst1 <-colst[ factor(NewEngland$State)]

par(col= "purple",
    pch = 19,  
    lty = 4, 
    cex = 0.9, 
    cex.main = 1.5, 
    cex.axis =0.9,
    font.main = 3, 
    pin =c(6,4), 
    bg="White")

plot(Eligible~Pct_Eligible, data=NewEngland, col=colst1, main = "Assigned diff colors") 
# only color changes
plot(Eligible~Pct_Eligible, data=NewEngland, pch=pchst1, main = "Assigned diff plotting characters") 
# only plotting character changes
plot(Eligible~Pct_Eligible, data=NewEngland, col=colst1, pch=pchst1, main = "Assigned diff colors + pch")

stcode <- c("CT","ME", "MA","NH","RI","VT")
stcode[factor(NewEngland$State)]

plot(Eligible~Pct_Eligible, data=NewEngland, col=colst,pch=pchst, main = "Added text labels") # change both color and plotting characters

legend("topleft", inset=0.05, legend=stcode, pch=pchst, col=colst, bty="n", text.col = colst)
text( Eligible ~ Pct_Eligible, data= NewEngland, stcode, pos=1, col="Dark Green", cex=0.75)

#Multi Row graphs ----
#called small multiple
par(pin =c(3,4), mar=c(4,4,4,4))
par(mfrow=c(2,2))

hist(NewEngland$Decision_Made[NewEngland$State =='Vermont'],  
     main = 'Vermont',
     xlab = 'Vermont',
     breaks = 15,
     #freq = FALSE, #gives density, propotions
     col="Dark green", 
     pch=20)
hist(NewEngland$Decision_Made[NewEngland$State =='Connecticut'], 
     main = 'Connecticut',
     xlab = 'Connecticut',
     breaks = 15,
     col="Tomato", 
     pch=20)
hist(NewEngland$Decision_Made[NewEngland$State =='Massachusetts'],  
     main = 'Massachusetts',
     xlab = 'Massachusetts',
     breaks = 15,
     col="thistle3", 
     pch=20)
hist(NewEngland$Decision_Made[NewEngland$State =='Rhode Island'],  
     main = 'Rhode Island',
     xlab = 'Rhode Island',
     breaks = 15,
     col="thistle3", 
     pch=20)

#revert it back
par(mfrow=c(1,1))


#Plots ----
#Lets get started on the plots 

iris_data = data.frame(data("iris"))

plot(iris$Species) # for categorical variables

plot(iris$Petal.Length) # for numerical variables

plot(iris$Sepal.Length~iris$Species) # categorical (on x axis) vs numerical (on y axis)

plot(iris$Species~iris$Sepal.Length) # categorical (on y axis) vs numerical (on x axis)

plot(iris$Petal.Length~iris$Petal.Width) # plotting two numerical variables

plot(iris) #gives you an overall idea of what is going on in the data

# Clean up ----
#clears the variables
rm(list=ls())
#clears the plots
dev.off() 

