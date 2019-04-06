# load social networks ads dataset

dataset = read.csv("Social_Network_Ads.csv")

dataset = dataset[3:5]  #since first two cols not required

#convert last row to factor

dataset$Purchased = as.factor(dataset$Purchased)

summary(dataset)


colSums(is.na(dataset))  # no missing values

#train and test

library(caTools)

set.seed(123)

split = sample.split(dataset$Purchased, 0.75)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)

# scaling

dataset[-3] = scale(dataset[-3])  # if [-3] not there, then error since cant scale factors


#install.packages("randomForest")

library(randomForest)

classifier = randomForest(Purchased ~ ., data = training_set)

classifier # no of variables tried at split is sqrt of no. of variables
#OOB is Out Of Bag error, or just error in simple


# Predictin test results

y_pred = predict(classifier, newdata = test_set[-3])

head(y_pred)


#CM

library(caret)
confusionMatrix(test_set[,3], y_pred)



#Visualizing the Training set Results


library(ElemStatLearn)

set = training_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid = predict(classifier, newdata = grid_set)

plot(set[, -3],
     main = 'Random Forest (training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))


#Visualizing the Test set Results


library(ElemStatLearn)

set = test_set

X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)

colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid = predict(classifier, newdata = grid_set)

plot(set[, -3],
     main = 'Random Forest (test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

