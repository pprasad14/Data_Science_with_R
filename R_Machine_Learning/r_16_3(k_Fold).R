# load Social Networks Ads dataset

dataset = read.csv("social_network_ads.csv")

dataset = dataset[3:5]

#make Purchased to factor from numeric

dataset$Purchased = as.factor(dataset$Purchased)


# split data to train and test set

library(caTools)

set.seed(123)

split = sample.split(dataset$Purchased, 0.75)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)



# scaling       

training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

  
# Apply SVM

library(e1071)

classifier = svm(Purchased ~ ., data =  training_set, type = "class") #error

#Predictions

pred = predict(classifier, newdata = test_set)

# CM

cm = table(test_set$Purchased, pred)
cm

1 - sum(diag(cm)) / sum(cm)
#####

# apply k fold cross validation

library(caret)

set.seed(123)

folds = createFolds(training_set$Purchased, k = 10)

folds

# Train SVM model on training_set

cv = lapply(folds, function(x){
  training_fold = training_set[-x,]
  test_fold = training_set[x,]
  
  classifier = svm(Purchased ~ . , 
                   data = training_fold,
                   type = "C-classification",
                   kernel = "radial")
  
  pred = predict(classifier, newdata = test_fold[,-3])
  
  cm = table(test_fold[,3],pred)
  
  accuracy = (cm[1,1]+cm[2,2]) / (cm[1,1] + cm[1,2] + cm[2,1] + cm[2,2])
  
  return(accuracy)
})


cv # will give 10 accuracies

#convert cv to numeric

accuracy = mean(as.numeric(cv))
accuracy



########

#Grid search

library(caret)

set.seed(123)

classifier = train(Purchased ~ . , data = training_set,
                   method = 'svmRadial')

classifier

classifier$bestTune


######## 



classifier = svm(Purchased ~ ., data =  training_set, 
                 type = "C-classification",
                 kernel = "radial",
                 cost = 1,
                 sigma = 1.2) 

#Predictions

pred = predict(classifier, newdata = test_set)

# CM

cm = table(test_set$Purchased, pred)
cm

1 - sum(diag(cm)) / sum(cm)  # to see error in model


