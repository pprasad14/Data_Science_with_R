#install.packages("ISLR")

library(ISLR)

data("Carseats")

head(Carseats)


#Split

library(caTools)

split = sample.split(Carseats$Sales, 0.5)

training_set = subset(Carseats, split == T)
test_set = subset(Carseats, split ==F)


#fit decision tree

library(tree)

regressor = tree(Sales ~., data = training_set)
pred1 = predict(regressor, newdata = test_set)

library(MLmetrics)

#rmse
rmse(test_set$Sales, pred1)

#MSE
mean((test_set$Sales - pred1)^2)

#Plot
plot(regressor, margin=0.1)
text(regressor, cex = 0.6)


plot(pred1, test_set$Sales)
abline(0,1)


#Random Forest

library(randomForest)

regressor2 = randomForest(Sales ~ . , data = training_set,
                          importance = T, mtry = 4, ntree = 500) 
#change combinations of mtry and ntree and check errors and var

regressor2

plot (regressor2)


##3

regressor3 =  randomForest(Sales ~., data = training_set,
                           importance = T, mtry = 6)

regressor3

pred2 = predict(regressor3, newdata = test_set)

#rmse
rmse(test_set$Sales, pred2)

#mse
mean((test_set$Sales - pred2)^2)


# Importance

importance(regressor3)

varImpPlot(regressor3)


