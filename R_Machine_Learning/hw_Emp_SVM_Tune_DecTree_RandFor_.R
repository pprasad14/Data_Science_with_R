# Emp dataset : Decision Tree, Random Forest using SVM and tuning

dataset = read.csv("Emp.csv")

#select around 3k observations, since 32K observations is computationally expensive

library(caTools)

set.seed(123)
split = sample.split(dataset$Emp_Sal, 0.90)

dataset = subset(dataset, split == F)

#changin Emp_Sal to 'High' or 'Low'

dataset$Emp_Sal = factor(dataset$Emp_Sal, labels = c("Low","High"))


# spit data using caret package

#library(caret)
#partition = createDataPartition(dataset$y, times = 1, p = 0.80)
#length(partition$Resample1)  # partition$Resample contains the training set

#split using caTools

library(caTools)

split = sample.split(dataset$Emp_Sal, 0.80)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


# Fit model

library(e1071)

classifier = svm(Emp_Sal ~ . , data = training_set, kernel = "radial")

classifier  #default radial

#Predictions

pred = predict(classifier, newdata = test_set)

cm = table(test_set$Emp_Sal, pred)

cm 

# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # around 15.5% mis-classification


#Tuning

tune = tune(svm, Emp_Sal ~ ., data = training_set,
            ranges = list(gamma = seq(0,1,0.25), cost = (2^(3:7))))

tune  # best is 0.17 with gamma: 0.25 and cost:8


#plot tuned model

plot(tune)

summary(tune)  # gives all combinations of cost and gamma models, total: 5*5=25

attributes(tune)


#Best Model

mymodel = tune$best.model  # our new model

summary(mymodel)


#Predictions

pred = predict(mymodel, data = training_set)
#should take test_set, but getting error

# CM

cm = table(training_set$Emp_Sal, pred)
#should take test_set, but getting error
#why is length of pred not equal to length of test_set$Emp_Sal??

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm) #mis-classification rate is 2.49 % 


# tune$best.model$fitted

set.seed(123)
tune = tune(svm, Emp_Sal ~ ., data = training_set,
            ranges = list(epsilon = seq(0,0.5,0.05), cost = (2^(3:7))))

tune   #now best is 0.14 from 0.17 with epsilon:0 and cost:8, while using training_set for pred


#plot tuned model

plot(tune) # more dark, less error

summary(tune)  # gives all combinations of cost and gamma models, total: 11*5=55

attributes(tune)


#Best Model

mymodel = tune$best.model  # our new model

summary(mymodel)


#Predictions

pred = predict(mymodel, data = training_set[,-15])

# CM

cm = table(training_set$Emp_Sal, pred)
#using training_set instead of test_set bc getting error
#Error in table(test_set$y, pred) : 
#all arguments must have the same length

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # mis-classification rate is 13.58 %


###############################

#fitting decision tree classification

#install.packages("rpart")
library(rpart)
set.seed(123)

classifier = rpart(formula = Emp_Sal ~ ., data = training_set)


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

classifier = randomForest(Emp_Sal ~ ., data = training_set)

classifier # no of variables tried at split is sqrt of no. of variables
#OOB is Out Of Bag error, or just error in simple


# Predictin test results

y_pred = predict(classifier, newdata = test_set[-15])

head(y_pred)


#CM

library(caret)
confusionMatrix(test_set[,15], y_pred)  # accuracy of 82.49%


