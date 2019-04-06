# Import Dataset

dataset = read.csv("Data.csv")

# Replacing Missing data with average (ave), without using packages
table(dataset$Age)

dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm=T)), #if part
                     dataset$Age)  #else part

dataset$Salary = ifelse(is.na(dataset$Salary),
                     ave(dataset$Salary, FUN = function(x) mean(x, na.rm=T)), #if part
                     dataset$Salary)  #else part



# Encoding categorical data

#change Yes and No to 1 and 0 respectively

table(dataset$Purchased)
dataset$Purchased = factor(dataset$Purchased,
                           levels = c('Yes','No'),
                           labels = c(1,0))
table(dataset$Purchased)

# changing country column

dataset$Country = factor(dataset$Country,
                           levels = c('France','Spain','Germany'),
                           labels = c(0,1,2))


# Splitting Data into Train and Test
#install caTools
#install.packages("caTools")

library(caTools)
set.seed(123)

split = sample.split(dataset$Purchased, SplitRatio = 0.8)  
split
table(split) #to see no. of Trues and Falses

training_set =  subset(dataset, split == T) #make all T's of split to be training dataset
test_set = subset(dataset, split == F) #make all F's of split to be testing dataset


# train and test for Boston Dataset
library(MASS)
dataset(Boston)

# ***
split = sample.split(Boston$medv,SplitRatio = 0.8)

table(split)

training_set = subset(Boston,split==T)

test_set = subset(Boston,split==F)
