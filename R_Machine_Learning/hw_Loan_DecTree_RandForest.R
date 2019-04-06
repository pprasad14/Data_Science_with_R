#note: rmse for regression and confusion matrix for classification,
# this is continuous variable, so rmse, no confusion matrix


# Decision Tree and Random Forest for loans dataset

# Load 'loans.csv' dataset

dataset = read.csv('loans.csv')


#removing Ac_no, Gender and Married Columns

dataset = dataset[,-1] 


#train and test split

library(caTools)

split = sample.split(dataset$Losses.in.Thousands, 0.75)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


# feature scale or not??

#training_set = scale(training_set)
#test_set = scale(test_set)



# fitting decision tree classifaction

library(rpart)

set.seed(123)

regressor = rpart(Losses.in.Thousands ~ ., data = training_set)


# predictin test_set results

y_pred = predict(regressor, newdata = test_set) 
#since it is not classification problem

table(y_pred)  # why only 3 values????



library(Metrics)
rmse(actual = test_set$Losses.in.Thousands, y_pred)

#plot 

plot(regressor, margin = 0.1)
text(regressor, cex = 0.7) # cex is font

library(rpart.plot)

rpart.plot(regressor, type = 3, digits = 3, fallen.leaves = T,
           cex = 0.6)


#Random Forest

library(randomForest)

regressor2 = randomForest(Losses.in.Thousands ~ ., data = training_set)


#pred

y_pred2 = predict(regressor2, newdata = test_set)

library(Metrics)
rmse(test_set$Losses.in.Thousands, y_pred2)


