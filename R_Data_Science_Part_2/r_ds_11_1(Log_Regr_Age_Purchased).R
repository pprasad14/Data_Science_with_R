# Set as Working directory and Load Social Network dataset

dataset = read.csv("Social_Network_Ads.csv")

# Remove User.ID and Gender as its not important
dataset = dataset[3:5]

# make Purchased column as a factor from being numeric

dataset$Purchased = factor(dataset$Purchased,
                           levels = c(0,1))  # or: dataset$Purchased = as.factor(dataset$Purchased)

#split data

library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, .75)
table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)


#Feature Scaling

summary(training_set)

training_set[-3] = scale(training_set[-3])  # to scale all columns but 3rd column in training_set

summary(training_set)  #note the change in summary info

test_set[-3] = scale(test_set[-3])  # to scale all columns but 3rd column in test_set


# Fitting Logistic Regression Model

classifier = glm(Purchased ~ ., data = training_set,
                 family = "binomial")

summary(classifier)


# Predictions

prob_pred = predict(classifier, newdata = test_set[-3],
                    type = "response")

head(prob_pred)

range(prob_pred)

y_pred = ifelse(prob_pred>0.5, 1, 0)

head(y_pred,20)


# confusion matrix

cm = table(Actual = test_set[,3], Predicted = y_pred)
cm    # (57 + 26)/100 = 0.83 is accuracy of model


#####  ***
#install.packages("caret")
library(caret)

confusionMatrix(test_set[,3], y_pred)


##

#install.packages("MLmetrics")
library(MLmetrics)

ConfusionMatrix(test_set[,3], y_pred) # **

Accuracy(test_set[,3], y_pred)

#Visualizing the Training set Results

#install.packages("ElemStatLearn")

library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01) #setting x1 axis limits (min and max)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01) #setting x2 axis limits (min and max)

grid_set = expand.grid(X1, X2) # to make a matrix like structure from x1 and x2 sequences

colnames(grid_set) = c('Age', 'EstimatedSalary')

prob_set = predict(classifier, type = 'response', newdata = grid_set)

y_grid = ifelse(prob_set > 0.5, 1, 0)

plot(set[, -3],
     main = 'Logistic Regression (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)  #make a line

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))



#Visualizing the Test set Results


library(ElemStatLearn)

set = test_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

prob_set = predict(classifier, type = 'response', newdata = grid_set)

y_grid = ifelse(prob_set > 0.5, 1, 0)

plot(set[, -3],
     main = 'Logistic Regression (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

