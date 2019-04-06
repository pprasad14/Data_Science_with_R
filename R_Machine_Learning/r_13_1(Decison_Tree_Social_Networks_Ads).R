# load Social Network

dataset = read.csv("Social_Network_Ads.csv")

#remove ID
 
dataset = dataset[3:5]

#make numerical to factor

dataset$Purchased = factor(dataset$Purchased, levels = c(0,1))

library(caTools)

set.seed(123)

split = sample.split(dataset$Purchased, 0.75)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)

# feature scaling

training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])


#fitting decision tree classification

#install.packages("rpart")
library(rpart)
set.seed(123)

classifier = rpart(formula = Purchased ~ ., data = training_set)



# predictin test_set results

y_pred = predict(classifier, newdata = test_set[-3]) # gives probabilities

y_pred = predict(classifier, newdata = test_set[-3],
                 type = "class")
head(y_pred)


#Confusion Matrix

library(caret)
confusionMatrix(test_set[,3], y_pred)


#Visualizing the Training set Results


library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid = predict(classifier, type = 'class', newdata = grid_set)  # take away 'type =' ?

plot(set[, -3],
     main = 'Decision Tree (training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# do the above for test set also



# Plot tree

plot(classifier, margin = 0.1)
text(classifier)


# install rpart.plot

#install.packages("rpart.plot")

library(rpart.plot)

rpart.plot(classifier, type = 3, digits = 3, fallen.leaves = T,
           cex = 0.6)
