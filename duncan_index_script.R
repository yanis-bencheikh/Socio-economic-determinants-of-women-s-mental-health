
library(tidyverse)
library(readxl)

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


# Initial importation / read in of the two xlsx files, male and female, 2011, 16 and over 
ini_f_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2011.xlsx")
ini_m_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2011.xlsx")

# Read in of the two same two xlsx files for calculation of the Duncan Index
f_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\f_2011.xlsx")
m_2011 <- read_xlsx("C:\\Users\\sarab\\Desktop\\m_2011.xlsx")

# Check column names are the same in both tables
all.equal(names(f_2011), names(m_2011))

# Extraction of the 9 occupation columns for both women and men
cols_1to9_f_2011 <- subset(f_2011, select = c(3,4,5,6,7,8,9,10,11))
cols_1to9_m_2011 <- subset(m_2011, select = c(3,4,5,6,7,8,9,10,11))

# Extraction of counties column
counties_2011 <- m_2011[,c(1)]

# Optional new county header for simplicity
colnames(counties_2011)[1]  <- "County" 

# Transpose the counties column so that it becomes a row
counties_2011_t <- as.data.frame(t(counties_2011))

# Transpose so that columns are counties and rows are occupations
f_2011_t <- as.data.frame(t(cols_1to9_f_2011))
m_2011_t <- as.data.frame(t(cols_1to9_m_2011)) 

# Merge the county row at the top of the transposed data frames
f_2011b <- rbind(counties_2011_t, f_2011_t)
m_2011b <- rbind(counties_2011_t, m_2011_t)

# Take the county row and turn it into the df header of the data frames
names(f_2011b) <- f_2011b[1,]
names(m_2011b) <- m_2011b[1,]

# Delete the superfluous county row
f_2011b <- f_2011b[-1,]
m_2011b <- m_2011b[-1,]

# Create a function that calculates the Duncan index by county  
calc_duncan_per_county <- function(x){ calc_duncan(f_2011b[,x], m_2011b[,x]) }

# Applying the above function for all counties of interest by looping over them 
duncan_per_county <- as.data.frame(sapply(names(m_2011b), calc_duncan_per_county))

# check that above worked with two examples
calc_duncan(f_2011b$Darlington, m_2011b$Darlington)
calc_duncan(f_2011b$Newport, m_2011b$Newport)

# Renaming the column of the unsorted data frame
colnames(duncan_per_county)[1]  <- "Duncan_index" 

# sort Duncan index from low to high
duncan_per_county_sorted <- as.data.frame(duncan_per_county[order(duncan_per_county$Duncan_index),, drop = FALSE])

# Renaming the column of the sorted data frame
colnames(duncan_per_county_sorted)[1]  <- "Duncan_index" 

# see lowest values, greatest gender equality
head(duncan_per_county_sorted)

# see highest values, lowest gender equality 
tail(duncan_per_county_sorted)

# Generating histogram data points
Duncan_Indices_per_County  <- duncan_per_county[order(duncan_per_county$Duncan_index),]

# plot histogram 
hist(Duncan_Indices_per_County, 
     main="Histogram of Duncan Indices per County",
     ylab="Frequency",
     xlab="Duncan Index",
     col="pink",
     border="black")

# Exporting the Duncan indices as a csv
write.csv(duncan_per_county_sorted, "C:\\Users\\sarab\\Desktop\\duncan_per_county_2011.csv", row.names=TRUE)