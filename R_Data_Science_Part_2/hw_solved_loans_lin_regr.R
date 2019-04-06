dataset = read.csv("loans.csv")

#remove account since it is unique variable

dataset$Ac_No = NULL  # or dataset = dataset[,-1]

# renaming losses.in.thousands

names(dataset)[6] = 'y'


#install.packages("mosaic")

library(mosaic)

#looking for data distribution and missing values

inspect(dataset)
inspect(dataset, is.factor)


#

plot(dataset)

boxplot(dataset$y)

points(mean(dataset$y))


#spit

library(caTools)

set.seed(123)

split = sample.split(dataset$y, 0.8)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


#check correlation

cor(dataset)  #wont happen since it contains non-numeric values

View(cor(training_set[,c(1,2,3,6)]))


# Modelling

#univariate analysis

mod = lm(y ~ ., data = training_set)
summary(mod)

mod = lm(y ~ Age, data = training_set)
summary(mod)

mod = lm(y ~ Years.of.Experience, data = training_set)
summary(mod)

mod = lm(y ~ Gender, data = training_set)
summary(mod)

mod = lm(y ~ Married, data = training_set)
summary(mod)

mod = lm(y ~ Number.of.Vehicles, data = training_set)
summary(mod)


# final model

mod = lm(y ~ ., data = training_set)
summary(mod)

attributes(mod) # names(mod)

mod$coefficients


#remove number of vehicles

mod = lm(y ~. - Number.of.Vehicles, data = training_set)
summary(mod) 

mod2 = lm(y ~. - Number.of.Vehicles - Years.of.Experience, 
         data = training_set)
summary(mod2) 


#Predictions

y_pred = predict(mod2, newdata = test_set)

#RMSE

library(Metrics)

rmse(test_set$y, y_pred)
