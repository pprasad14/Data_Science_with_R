# load Boston Dataset

library(MASS)
data("Boston")
View(Boston)

# Train and Test split

library(caTools) #to work with train and test 

set.seed(123)

split = sample.split(Boston$medv, SplitRatio = .7)  #wrt to 'Y' variable

table(split)

training_set = subset(Boston, split ==T) 
test_set = subset(Boston, split == F)


# Making Multiple Linear Regression (MLR) Model

regressor = lm(medv ~ . , data = training_set)  # use '.' to consider all variables

summary(regressor)


# Make Predictions

y_pred = predict(regressor, newdata = test_set)
y_pred
test_set$Predict = y_pred  #add a new variable to compare predicted and actual values

library(Metrics)
rmse(test_set$Profit, y_pred)

#######


#Building optimal model with Backward Elimination (with +)

regressor2 = lm(medv ~ . ,
                data = Boston)

summary(regressor2)

# remove age since highest p value

regressor2 = lm(medv ~ . - age ,
                data = Boston)

summary(regressor2)


# remove indus since highest p value

regressor2 = lm(medv ~ .-age -indus ,
                data = Boston)

summary(regressor2)





