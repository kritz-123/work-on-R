#File   : Module 3
#Project: Introduction to Analytics

#Clean canvas ----
#clears the variables
rm(list=ls())
#clears the plots
dev.off() 

name <-c ("Kritika Gehlot")
name

#Load library ----
library(tidyverse)
library(data.table)
#To see the list of packages loaded
(.packages())

#Import inchBio table ----
bio  <- read.csv("C:/Users/kriti/Downloads/inchBio.csv", header=TRUE)
bio

#Display head, tail and structure of bio
head(bio)
tail(bio)
structure(bio)

#	Create an object, <counts>, that counts and lists all the species records?
counts <- length(inchBio$species)
counts

#Display just the eight level of species
specie <-unique(inchBio$species)
specie
length(specie)

# 	Create a <tmp> object that displays the different species and the number of record of each species in the dataset. Include this information in your report.-

tmp <- table(inchBio$species)
tmp
# Create a subset, <tmp2>, of just the species variable and display the first five records (hint : display first 5 and last 5 records)
tmp2 <- subset(inchBio, select = species)
tmp2
head(tmp2,5)
tail(tmp2,5)
#	Create a table, <w>, of the species variable. Display the class of w

w <- table(inchBio$species)
w
class(w)

# Convert <w> to a data frame named <t> and display the results
t <- data.frame(w)
t

#	Extract and display the frequency values from the <t> data frame
t
#	Create a table named <cSpec> from the bio species attribute (variable) and confirm that you created a table which displays the number of species in the dataset <bio>
cSpec <- table(bio$species)
cSpec

# Create a table named <cSpecPct> that displays the species and percentage of records for each species. Confirm you created a table class.

 cSpecPct <- prop.table(cSpec) 
 cSpecPct 

#	Convert the table, <cSpecPct>, to a data frame named <u> and confirm that <u> is a data frame
  u <- data.frame(cSpecPct)
u 

# Create a barplot of <cSpec> with the following: titled Fish Count with the following specifications:
barplot(cSpec, main="Fish Count",
        ylab="COUNTS", col=c("lightgreen"),
        cex.axis=0.60, axisnames = 0.5, las=1)
#	Create a barplot of <cSpecPct>, with the following specifications:
barplot(cSpecPct, main="Fish Relative Frequency", ylim = c(0,0.4), col = c("lightblue"))

#	Rearrange the <u> cSpec Pct data frame in descending order of relative frequency. Save the rearranged data frame as the object <d>

d <- u[order(-cSpecPct),] 
d  

#17.	Rename the <d> columns Var 1 to Species, and Freq to RelFreq
names(d) <-c('Species','RelFreq') 
d

#18.	Add new variables to <d> and call them cumfreq, counts, and cumcounts. 
cumfreq = cumsum(d$RelFreq)
counts = d$RelFreq
cumcounts = cumsum(counts)
d <-cbind(d,cumfreq, counts, cumcounts)
d


#19.	Create a parameter variable <def_par> to store parameter variables
def_par <- par(no.readonly = TRUE )
def_par

#20.	Create a barplot, <pc>, with the following specifications:

pc <-barplot(d$counts, main="Species Pareto" ,width=1,space =0.15,names.arg = d$Species,
        border = NA, ylim = c(0, 3.05*max(d$counts)), cex.axis=0.7, cex.names = 0.6, axes = F, las=2,
             ylab="Cummulative Counts")
pc

#21.	Add a cumulative counts line to the <pc> plot with the following:
barplot(d$counts, main="Species Pareto",width=1,space =0.15,names.arg = d$Species,
        border = NA, ylim = c(0, 3.05*max(d$counts)), cex.axis=0.7, cex.names = 0.6, axes = F, las=2,
        ylab="Cummulative Counts")
lines(d$cumcounts, type = "b",pch=19, Ity=2, col= "cyan4", cex.names =0.7)

#22.	Place a grey box around the pareto plot 
barplot(d$counts, main="Species Pareto" ,width=1,space =0.15,names.arg = d$Species,
        border = NA, ylim = c(0, 3.05*max(d$counts)), cex.axis=0.7, cex.names = 0.6, axes = F, las=2,
        ylab="Cummulative Counts")
lines(d$cumcounts, type = "b",pch=19,Ity=2, col= "cyan4")
box(col='grey')

#23.	Add a left side axis with the following specifications
barplot(d$counts, main="Species Pareto" ,width=1,space =0.15,names.arg = d$Species,
        border = NA, ylim = c(0, 3.05*max(d$counts)), cex.axis=0.7, cex.names = 0.6, axes = F, las=2,
        ylab="Cummulative Counts")
lines(d$cumcounts, type = "b",pch=19,Ity=2, col= "cyan4")
box(col='grey')
axis(2, at=d$cumcounts,labels= d$cumcounts,col.ticks = "grey62", col.axis= "grey62",
     cex.axis = 0.4,las =2)

axis(4, at=d$cumcounts, labels=d$cumfreq*100, col.ticks = "cyan4", col.axis="cyan4", cex.axis=0.4,
     las =2)
#24	Display the finished Species Pareto Plot (without the star watermarks). Have your last name on the plot
barplot(d$counts, main="Species Pareto: Gehlot" ,width=1,space =0.15,names.arg = d$Species,
        border = NA, ylim = c(0, 3.05*max(d$counts)), cex.axis=0.7, cex.names = 0.6, axes = F, las=2,
        ylab="Cummulative Counts")
lines(d$cumcounts, type = "b",pch=19,Ity=2, col= "cyan4")
box(col='grey')
axis(2, at=d$cumcounts,labels= d$cumcounts,col.ticks = "grey62", col.axis= "grey62",
     cex.axis = 0.4,las =2)

axis(4, at=d$cumcounts, labels=d$cumfreq*100, col.ticks = "cyan4", col.axis="cyan4", cex.axis=0.4,
     las =2)









