###################################################### Libraries

library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
library(ggridges)

###################################################### Duncan Index Function

# toy data example (from Sara's pdf)
my_data <- data.frame(occupation = c(1,2,3),
                      females = c(10,40,30),
                      males = c(50,25,25))

# see data.frame
my_data
f <- my_data$females
m <- my_data$males

calc_duncan <- function(f, m){
  
  # Change the value types of the data from "character" to "numeric" to perform calculations
  f <- as.numeric(f)
  m <- as.numeric(m)
  
  # totals each sex
  f_tot <- sum(f)
  m_tot <- sum(m)
  
  # fractions each sex 
  f_frac <- f/f_tot
  m_frac <- m/m_tot
  
  # diff abs value
  diff_abs <- abs(f/f_tot - m/m_tot)
  
  # calculate duncan index
  duncan <- 1/2*sum(diff_abs)
  
  return(duncan)
  
}

# run function, same answer as Sara's pdf
calc_duncan(my_data$females, my_data$males)





######################################################  DI by region 2021



# Initial importation / read in of the two xlsx files, male and female, 2021, 16 and over
ini_f_2021 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2021r.xlsx")
ini_m_2021 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2021r.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_2021 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2021r.xlsx")
m_2021 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2021r.xlsx")

# Check column names are the same in both tables
all.equal(names(f_2021), names(m_2021))

# Extraction of the 9 occupation columns for both women and men
cols_2to10_f_2021 <- subset(f_2021, select = c(2,3,4,5,6,7,8,9,10))
cols_2to10_m_2021 <- subset(m_2021, select = c(2,3,4,5,6,7,8,9,10))

# Extraction of regions column
regions_2021 <- m_2021[,c(1)]

# Optional new region header for simplicity
colnames(regions_2021)[1]  <- "region" 

# Transpose the regions column so that it becomes a row
regions_2021_t <- as.data.frame(t(regions_2021))

# Transpose so that columns are regions and rows are occupations
f_2021_t <- as.data.frame(t(cols_2to10_f_2021))
m_2021_t <- as.data.frame(t(cols_2to10_m_2021)) 

# Merge the region row at the top of the transposed data frames
f_2021b <- rbind(regions_2021_t, f_2021_t)
m_2021b <- rbind(regions_2021_t, m_2021_t)

# Take the region row and turn it into the df header of the data frames
names(f_2021b) <- f_2021b[1,]
names(m_2021b) <- m_2021b[1,]

# Delete the superfluous region row
f_2021b <- f_2021b[-1,]
m_2021b <- m_2021b[-1,]

# Create a function that calculates the Duncan index by region  
calc_duncan_per_region <- function(x){ calc_duncan(f_2021b[,x], m_2021b[,x]) }

# Applying the above function for all regions of interest by looping over them 
duncan_per_region <- as.data.frame(sapply(names(m_2021b), calc_duncan_per_region))

# check that above worked with two examples
calc_duncan(f_2021b$Darlington, m_2021b$Darlington)
calc_duncan(f_2021b$Newport, m_2021b$Newport)

# Renaming the column of the unsorted data frame
colnames(duncan_per_region)[1]  <- "Duncan_index" 

duncan_per_region_2021 <- as.data.frame(duncan_per_region)

# sort Duncan index from low to high
duncan_per_region_sorted_2021 <- as.data.frame(duncan_per_region[order(duncan_per_region$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_region_sorted_2021)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_region_sorted_2021)

# see highest values, lowest gender equality 
tail(duncan_per_region_sorted_2021)

# Generating histogram data points
Duncan_Indices_per_region  <- duncan_per_region[order(duncan_per_region$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_region, 
     main="Histogram of Duncan Indices per region 2021",
     ylab="Frequency",
     xlab="Duncan Index",
     col="blue",
     border="black", xlim=c(0,1), ylim=c(0,10))

# Exporting the Duncan indices as a csv
write.csv(duncan_per_region_sorted_2021, "C:\\Users\\sarab\\Desktop\\duncan_per_region_2021.csv", row.names=TRUE)



######################################################  DI by region 2011



# Initial importation / read in of the two xlsx files, male and female, 2011, 16 and over
ini_f_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2011r.xlsx")
ini_m_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2011r.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2011r.xlsx")
m_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2011r.xlsx")


# Check column names are the same in both tables
all.equal(names(f_2011), names(m_2011))

# Extraction of the 9 occupation columns for both women and men
cols_2to10_f_2011 <- subset(f_2011, select = c(2,3,4,5,6,7,8,9,10))
cols_2to10_m_2011 <- subset(m_2011, select = c(2,3,4,5,6,7,8,9,10))

# Extraction of regions column
regions_2011 <- m_2011[,c(1)]

# Optional new region header for simplicity
colnames(regions_2011)[1]  <- "region" 

# Transpose the regions column so that it becomes a row
regions_2011_t <- as.data.frame(t(regions_2011))

# Transpose so that columns are regions and rows are occupations
f_2011_t <- as.data.frame(t(cols_2to10_f_2011))
m_2011_t <- as.data.frame(t(cols_2to10_m_2011)) 

# Merge the region row at the top of the transposed data frames
f_2011b <- rbind(regions_2011_t, f_2011_t)
m_2011b <- rbind(regions_2011_t, m_2011_t)

# Take the region row and turn it into the df header of the data frames
names(f_2011b) <- f_2011b[1,]
names(m_2011b) <- m_2011b[1,]

# Delete the superfluous region row
f_2011b <- f_2011b[-1,]
m_2011b <- m_2011b[-1,]

# Create a function that calculates the Duncan index by region  
calc_duncan_per_region <- function(x){ calc_duncan(f_2011b[,x], m_2011b[,x]) }

# Applying the above function for all regions of interest by looping over them 
duncan_per_region <- as.data.frame(sapply(names(m_2011b), calc_duncan_per_region))

# check that above worked with two examples
calc_duncan(f_2011b$Darlington, m_2011b$Darlington)
calc_duncan(f_2011b$Newport, m_2011b$Newport)

# Renaming the column of the unsorted data frame
colnames(duncan_per_region)[1]  <- "Duncan_index" 

duncan_per_region_2011 <- as.data.frame(duncan_per_region)

# sort Duncan index from low to high
duncan_per_region_sorted_2011 <- as.data.frame(duncan_per_region[order(duncan_per_region$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_region_sorted_2011)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_region_sorted_2011)

# see highest values, lowest gender equality 
tail(duncan_per_region_sorted_2011)

# Generating histogram data points
Duncan_Indices_per_region  <- duncan_per_region[order(duncan_per_region$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_region, 
     main="Histogram of Duncan Indices per region 2011",
     ylab="Frequency",
     xlab="Duncan Index",
     col="green",
     border="black", xlim=c(0,1), ylim=c(0,10))

# Exporting the Duncan indices as a csv
write.csv(duncan_per_region_sorted_2011, "C:\\Users\\sarab\\Desktop\\duncan_per_region_2011.csv", row.names=TRUE)



######################################################  DI by region 2001



# Initial importation / read in of the two xlsx files, male and female, 2001, 16 and over
ini_f_2001 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2001r.xlsx")
ini_m_2001 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2001r.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_2001 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2001r.xlsx")
m_2001 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2001r.xlsx")


# Check column names are the same in both tables
all.equal(names(f_2001), names(m_2001))

# Extraction of the 9 occupation columns for both women and men
cols_2to10_f_2001 <- subset(f_2001, select = c(2,3,4,5,6,7,8,9,10))
cols_2to10_m_2001 <- subset(m_2001, select = c(2,3,4,5,6,7,8,9,10))

# Extraction of regions column
regions_2001 <- m_2001[,c(1)]

# Optional new region header for simplicity
colnames(regions_2001)[1]  <- "region" 

# Transpose the regions column so that it becomes a row
regions_2001_t <- as.data.frame(t(regions_2001))

# Transpose so that columns are regions and rows are occupations
f_2001_t <- as.data.frame(t(cols_2to10_f_2001))
m_2001_t <- as.data.frame(t(cols_2to10_m_2001)) 

# Merge the region row at the top of the transposed data frames
f_2001b <- rbind(regions_2001_t, f_2001_t)
m_2001b <- rbind(regions_2001_t, m_2001_t)

# Take the region row and turn it into the df header of the data frames
names(f_2001b) <- f_2001b[1,]
names(m_2001b) <- m_2001b[1,]

# Delete the superfluous region row
f_2001b <- f_2001b[-1,]
m_2001b <- m_2001b[-1,]

# Create a function that calculates the Duncan index by region  
calc_duncan_per_region <- function(x){ calc_duncan(f_2001b[,x], m_2001b[,x]) }

# Applying the above function for all regions of interest by looping over them 
duncan_per_region <- as.data.frame(sapply(names(m_2001b), calc_duncan_per_region))

# check that above worked with two examples
calc_duncan(f_2001b$Darlington, m_2001b$Darlington)
calc_duncan(f_2001b$Newport, m_2001b$Newport)

# Renaming the column of the unsorted data frame
colnames(duncan_per_region)[1]  <- "Duncan_index" 

duncan_per_region_2001 <- as.data.frame(duncan_per_region)

# sort Duncan index from low to high
duncan_per_region_sorted_2001 <- as.data.frame(duncan_per_region[order(duncan_per_region$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_region_sorted_2001)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_region_sorted_2001)

# see highest values, lowest gender equality 
tail(duncan_per_region_sorted_2001)

# Generating histogram data points
Duncan_Indices_per_region  <- duncan_per_region[order(duncan_per_region$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_region, 
     main="Histogram of Duncan Indices per region 2001",
     ylab="Frequency",
     xlab="Duncan Index",
     col="orange",
     border="black", xlim=c(0,1), ylim=c(0,10))

# Exporting the Duncan indices as a csv
write.csv(duncan_per_region_sorted_2001, "C:\\Users\\sarab\\Desktop\\duncan_per_region_2001.csv", row.names=TRUE)


######################################################  DI by region 1991


######################################################  Sara's path

# Initial importation / read in of the two xlsx files, male and female, 1991, 16 and over
ini_f_1991 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_1991r.xlsx")
ini_m_1991 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_1991r.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_1991 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_1991r.xlsx")
m_1991 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_1991r.xlsx")


# Check column names are the same in both tables
all.equal(names(f_1991), names(m_1991))

# Extraction of the 9 occupation columns for both women and men
cols_2to10_f_1991 <- subset(f_1991, select = c(2,3,4,5,6,7,8,9,10))
cols_2to10_m_1991 <- subset(m_1991, select = c(2,3,4,5,6,7,8,9,10))

# Extraction of regions column
regions_1991 <- m_1991[,c(1)]

# Optional new region header for simplicity
colnames(regions_1991)[1]  <- "region" 

# Transpose the regions column so that it becomes a row
regions_1991_t <- as.data.frame(t(regions_1991))

# Transpose so that columns are regions and rows are occupations
f_1991_t <- as.data.frame(t(cols_2to10_f_1991))
m_1991_t <- as.data.frame(t(cols_2to10_m_1991)) 

# Merge the region row at the top of the transposed data frames
f_1991b <- rbind(regions_1991_t, f_1991_t)
m_1991b <- rbind(regions_1991_t, m_1991_t)

# Take the region row and turn it into the df header of the data frames
names(f_1991b) <- f_1991b[1,]
names(m_1991b) <- m_1991b[1,]

# Delete the superfluous region row
f_1991b <- f_1991b[-1,]
m_1991b <- m_1991b[-1,]

# Create a function that calculates the Duncan index by region  
calc_duncan_per_region <- function(x){ calc_duncan(f_1991b[,x], m_1991b[,x]) }

# Applying the above function for all regions of interest by looping over them 
duncan_per_region <- as.data.frame(sapply(names(m_1991b), calc_duncan_per_region))

# check that above worked with two examples
calc_duncan(f_1991b$Darlington, m_1991b$Darlington)
calc_duncan(f_1991b$Newport, m_1991b$Newport)

# Renaming the column of the unsorted data frame
colnames(duncan_per_region)[1]  <- "Duncan_index" 

duncan_per_region_1991 <- as.data.frame(duncan_per_region)

# sort Duncan index from low to high
duncan_per_region_sorted_1991 <- as.data.frame(duncan_per_region[order(duncan_per_region$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_region_sorted_1991)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_region_sorted_1991)

# see highest values, lowest gender equality 
tail(duncan_per_region_sorted_1991)

# Generating histogram data points
Duncan_Indices_per_region  <- duncan_per_region[order(duncan_per_region$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_region, 
     main="Histogram of Duncan Indices per region 1991",
     ylab="Frequency",
     xlab="Duncan Index",
     col="pink",
     border="black", xlim=c(0,1), ylim=c(0,10))

# Exporting the Duncan indices as a csv
write.csv(duncan_per_region_sorted_1991, "C:\\Users\\sarab\\Desktop\\duncan_per_region_1991.csv", row.names=TRUE)



######################################################  DI by region 1981


######################################################  Sara's path

# Initial importation / read in of the two xlsx files, male and female, 1981, 16 and over
ini_f_1981 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_1981r.xlsx")
ini_m_1981 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_1981r.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_1981 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_1981r.xlsx")
m_1981 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_1981r.xlsx")


# Check column names are the same in both tables
all.equal(names(f_1981), names(m_1981))

# Extraction of the 9 occupation columns for both women and men
cols_2to18_f_1981 <- subset(f_1981, select = c(2,3,4,5,6,7,8,9,10))
cols_2to18_m_1981 <- subset(m_1981, select = c(2,3,4,5,6,7,8,9,10))

# Extraction of regions column
regions_1981 <- m_1981[,c(1)]

# Optional new region header for simplicity
colnames(regions_1981)[1]  <- "region" 

# Transpose the regions column so that it becomes a row
regions_1981_t <- as.data.frame(t(regions_1981))

# Transpose so that columns are regions and rows are occupations
f_1981_t <- as.data.frame(t(cols_2to18_f_1981))
m_1981_t <- as.data.frame(t(cols_2to18_m_1981)) 

# Merge the region row at the top of the transposed data frames
f_1981b <- rbind(regions_1981_t, f_1981_t)
m_1981b <- rbind(regions_1981_t, m_1981_t)

# Take the region row and turn it into the df header of the data frames
names(f_1981b) <- f_1981b[1,]
names(m_1981b) <- m_1981b[1,]

# Delete the superfluous region row
f_1981b <- f_1981b[-1,]
m_1981b <- m_1981b[-1,]

# Create a function that calculates the Duncan index by region  
calc_duncan_per_region <- function(x){ calc_duncan(f_1981b[,x], m_1981b[,x]) }

# Applying the above function for all regions of interest by looping over them 
duncan_per_region <- as.data.frame(sapply(names(m_1981b), calc_duncan_per_region))

# check that above worked with two examples
calc_duncan(f_1981b$Darlington, m_1981b$Darlington)
calc_duncan(f_1981b$Newport, m_1981b$Newport)

# Renaming the column of the unsorted data frame
colnames(duncan_per_region)[1]  <- "Duncan_index" 

duncan_per_region_1981 <- as.data.frame(duncan_per_region)

# sort Duncan index from low to high
duncan_per_region_sorted_1981 <- as.data.frame(duncan_per_region[order(duncan_per_region$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_region_sorted_1981)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_region_sorted_1981)

# see highest values, lowest gender equality 
tail(duncan_per_region_sorted_1981)

# Generating histogram data points
Duncan_Indices_per_region  <- duncan_per_region[order(duncan_per_region$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_region, 
     main="Histogram of Duncan Indices per region 1981",
     ylab="Frequency",
     xlab="Duncan Index",
     col="yellow",
     border="black", xlim=c(0,1), ylim=c(0,10))

# Exporting the Duncan indices as a csv
write.csv(duncan_per_region_sorted_1981, "C:\\Users\\sarab\\Desktop\\duncan_per_region_1981.csv", row.names=TRUE)



######################################################  DI by region 1971


######################################################  Sara's path

# Initial importation / read in of the two xlsx files, male and female, 1971, 16 and over
ini_f_1971 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_1971r.xlsx")
ini_m_1971 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_1971r.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_1971 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_1971r.xlsx")
m_1971 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_1971r.xlsx")


# Check column names are the same in both tables
all.equal(names(f_1971), names(m_1971))

# Extraction of the 9 occupation columns for both women and men
cols_2to27_f_1971 <- subset(f_1971, select = c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28))
cols_2to27_m_1971 <- subset(m_1971, select = c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28))

# Extraction of regions column
regions_1971 <- m_1971[,c(1)]

# Optional new region header for simplicity
colnames(regions_1971)[1]  <- "region" 

# Transpose the regions column so that it becomes a row
regions_1971_t <- as.data.frame(t(regions_1971))

# Transpose so that columns are regions and rows are occupations
f_1971_t <- as.data.frame(t(cols_2to27_f_1971))
m_1971_t <- as.data.frame(t(cols_2to27_m_1971)) 

# Merge the region row at the top of the transposed data frames
f_1971b <- rbind(regions_1971_t, f_1971_t)
m_1971b <- rbind(regions_1971_t, m_1971_t)

# Take the region row and turn it into the df header of the data frames
names(f_1971b) <- f_1971b[1,]
names(m_1971b) <- m_1971b[1,]

# Delete the superfluous region row
f_1971b <- f_1971b[-1,]
m_1971b <- m_1971b[-1,]

# Create a function that calculates the Duncan index by region  
calc_duncan_per_region <- function(x){ calc_duncan(f_1971b[,x], m_1971b[,x]) }

# Applying the above function for all regions of interest by looping over them 
duncan_per_region <- as.data.frame(sapply(names(m_1971b), calc_duncan_per_region))


# check that above worked with two examples
calc_duncan(f_1971b$East, m_1971b$East)
calc_duncan(f_1971b$`East Midlands`, m_1971b$`East Midlands`)

# Renaming the column of the unsorted data frame
colnames(duncan_per_region)[1]  <- "Duncan_index" 

duncan_per_region_1971 <- as.data.frame(duncan_per_region)

# sort Duncan index from low to high
duncan_per_region_sorted_1971 <- as.data.frame(duncan_per_region[order(duncan_per_region$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_region_sorted_1971)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_region_sorted_1971)

# see highest values, lowest gender equality 
tail(duncan_per_region_sorted_1971)

# Generating histogram data points
Duncan_Indices_per_region  <- duncan_per_region[order(duncan_per_region$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_region, 
     main="Histogram of Duncan Indices per region 1971",
     ylab="Frequency",
     xlab="Duncan Index",
     col="purple",
     border="black", xlim=c(0,1), ylim=c(0,10))

# Exporting the Duncan indices as a csv
write.csv(duncan_per_region_sorted_1971, "C:\\Users\\sarab\\Desktop\\duncan_per_region_1971.csv", row.names=TRUE)




######################################################  Spaghetti Plot DI by region through time

region = as.vector(regions_2021) 

# Adding Decade Column for each DI per region data frame
duncan_per_region_sorted_1971$Decade <- 1971
duncan_per_region_sorted_1981$Decade <- 1981
duncan_per_region_sorted_1991$Decade <- 1991
duncan_per_region_sorted_2001$Decade <- 2001
duncan_per_region_sorted_2011$Decade <- 2011
duncan_per_region_sorted_2021$Decade <- 2021

# Adding region Column to preserve original number of regions 
duncan_per_region_sorted_1971$region <- row.names(duncan_per_region_sorted_1971)
duncan_per_region_sorted_1981$region <- row.names(duncan_per_region_sorted_1981)
duncan_per_region_sorted_1991$region <- row.names(duncan_per_region_sorted_1991)
duncan_per_region_sorted_2001$region <- row.names(duncan_per_region_sorted_2001)
duncan_per_region_sorted_2011$region <- row.names(duncan_per_region_sorted_2011)
duncan_per_region_sorted_2021$region <- row.names(duncan_per_region_sorted_2021)

# Binding all four dfs into one for plotting
bind_1 <- rbind(duncan_per_region_sorted_1971, duncan_per_region_sorted_1981)
bind_2 <- rbind(duncan_per_region_sorted_1991, duncan_per_region_sorted_2001)
bind_3 <- rbind(duncan_per_region_sorted_2011, duncan_per_region_sorted_2021)
bind_4 <- rbind(bind_1, bind_2)
bind_5 <- rbind(bind_3, bind_4)
duncan_per_region_all_decades <- rbind(bind_4, bind_5)


## load ggplot2 package to make the graphs
require(ggplot2)

ggplot(duncan_per_region_all_decades, aes(x = Decade, y = Duncan_index, group = region, color = region)) + 
  geom_point() + 
  geom_line() + 
  stat_smooth(aes(group = 1)) +
  guides(color = guide_legend(override.aes = list(size = 10))) +
  scale_y_continuous(breaks=seq(0,1.0,0.05)) + 
  geom_text(data = subset(duncan_per_region_all_decades, Decade == "2021"), 
            aes(label = region, colour = region, x = Decade, y = Duncan_index), 
            hjust = 0.5,
            vjust = 1.0) +
  labs(title="Duncan Indices of regions in Function of Time", x = "Time", y = "Duncan Index")


h1 = cbind(duncan_per_region_1971[['Duncan_index']], duncan_per_region_1981[['Duncan_index']])
h2 = cbind(duncan_per_region_1991[['Duncan_index']], duncan_per_region_2001[['Duncan_index']])
h3 = cbind(duncan_per_region_2011[['Duncan_index']], duncan_per_region_2021[['Duncan_index']])
h4 = cbind(h1, h2)
Dis = t(cbind(h4, h3))



di_ridgeline = data.frame(
  
  Time = rep(c(1971,1981,1991,2001,2011,2021), 10),
  
  Regions = c(rep('East', 6), 
        rep('East Midlands', 6), 
        rep('London', 6), 
        rep('North East', 6), 
        rep('North West', 6), 
        rep('South East', 6), 
        rep('South West', 6), 
        rep('Wales', 6), 
        rep('West Midlands', 6), 
        rep('Yorkshire and the Humber', 6)),
  
  height = c(Dis[,0],
             Dis[,1],
             Dis[,2],
             Dis[,3],
             Dis[,4],
             Dis[,5],
             Dis[,6],
             Dis[,7],
             Dis[,8],
             Dis[,9],
             Dis[,10])     
)

ggplot(di_ridgeline, aes(x = Time, 
                         y = Regions,
                         height = height,
                         group = Regions, 
                         color = Regions,
                         fill = stat(x))) + 
  geom_density_ridges_gradient(stat = "identity", scale = 0.9, size = 0.7, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Census", option = "C") +
  labs(title = 'Distribution of Regional DIs for All Census')


ggplot(di_ridgeline, aes(x = height, y = Regions, group = Regions, color = Regions, fill = stat(x))) + 
  geom_density_ridges_gradient(scale = 0.9, size = 0.7, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "DI", option = "C") +
  labs(title = 'Distribution of Regional DIs for All Census')
  # geom_density_ridges2(scale = 0.9)


ggplot(di_ridgeline, aes(x = height, y = Regions, group = Regions, color = Regions, fill = stat(x))) + 
  scale_fill_viridis_c(name = "DI", option = "C") +
  geom_density_ridges_gradient(scale = 0.9, size = 0.7, rel_min_height = 0.01) +
  labs(title = 'Distribution of Regional DIs for All Census') +
  facet_wrap(~Regions)


#Ridgeline census
#####################################################################################

ggplot(di_ridgeline, aes(x = height, y = Time, group = Time, color = Time, fill = stat(x))) + 
  geom_density_ridges_gradient(scale = 0.9, size = 0.9, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "DI", option = "B") +
  labs(title = 'Distribution of Regional DIs for All Census')
# geom_density_ridges2(scale = 0.9)

       




#Geospatial Vectors
#####################################################################################



#Download some important packages
library(maps)
library(mapdata)
library(maptools)
library(rgdal)
library(ggmap)
library(ggplot2)
library(rgeos)
library(broom)
library(plyr)

#Load the shapefile - make sure you change the filepath to where you saved the shapefiles
shapefile <- readOGR(dsn="C:\\Users\\sarab\\Desktop\\shapefiles_december_2021")

#Reshape for ggplot2 using the Broom package
mapdata <- tidy(shapefile) #This might take a few minutes

#Check the shapefile has loaded correctly by plotting an outline map of the UK
gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

#Create some data to use in the heatmap - here we are creating a random "value" for each region (by id)
mydata <- data.frame(id=unique(mapdata$id), value=sample(c(0:100), length(unique(mapdata$id)), replace = TRUE))


Dis_wr <- rbind(regions_1971_t, Dis)
names(Dis_wr) <- Dis_wr[1,]

# Delete the superfluous region row
Dis_wr <- Dis_wr[-1,]


Dis_wr <- cbind(c(1971,1981,1991,2001,2011,2021), Dis_wr)
rownames(Dis_wr) <- Dis_wr[,1]

# Delete the superfluous region column
Dis_wr <- Dis_wr[,-1]

# Delete Wales
Dis_wr <- Dis_wr[,-8]

Dis_wr_t <- t(Dis_wr)

id = c(0:8)

Dis_1971 <- subset(Dis_wr_t, select = c(0,1))
Dis_1971 <- as.data.frame(Dis_1971)
Dis_1971['Region'] <- rownames(Dis_1971) 
Dis_1971 <- as.data.frame(Dis_1971[c(4,5,9,2,8,1,3,6,7),])
Dis_1971['id'] <- id
colnames(Dis_1971)[1]  <- "DI" 
Dis_1971$DI_numeric <- as.numeric(Dis_1971$DI)

Dis_1981 <- subset(Dis_wr_t, select = c(0,2))
Dis_1981 <- as.data.frame(Dis_1981)
Dis_1981['Region'] <- rownames(Dis_1981) 
Dis_1981 <- as.data.frame(Dis_1981[c(4,5,9,2,8,1,3,6,7),])
Dis_1981['id'] <- id
colnames(Dis_1981)[1]  <- "DI" 
Dis_1981$DI_numeric <- as.numeric(Dis_1981$DI)

Dis_1991 <- subset(Dis_wr_t, select = c(0,3))
Dis_1991 <- as.data.frame(Dis_1991)
Dis_1991['Region'] <- rownames(Dis_1991) 
Dis_1991 <- as.data.frame(Dis_1991[c(4,5,9,2,8,1,3,6,7),])
Dis_1991['id'] <- id
colnames(Dis_1991)[1]  <- "DI" 
Dis_1991$DI_numeric <- as.numeric(Dis_1991$DI)

Dis_2001 <- subset(Dis_wr_t, select = c(0,4))
Dis_2001 <- as.data.frame(Dis_2001)
Dis_2001['Region'] <- rownames(Dis_2001) 
Dis_2001 <- as.data.frame(Dis_2001[c(4,5,9,2,8,1,3,6,7),])
Dis_2001['id'] <- id
colnames(Dis_2001)[1]  <- "DI" 
Dis_2001$DI_numeric <- as.numeric(Dis_2001$DI)

Dis_2011 <- subset(Dis_wr_t, select = c(0,5))
Dis_2011 <- as.data.frame(Dis_2011)
Dis_2011['Region'] <- rownames(Dis_2011) 
Dis_2011 <- as.data.frame(Dis_2011[c(4,5,9,2,8,1,3,6,7),])
Dis_2011['id'] <- id
colnames(Dis_2011)[1]  <- "DI" 
Dis_2011$DI_numeric <- as.numeric(Dis_2011$DI)

Dis_2021 <- subset(Dis_wr_t, select = c(0,6))
Dis_2021 <- as.data.frame(Dis_2021)
Dis_2021['Region'] <- rownames(Dis_2021) 
Dis_2021 <- as.data.frame(Dis_2021[c(4,5,9,2,8,1,3,6,7),])
Dis_2021['id'] <- id
colnames(Dis_2021)[1]  <- "DI" 
Dis_2021$DI_numeric <- as.numeric(Dis_2021$DI)
  
#Join mydata with mapdata
df1971 <- join(mapdata, Dis_1971, by="id")
df1981 <- join(mapdata, Dis_1981, by="id")
df1991 <- join(mapdata, Dis_1991, by="id")
df2001 <- join(mapdata, Dis_2001, by="id")
df2011 <- join(mapdata, Dis_2011, by="id")
df2021 <- join(mapdata, Dis_2021, by="id")


#Create the heatmap using the ggplot2 package 1971
gg1971 <- ggplot() + geom_polygon(data = df1971, aes(x = long, y = lat, group = group, fill = DI_numeric), color = "#FFFFFF", size = 0.25)
gg1971 <- gg1971 + scale_fill_gradient2(low = "white", mid = "blue", high = "red", na.value = "white", guide = "colourbar", limits = c(0,1), name="Duncan Index")
gg1971 <- gg1971 + coord_fixed(1)
gg1971 <- gg1971 + theme_minimal()
gg1971 <- gg1971 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gg1971 <- gg1971 + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg1971 <- gg1971 + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
gg1971 <- gg1971 + ggtitle("Heatmap of Regional Duncan Indices in 1971")
print(gg1971)

#Create the heatmap using the ggplot2 package 1981
gg1981 <- ggplot() + geom_polygon(data = df1981, aes(x = long, y = lat, group = group, fill = DI_numeric), color = "#FFFFFF", size = 0.25)
gg1981 <- gg1981 + scale_fill_gradient2(low = "white", mid = "blue", high = "red", na.value = "white", guide = "colourbar", limits = c(0,1), name="Duncan Index")
gg1981 <- gg1981 + coord_fixed(1)
gg1981 <- gg1981 + theme_minimal()
gg1981 <- gg1981 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gg1981 <- gg1981 + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg1981 <- gg1981 + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
gg1981 <- gg1981 + ggtitle("Heatmap of Regional Duncan Indices in 1981")
print(gg1981)


#Create the heatmap using the ggplot2 package 1991
gg1991 <- ggplot() + geom_polygon(data = df1991, aes(x = long, y = lat, group = group, fill = DI_numeric), color = "#FFFFFF", size = 0.25)
gg1991 <- gg1991 + scale_fill_gradient2(low = "white", mid = "blue", high = "red", na.value = "white", guide = "colourbar", limits = c(0,1), name="Duncan Index")
gg1991 <- gg1991 + coord_fixed(1)
gg1991 <- gg1991 + theme_minimal()
gg1991 <- gg1991 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gg1991 <- gg1991 + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg1991 <- gg1991 + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
gg1991 <- gg1991 + ggtitle("Heatmap of Regional Duncan Indices in 1991")
print(gg1991)


#Create the heatmap using the ggplot2 package 2001
gg2001 <- ggplot() + geom_polygon(data = df2001, aes(x = long, y = lat, group = group, fill = DI_numeric), color = "#FFFFFF", size = 0.25)
gg2001 <- gg2001 + scale_fill_gradient2(low = "white", mid = "blue", high = "red", na.value = "white", guide = "colourbar", limits = c(0,1), name="Duncan Index")
gg2001 <- gg2001 + coord_fixed(1)
gg2001 <- gg2001 + theme_minimal()
gg2001 <- gg2001 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gg2001 <- gg2001 + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg2001 <- gg2001 + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
gg2001 <- gg2001 + ggtitle("Heatmap of Regional Duncan Indices in 2001")
print(gg2001)


#Create the heatmap using the ggplot2 package 2011
gg2011 <- ggplot() + geom_polygon(data = df2011, aes(x = long, y = lat, group = group, fill = DI_numeric), color = "#FFFFFF", size = 0.25)
gg2011 <- gg2011 + scale_fill_gradient2(low = "white", mid = "blue", high = "red", na.value = "white", guide = "colourbar", limits = c(0,1), name="Duncan Index")
gg2011 <- gg2011 + coord_fixed(1)
gg2011 <- gg2011 + theme_minimal()
gg2011 <- gg2011 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gg2011 <- gg2011 + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg2011 <- gg2011 + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
gg2011 <- gg2011 + ggtitle("Heatmap of Regional Duncan Indices in 2011")
print(gg2011)


#Create the heatmap using the ggplot2 package 2021
gg2021 <- ggplot() + geom_polygon(data = df2021, aes(x = long, y = lat, group = group, fill = DI_numeric), color = "#FFFFFF", size = 0.25)
gg2021 <- gg2021 + scale_fill_gradient2(low = "white", mid = "blue", high = "red", na.value = "white", guide = "colourbar", limits = c(0,1), name="Duncan Index")
gg2021 <- gg2021 + coord_fixed(1)
gg2021 <- gg2021 + theme_minimal()
gg2021 <- gg2021 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gg2021 <- gg2021 + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg2021 <- gg2021 + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
gg2021 <- gg2021 + ggtitle("Heatmap of Regional Duncan Indices in 2021")
print(gg2021)




########################################################################## Statistical Analysis


# Paired T-test


# Create a data frame with the given data
data <- data.frame(
  Region = c("London", "South East", "South West", "East", "North West", "East Midlands",
             "Yorkshire and the Humber", "West Midlands", "North East", "Wales"),
  Duncan_1971 = c(0.413626923, 0.468883729, 0.508587347, 0.518172692, 0.496083428, 0.523439607,
                  0.528091147, 0.485448137, 0.563114816, 0.550769032),
  Duncan_1981 = c(0.407206513, 0.508540661, 0.562850872, 0.495833465, 0.55483203, 0.441376697,
                  0.56250107, 0.554332465, 0.603561356, 0.567248928),
  Duncan_1991 = c(0.340567083, 0.394993194, 0.415318868, 0.399114905, 0.420364772, 0.393982657,
                  0.416609202, 0.434005999, 0.434042508, 0.417438585),
  Duncan_2001 = c(0.302613502, 0.367492914, 0.375499404, 0.383683604, 0.379347493, 0.382010347,
                  0.390046453, 0.397868559, 0.393781516, 0.370563759),
  Duncan_2011 = c(0.263619202, 0.345396628, 0.366145048, 0.37147275, 0.367830216, 0.372294408,
                  0.379665764, 0.376556603, 0.390946811, 0.382822188),
  Duncan_2021 = c(0.242887086, 0.308308057, 0.328245438, 0.329925147, 0.331330277, 0.335094172,
                  0.344373922, 0.345807788, 0.348282785, 0.354754775)
)



t.test(data$Duncan_1971,data$Duncan_2021, paired = TRUE)
t.test(data$Duncan_1981,data$Duncan_2021, paired = TRUE)
t.test(data$Duncan_1991,data$Duncan_2021, paired = TRUE)
t.test(data$Duncan_2001,data$Duncan_2021, paired = TRUE)
t.test(data$Duncan_2011,data$Duncan_2021, paired = TRUE)


t.test(data$Duncan_1971,data$Duncan_2011, paired = TRUE)
t.test(data$Duncan_1981,data$Duncan_2011, paired = TRUE)
t.test(data$Duncan_1991,data$Duncan_2011, paired = TRUE)
t.test(data$Duncan_2001,data$Duncan_2011, paired = TRUE)
t.test(data$Duncan_2021,data$Duncan_2011, paired = TRUE)


t.test(data$Duncan_1971,data$Duncan_2001, paired = TRUE)
t.test(data$Duncan_1981,data$Duncan_2001, paired = TRUE)
t.test(data$Duncan_1991,data$Duncan_2001, paired = TRUE)
t.test(data$Duncan_2011,data$Duncan_2001, paired = TRUE)
t.test(data$Duncan_2021,data$Duncan_2001, paired = TRUE)


t.test(data$Duncan_1971,data$Duncan_1991, paired = TRUE)
t.test(data$Duncan_1981,data$Duncan_1991, paired = TRUE)
t.test(data$Duncan_2001,data$Duncan_1991, paired = TRUE)
t.test(data$Duncan_2011,data$Duncan_1991, paired = TRUE)
t.test(data$Duncan_2021,data$Duncan_1991, paired = TRUE)


t.test(data$Duncan_1971,data$Duncan_1981, paired = TRUE)
t.test(data$Duncan_1991,data$Duncan_1981, paired = TRUE)
t.test(data$Duncan_2001,data$Duncan_1981, paired = TRUE)
t.test(data$Duncan_2011,data$Duncan_1981, paired = TRUE)
t.test(data$Duncan_2021,data$Duncan_1981, paired = TRUE)


t.test(data$Duncan_1981,data$Duncan_1971, paired = TRUE)
t.test(data$Duncan_1991,data$Duncan_1971, paired = TRUE)
t.test(data$Duncan_2001,data$Duncan_1971, paired = TRUE)
t.test(data$Duncan_2011,data$Duncan_1971, paired = TRUE)
t.test(data$Duncan_2021,data$Duncan_1971, paired = TRUE)


# Perform the Friedman test

data1 <- data.frame(
  Group_1971 = c(0.413626923, 0.468883729, 0.508587347, 0.518172692, 0.496083428, 0.523439607,
                 0.528091147, 0.485448137, 0.563114816, 0.550769032),
  Group_1981 = c(0.407206513, 0.508540661, 0.562850872, 0.495833465, 0.55483203, 0.441376697,
                 0.56250107, 0.554332465, 0.603561356, 0.567248928),
  Group_1991 = c(0.340567083, 0.394993194, 0.415318868, 0.399114905, 0.420364772, 0.393982657,
                 0.416609202, 0.434005999, 0.434042508, 0.417438585),
  Group_2001 = c(0.302613502, 0.367492914, 0.375499404, 0.383683604, 0.379347493, 0.382010347,
                 0.390046453, 0.397868559, 0.393781516, 0.370563759),
  Group_2011 = c(0.263619202, 0.345396628, 0.366145048, 0.37147275, 0.367830216, 0.372294408,
                 0.379665764, 0.376556603, 0.390946811, 0.382822188),
  Group_2021 = c(0.242887086, 0.308308057, 0.328245438, 0.329925147, 0.331330277, 0.335094172,
                 0.344373922, 0.345807788, 0.348282785, 0.354754775)
)

# Perform the Friedman test
friedman_result <- friedman.test(y = as.matrix(data1), groups = rep(1:6, each = 10), blocks = rep(1:10, times = 6))
# Print the Friedman test results
print(friedman_result)

# Check if the Friedman test is significant
if (friedman_result$p.value < 0.05) {
  # Perform pairwise Wilcoxon signed-rank tests for all group comparisons
  p_values <- matrix(NA, nrow = ncol(data), ncol = ncol(data1))
  
  for (i in 1:(ncol(data1) - 1)) {
    for (j in (i + 1):ncol(data1)) {
      p_value <- wilcox.test(data1[, i], data1[, j], paired = TRUE)$p.value
      p_values[i, j] <- p_value
    }
  }
  
  # Print the pairwise comparison results
  print(p_values)
} else {http://127.0.0.1:25477/graphics/plot_zoom_png?width=1274&height=865
  cat("Friedman test is not significant. No pairwise comparisons are performed.\n")
}


# ANOVA


summary(aov(data$Duncan_1971 ~ data$Duncan_2021))
summary(aov(data$Duncan_1981 ~ data$Duncan_2021))
summary(aov(data$Duncan_1991 ~ data$Duncan_2021))
summary(aov(data$Duncan_2001 ~ data$Duncan_2021))
summary(aov(data$Duncan_2011 ~ data$Duncan_2021))


summary(aov(data$Duncan_1971 ~ data$Duncan_2011))
summary(aov(data$Duncan_1981 ~ data$Duncan_2011))
summary(aov(data$Duncan_1991 ~ data$Duncan_2011))
summary(aov(data$Duncan_2001 ~ data$Duncan_2011))
summary(aov(data$Duncan_2021 ~ data$Duncan_2011))


summary(aov(data$Duncan_1971 ~ data$Duncan_2001))
summary(aov(data$Duncan_1981 ~ data$Duncan_2001))
summary(aov(data$Duncan_1991 ~ data$Duncan_2001))
summary(aov(data$Duncan_2011 ~ data$Duncan_2001))
summary(aov(data$Duncan_2021 ~ data$Duncan_2001))


summary(aov(data$Duncan_1971 ~ data$Duncan_1991))
summary(aov(data$Duncan_1981 ~ data$Duncan_1991))
summary(aov(data$Duncan_2001 ~ data$Duncan_1991))
summary(aov(data$Duncan_2011 ~ data$Duncan_1991))
summary(aov(data$Duncan_2021 ~ data$Duncan_1991))


summary(aov(data$Duncan_1971 ~ data$Duncan_1981))
summary(aov(data$Duncan_1991 ~ data$Duncan_1981))
summary(aov(data$Duncan_2001 ~ data$Duncan_1981))
summary(aov(data$Duncan_2011 ~ data$Duncan_1981))
summary(aov(data$Duncan_2021 ~ data$Duncan_1981))


summary(aov(data$Duncan_1981 ~ data$Duncan_1971))
summary(aov(data$Duncan_1991 ~ data$Duncan_1971))
summary(aov(data$Duncan_2001 ~ data$Duncan_1971))
summary(aov(data$Duncan_2011 ~ data$Duncan_1971))
summary(aov(data$Duncan_2021 ~ data$Duncan_1971))

