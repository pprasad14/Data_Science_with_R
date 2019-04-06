#load bank.csv dataset

dataset = read.csv("bank.csv", sep = ";", header = T)

dataset$y = factor(dataset$y, levels = c("no","yes"), labels = c(0,1))

# replace unknowns with max values

#education

table(dataset$education)
levels(dataset$education)[levels(dataset$education)== "unknown"]= "secondary" 
table(dataset$education)


#contact

table(dataset$contact)
levels(dataset$contact)[levels(dataset$contact)== "unknown"]= "cellular" 
table(dataset$contact)


#poutcome

#table(dataset$poutcome)
#levels(dataset$poutcome)[levels(dataset$outcome) =="unknown"]= "" 
#table(dataset$education)


#split data

library(caTools)

set.seed(123)

split = sample.split(dataset$y, .8)
table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)

summary(dataset)



# Making Multiple Linear Regression (MLR) Model

#regressor = lm(y ~., data = training_set)  # use '.' to consider all variables


regressor = lm(y ~ age + balance + duration + campaign 
               + pdays + previous,
               data = training_set)  

summary(regressor)

