library(MASS)

data(Boston)

View(Boston)

cor(Boston)

View(cor(Boston))

# View Correlation

#install.packages("corrplot")

library(corrplot)

crr = cor(Boston)

corrplot(crr)

corrplot(crr, type = "lower")

corrplot(crr, method = 'number')

#####

plot(Boston)

attach(Boston)  # TO access database members without mentioning the database name

plot(crim, medv , cex = 0.6, xlab = "crime", ylab = "House Price")

#split dataset

library(caTools)
set.seed(123)
split = sample.split(Boston$medv, SplitRatio = .7)  #wrt to 'Y' variable

table(split)

training_set = subset(Boston, split ==T) 
test_set = subset(Boston, split == F)



# Fitting MLR
regressor = lm (medv ~ ., data = training_set)

summary(regressor)

#Predictions

y_pred = predict(regressor, newdata = test_set)

library(Metrics)

rmse(test_set$medv, y_pred)


# Backward Elimination

regressor1 = lm(medv ~ ., data = training_set)
summary(regressor1)

#remove indus

regressor1 = lm(medv ~ .-indus, data = training_set)
summary(regressor1)

# remove age

regressor1 = lm(medv ~ .-indus - age, data = training_set)
summary(regressor1)


#remove black

regressor1 = lm(medv ~ .-indus - age -black, data = training_set)
summary(regressor1)

# do not remove black since R2 and adjusted R2 decrease a lot (0.7901 to 0.788)


#### Final Model

regressor1 = lm(medv ~ .-indus - age, data = training_set)
summary(regressor1)

y_pred1 = predict(regressor1, newdata = test_set)
rmse(test_set$medv, y_pred1)


#####

regressor2 = lm(medv ~ .-indus - age -black, data = training_set)
summary(regressor2)

y_pred2 = predict(regressor2, newdata = test_set)
library(Metrics)

rmse(test_set$medv, y_pred2)

# After removing black, rmse has increased. hence do not remove
# regressor1 is our final model


#################


# step(), used to do all the above automatically
# smaller the AIC value, the better

regressor1 = lm(medv ~ ., data = training_set)
summary(regressor1)

step(regressor1, direction = "backward")


final= lm(formula = medv ~ crim + zn + chas + nox + rm + dis + rad + 
                 tax + ptratio + black + lstat, data = training_set)

y_pred4 = predict(final, newdata = test_set)

library(Metrics)

rmse(test_set$medv, y_pred4)


#####

#using forward

regressor1 = lm(medv ~ lstat, data = training_set)

regressor2 = lm(medv ~ ., data = training_set)

summary(regressor1)

step(regressor1, scope = list(lower = regressor1,
                              upper = regressor2), direction = "forward")


# both

step(regressor2, direction = "both")
step(regressor1, scope = list(upper = regressor2), direction = "both")



### Multicollinearity

library(car)

# create a model with all variables

regressor = lm(medv ~ ., data = training_set)

# VIF

vif(regressor)
