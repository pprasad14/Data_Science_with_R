# Churn_Modelling dataset

dataset = read.csv("Churn_Modelling.csv")

#remove 1:3 cols since not required

dataset = dataset[,-(1:3)]


#encode categorical variables to factor 1,2,3, and then convert to numeric 
#because later we will have to convert to numeric matrix, so it does not convert to character matrix

dataset$Geography = as.numeric(factor(dataset$Geography,
                           levels = c("France","Spain","Germany"),
                           labels = c(1,2,3)))

dataset$Gender = as.numeric(factor(dataset$Gender,
                                      levels = c("Female","Male"),
                                      labels = c(1,2)))

#splitting

library(caTools)

split = sample.split(dataset$Exited, 0.8)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


#Fit XGBoost to training set

#install.packages("xgboost")

library(xgboost)

#when working with xgboost, we should remove dependent variable from training_set
classifier = xgboost(data = as.matrix(training_set[-11]),
                     label = training_set$Exited,
                     nrounds = 10)  #max no of iterations
#notice the reduction in rmse values. this is a classification problem, but since converted
#to matrix, internally it works as a regression problem


#Prediction

pred = predict(classifier, newdata = as.matrix(test_set[-11]))

pred = (pred >=0.5)
head(pred)
table(pred)

# CM

cm = table(test_set[,11], pred)
cm

#mis-classification rate:

1 - sum(diag(cm))/sum(cm)


# k - fold cross validation 

library(caret)

set.seed(123)

folds = createFolds(training_set$Exited, k = 10)


# Train SVM model on training_set

cv = lapply(folds, function(x){
  training_fold = training_set[-x,]
  test_fold = training_set[x,]
  
  classifier = xgboost(data = as.matrix(training_fold[-11]),
                       label = training_fold$Exited,
                       nrounds = 10)
  
  pred = predict(classifier, newdata = as.matrix(test_fold[,-11]))
  
  pred = (pred>=0.5)
  
  cm = table(test_fold[,11],pred)
  
  accuracy = (cm[1,1]+cm[2,2]) / (cm[1,1] + cm[1,2] + cm[2,1] + cm[2,2])
  
  return(accuracy)
})


accuracy = mean(as.numeric(cv)) #cv is of list class, so convert to numeric to find mean
accuracy

cv  # shows the accuracy for each fold


