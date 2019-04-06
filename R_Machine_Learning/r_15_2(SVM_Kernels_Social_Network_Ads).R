# load Social Networks Ad dataset

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


# fitting Support Vector Classification on training_set

#install.packages("e1071")
library(e1071)


#######  linear kernel  ########


classifier = svm (Purchased ~ ., data = training_set,
                  type = "C-classification",
                  kernel = "linear")

# Pred test_set

y_pred = predict (classifier, newdata = test_set[-3])


#CM

library(caret)
confusionMatrix(test_set[,3], y_pred)  #mis-classification for Linear is 20


#Visualizing the Training set Results


library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('X', 'Y')

y_grid = predict(classifier, newdata = grid_set)  

plot(set[, -3],
     main = 'SV Classification Linear (training set)',
     xlab = 'X', ylab = 'Y',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))



########  Radial kernel  #####


classifier = svm (Purchased ~ ., data = training_set,
                  type = "C-classification",
                  kernel = "radial")

# Pred test_set

y_pred = predict (classifier, newdata = test_set[-3])


#CM

library(caret)
confusionMatrix(test_set[,3], y_pred)  #mis-classification for Radial is 10


#Visualizing the Training set Results


library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid = predict(classifier, newdata = grid_set)  

plot(set[, -3],
     main = 'S V Classification Radial (training set)',
     xlab = 'X', ylab = 'Y',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))



########  Sigmoid Kernel  #######


classifier = svm (Purchased ~ ., data = training_set,
                  type = "C-classification",
                  kernel = "sigmoid")

# Pred test_set

y_pred = predict (classifier, newdata = test_set[-3])


#CM

library(caret)
confusionMatrix(test_set[,3], y_pred)  #mis-classification for Sigmoid is 25


#Visualizing the Training set Results


library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid = predict(classifier, newdata = grid_set)  

plot(set[, -3],
     main = 'S V Classification Sigmoid (training set)',
     xlab = 'X', ylab = 'Y',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))


######  Polynomial Kernel  ######

classifier = svm (Purchased ~ ., data = training_set,
                  type = "C-classification",
                  kernel = "polynomial")

# Pred test_set

y_pred = predict (classifier, newdata = test_set[-3])


#CM

library(caret)
confusionMatrix(test_set[,3], y_pred)  #mis-classification for Polynomial is 22


#Visualizing the Training set Results


library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid = predict(classifier, newdata = grid_set)  

plot(set[, -3],
     main = 'S V Classification Polynomial (training set)',
     xlab = 'X', ylab = 'Y',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
