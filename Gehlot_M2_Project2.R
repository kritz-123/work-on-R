#File   : Module 2
#Project: Introduction to Analytics
#clears the variables
rm(list=ls())
library(tidyverse)  
name <-c ("Plotting Basics: Gehlot")
name

#install packages FSA, FSAdata, magrittr, dplyr, plotrix, ggplot2, moments


#load data
bulltrout <- read.csv("C:/Users/kriti/Downloads/BullTroutRML2.csv" )
bulltrout

#Printing first and last 3 records from bulltrout data

df1 <-rbind(head(BullTroutRML2,1),tail(BullTroutRML2,3))
df1
harrilake <- filter(BullTroutRML2, lake == "Harrison")
harrilake

class(BullTroutRML2)
structure(BullTroutRML2)

#display first and last 5 records from filtered data
df <- rbind(head(harrilake,1),tail(harrilake,5))
df

str(harrilake)
summary(harrilake)

#creating a scatterplot for "age" (y variable) and "fl" (x variable)
attach(harrilake)
class(age)
class(fl)
class(lake)
class(era)
plot(fl,age)
# sactter plot
plot(fl, age, main="Plot 1: Harrison Lake Trout", xlab="Fork Length(mm)", ylab="Age(yrs)", xlim = c(0,500), ylim = c(0, 15), pch = 19)
cor(fl,age)
#plot "Age" histogram 
hist(age, main="Plot 2: Harrison Fish Age Distribution", xlab="Age(yrs)",ylab="Frequency", xlim = c(0,15), ylim=c(0,15), col.main="cadetblue", col="cadetblue")

#create overdense plot
smoothScatter(fl, age, main="Plot 3: Harrison Density Shaded by Era", xlab="Fork Length(mm)", ylab="Age(yrs)", xlim = c(0,500), ylim = c(0, 15),
              colramp= colorRampPalette(c("white","green","yellow"),space="Lab"),pch = 19)

#Create a new object called “tmp” that includes the first 3 and last 3 records of the BullTroutRML2 data set.

tmp <-rbind(head(harrilake,3),tail(harrilake,3))
print(tmp)

#display "era" variable from temp
print(tmp$era)

#Create a pchs vector with the argument values for + and x. 
pchs <-c('+','*')
pchs

#create a cols vector with the two elements "red" and "gray60"
cols <-c('red','gray60')
cols

#converting the temp era varible in numeric
tmp1 <- as.numeric(tmp$era)
tmp1

#	Initialize the cols and pch vectors with the BullTroutRML2 era values
tmp1 <-cols
tmp1

tmp1 <-pch
tmp1

#Create a plot of “Age (yrs)” (y variable) versus “Fork Length (mm)” (x variable) 
plot(fl,age,main="Plot 4: Symbol & Color by Era", xlim =c(0,500), ylim =c(0,15), xlab="Fork Length(mm)",
     ylab="Age(yrs)", pch=ifelse(era=="1977-80",pchs[1],pchs[2]), col=ifelse(era=="1977-80",cols[1],cols[2]))

#	Plot a regression line overlay on Plot 4 and title the new graph “Plot 5: Regression Overlay”.
plot(fl,age,main="Plot 5: Regression", xlim =c(0,500), ylim =c(0,15), xlab="Fork Length(mm)",
     ylab="Age(yrs)", pch=ifelse(era=="1977-80",pchs[1],pchs[2]), col=ifelse(era=="1977-80",cols[1],cols[2]))

abline(lm(age~fl,data=harrilake),col="blue")

#20.	Place a legend of on Plot 5 and call the new graph “Plot 6: :Legend Overlay”

plot(fl,age,main="Plot 6: Legend Overlay", xlim =c(0,500), ylim =c(0,15), xlab="Fork Length(mm)",
     ylab="Age(yrs)", pch=ifelse(era=="1977-80",pchs[1],pchs[2]), col=ifelse(era=="1977-80",cols[1],cols[2]))

legend("topleft",c("1977-80","1997-01"),pch=c("+","*"),col=c("yellow","grey"))


