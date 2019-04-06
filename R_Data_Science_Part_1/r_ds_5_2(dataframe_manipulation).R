# Method 1: Enter data manually

df = data.frame(ID = 1:8, 
                Names = c('A','B','C','D','E','F','G','H'),
                P = c(0,1,1,1,1,0,0,1))
df


# Method 2:  seq of numbers, letters, months, random  numbers

df2 = data.frame(a = seq(1,20,2),
       b = LETTERS[1:10],
       c = month.abb[1:10],
       f = sample(10:18, 10, replace = T),
       z = letters[1:10])

df2  #we get diffent 'f' everytime

#use seed() to get same 'f'

set.seed(123)
df2 = data.frame(a = seq(1,20,2),
                 b = LETTERS[1:10],
                 c = month.abb[1:10],
                 f = sample(10:18, 10, replace = T),
                 z = letters[1:10])

df2  #now, 'f' will be same always

# Method 3: Create numeric grouping variable

df3 = data.frame(X = sample(1:5, 15, replace = T))
df3

# Data Exploration

set.seed(123)

data = data.frame(A = sample(1:10, 100, replace = T),
                  B = sample(1:20, 100, replace = T),
                  C = sample(1:5, 100, replace = T),
                  D = sample(1:15, 100, replace = T))
head(data)


# Calculate basic descriptive statistics

summary(data)

# Calculate summary of particular column

summary(data[2]) #by column position
summary(data$B)  #by column name

# List name of variables in a dataset

names(data)

# calc no. of rows in dataset

nrow(data)

# calc no. of columns in dataset

ncol(data)

#structure of dataset

str(data)

# select random rows

# install diplyr package

#installed.packages("dplyr")
library(dplyr)

sample_n(data,10)

# select n% of rows

sample_frac(data,0.2) #get 20% of rows
nrow(sample_frac(data,0.2)) #to get the no. of rows for above code


# calc no. of missing values in each column

colSums(is.na(data))

#using apply function

sapply(data, function(x)sum(is.na(x)))

#no. of missing values in a single variable

sum(is.na(data$D))

####



# Replacing or Recoding the values

# "recoding" means replacing existing values with new values

set.seed(123)
data = data.frame(City = ifelse(sign(rnorm(30))==-1, "Mumbai", "Surat"),
                  X = sample(1:30))
data
str(data)

# Replace 1 with 6 in X variable

data$X[data$X==1]=6
data

# Replace Surat with Vashi
# to replace, we have to convert factor into character

data$City= as.character(data$City)
str(data)  # to see the change in factor to character

data$City[data$City=='Surat']='Vashi'  #to make the replacement
str(data)


# replace 2 and 3 with NA's

data$X[data$X==2|data$X ==3]= 'NA'
data
table(data$X)


####

# install packages("car")

#install.packages("car")
library(car)

# recode 1 to 6

data$X = recode(data$X, "1 = 6")


# recode a given range

#recode 1 : 4 to 0 and 5 : 8 to 1

data$X = recode(data$X, "1:4 = 0; 5:8 = 1")
data

#use ifelse stmt

dash = data.frame(A = c(rep(1:10)), B = letters[1:10])
dash

dash$T = ifelse(dash$A > 6 , 2 , 1)
dash


# And condition, if A > 2 and B is c, then 2, else 1

dash$R = ifelse(dash$A > 2 & dash$B == "c", 2,1)
dash


# nested ifelse 

dash$W = ifelse(dash$A>=1 & dash$A<=4,1,
                ifelse(dash$A>=5 & dash$A<=7,2,3))
dash

# renamin X to F
# format: rename(dataset, new = old)
data = rename(data, F = X)
colnames(data) # will get "City" "F"


# Keep and Drop variables

library(MASS)
data("Boston")

hexa = Boston

# keep 1st 3 variables

mydata1 = hexa[1:3] # for one range

mydata2 = hexa[c(1,3:5,6:10,13)] # for multiple selections


# Subset i.e selecting observations

newdata = data[1:10,]

#selecting values where X = 4

subset(data, X ==4)


# AND 

subset(data, City == "Mumbai" & X==27)

# OR

subset(data, City == "Mumbai" | X==11)
data

# Missing data

subset(data, is.na(X)) #print rows with NA
subset(data, !is.na(X))  #print rows that dont have NA


#Sorting

x = sample(1:50)
x

x = sort(x, decreasing = T)
x


# sort data frame

data

data.sort = data[order(data$City),]
data.sort

# sort city in ascending and X in descending

data.sort2= data[order(data$City, -data$X),]
data.sort2


# Value labelling

data$City = factor(data$City, levels = c("Mumbai","Surat"),
                   labels = c("Mah","Guj"))
levels(data$City)
data

#missing data

colSums(is.na(data))
rowSums(is.na(data))

# list rows of data that have missing data

data[!complete.cases(data),]
mydata = na.omit(data)
mydata


# removing duplicates

data = read.table(text = "
  D E F
  6 5 0
  6 3 NA
  6 1 5
  6 1 5
  8 5 3
  1 NA 1  
  8 7 2
  2 0 2
  2 0 2", header = T)

mydata = unique(data)
mydata

# remove duplicates from E column

mydata3 = subset(data, !duplicated(data[,'E']))
mydata3
