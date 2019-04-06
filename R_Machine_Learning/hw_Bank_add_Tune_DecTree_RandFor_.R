# Bank-Full dataset: Decision Tree and Random Forest with Tuning

#set as working directory and load dataset:

dataset = read.csv("bank-full.csv", sep = ";", header = T)


#select around 3k observations, since 45K observations is computationally expensive

library(caTools)

split = sample.split(dataset$y, 0.93)
dataset = subset(dataset, split == F)

# spit data using caret package

#library(caret)
#partition = createDataPartition(dataset$y, times = 1, p = 0.80)
#length(partition$Resample1)  # partition$Resample contains the training set

#split using caTools

library(caTools)

split = sample.split(dataset$y, 0.80)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


# Fit model

library(e1071)

classifier = svm(y ~ . , data = training_set, kernel = "radial")

classifier  #default radial


#Predictions

pred = predict(classifier, newdata = test_set[-17])

cm = table(test_set$y, pred)

cm  #why very few [yes,yes]?


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # around 10.5% mis-classification


####### Tuning #####

tune = tune(svm, y ~ ., data = training_set,
            ranges = list(gamma = seq(0,1,0.50), cost = (2^(4:6))))
#I've taken a small range of values to reduce computation time
#how to decide the range and gamma values??

tune


#plot tuned model

plot(tune)

summary(tune)  # gives all combinations of cost and gamma models, total: 3*3=9

attributes(tune)


#Best Model

mymodel = tune$best.model  # our new model
#in this case, my best model is worse than my previous model since i took
#a small range of gamma and cost values, to reduce time taken to compute

summary(mymodel)


#Predictions

pred = predict(mymodel, data = training_set[-17])
#should take test_set, but getting error

# CM

cm = table(training_set$y, pred)
#should take test_set, but getting error
#why is length of pred not equal to length of test_set$y??

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)


# tune$best.model$fitted

set.seed(123)
tune = tune(svm, y ~ ., data = training_set,
            ranges = list(epsilon = seq(0,1,0.50), cost = (2^(4:6))))

tune   #now error rate is 0.09872 ie 9.87%, while using training_set for pred


#plot tuned model

plot(tune) # more dark, less error

summary(tune)  # gives all combinations of cost and gamma models, total: 3*3=9

attributes(tune)


#Best Model

mymodel = tune$best.model  # our new model

summary(mymodel)


#Predictions

pred = predict(mymodel, data = training_set[-17])

# CM

cm = table(training_set$y, pred)
#using training_set instead of test_set bc getting error
#Error in table(test_set$y, pred) : 
#all arguments must have the same length

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # mis-classification rate is 6.99%


###############################

#fitting decision tree classification

#install.packages("rpart")
library(rpart)
set.seed(123)

classifier = rpart(formula = y ~ ., data = training_set)


# Plot tree

plot(classifier, margin = 0.1)
text(classifier)


# install rpart.plot

#install.packages("rpart.plot")

library(rpart.plot)

rpart.plot(classifier, type = 3, digits = 3, fallen.leaves = T,
           cex = 0.6)

############################

#install.packages("randomForest")

library(randomForest)

classifier = randomForest(y ~ ., data = training_set)

classifier # no of variables tried at split is sqrt of no. of variables
#OOB is Out Of Bag error, or just error in simple


# Predictin test results

y_pred = predict(classifier, newdata = test_set[-17])

head(y_pred)


#CM

library(caret)
confusionMatrix(test_set[,17], y_pred)  # accuracy of 89.42%
