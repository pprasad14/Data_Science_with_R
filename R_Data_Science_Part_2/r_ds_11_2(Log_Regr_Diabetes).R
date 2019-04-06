# Set as Working directory and Load diabetes dataset

dataset = read.csv("diabetes.csv")


dataset$Outcome = factor(dataset$Outcome,
                           levels = c(0,1))

#split data

library(caTools)

set.seed(123)

split = sample.split(dataset$Outcome, .8)
table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)


#Feature Scaling; not necessary here since values are all very small. 
#Difference in model will be small with feature scaling

summary(training_set)

training_set[-9] = scale(training_set[-9])  # to scale all columns but 9th column in training_set

summary(training_set)  #note the change in summary info

test_set[-9] = scale(test_set[-9])  # to scale all columns but 9th column in test_set


# Fitting Logistic Regression Model

classifier = glm(Outcome ~ ., data = training_set,
                 family = "binomial")

summary(classifier)


# Predictions   ******

prob_pred = predict(classifier, newdata = test_set[-9],
                    type = "response")

y_pred = ifelse(prob_pred > 0.5, 1, 0)


#******


#Confusion Matrix
cm = table(Actual = test_set[,9], Predicted = y_pred)
cm    

library(MLmetrics)

ConfusionMatrix(test_set[,9], y_pred) # **

Accuracy(test_set[,9], y_pred)



## Dimension Reduction by Backward Elimination

classifier1 = glm(Outcome ~ ., data = training_set,
                 family = "binomial")

summary(classifier1)

#AIC should decrease with no increase in Residual deviance


#max P value is of SkinThickness, so remove

classifier2 = glm(Outcome ~ . -SkinThickness, data = training_set,
                  family = "binomial")

summary(classifier2)


#remvoe age

classifier3 = glm(Outcome ~ . -SkinThickness -Age, data = training_set,
                  family = "binomial")

summary(classifier3)

# make classifier2 as final model since a big increase in Residual for small decrease in AIC



#Predictions

prob_pred = predict(classifier2, newdata = test_set,
                    type = "response")
y_pred2 = ifelse(prob_pred > 0.5 , 1, 0)


#confusion matrix

library(MLmetrics)

ConfusionMatrix(test_set$Outcome, y_pred2) 

Accuracy(test_set$Outcome, y_pred2)

# note the change in percentage of accuracy 



######

#step(classifier1, direction = "backward")  # here age is removed, but shouldn't
#takes into consideration only AIC, not Residual Deviance

######
# setting threshold
# We can do trial  and error method by changing various threshold
# Another way is to use ROC curve



# ROC
# we will predict from training data
# classifier2 is our final model

result = predict(classifier2, newdata = training_set,
                 type = "response")

# need package ROCR package

#install.packages("ROCR")
library(ROCR)

# Prediction and Performance will be used to plot the graph

Pred = prediction(result, training_set$Outcome)

Perf = performance(Pred, "tpr", "fpr")

plot(Perf, colorize = T,
     print.cutoffs.at = seq(0,1, by = 0.1))  # can select any 'by' value for points on graph


# 0.2 has more TPr and also more FPR
# 0.3 has good TPR and less FPR
# hence, we set threshold at 0.3 in testing dataset

library(caret)
prob_pred = predict(classifier2, newdata = test_set,
                    type = "response")

y_pred3 = ifelse(prob_pred > 0.3, 1, 0)

# now see Confusion Matrix again

confusionMatrix(test_set$Outcome, y_pred3)  #note a decrease in False Positives, from 14 to 10


# Area under Curve

#install.packages("InformationValue") #to find area under Curve (AOC)
library(InformationValue) 

plotROC(actuals = training_set$Outcome,
        predictedScores = as.numeric(fitted(classifier2)))
