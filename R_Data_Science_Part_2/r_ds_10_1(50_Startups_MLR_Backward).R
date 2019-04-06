# load : 50 startups dataset

dataset = read.csv("50_Startups.csv")

#Encode Categorical Data, factors of 'States' to 1,2,3

dataset$State = factor(dataset$State,
                       levels = c('New York','California','Florida'),
                       labels = c(1,2,3))

# Train and Test split

library(caTools) #to work with train and test 

set.seed(123)

split = sample.split(dataset$Profit, SplitRatio = .8)  #wrt to 'Y' variable

table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)

# Making Multiple Linear Regression (MLR) Model

regressor = lm(Profit ~ . , data = training_set)  # use '.' to consider all variables

summary(regressor)

# Make Predictions

y_pred = predict(regressor, newdata = test_set)
y_pred
test_set$Predict = y_pred  #add a new variable to compare predicted and actual values

library(Metrics)
rmse(test_set$Profit, y_pred)


#######

#Building optimal model with Backward Elimination (with +)

regressor2 = lm(Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
                data = dataset)

summary(regressor2)

# since State has highest P value, remove State variable

regressor2 = lm(Profit ~ R.D.Spend + Administration + Marketing.Spend,
                data = dataset)

summary(regressor2)

#### 

# how to remove only State2

#regressor2 = lm(Profit ~ R.D.Spend + Administration + 
#                  Marketing.Spend + factor(State, exclude = 2),
#                data = dataset)

#summary(regressor2)


# Remove Administration since highest P value

regressor2 = lm(Profit ~ R.D.Spend + Marketing.Spend,
                data = dataset)

summary(regressor2)


# remove Marketing.Spend since p value> alpha

regressor2 = lm(Profit ~ R.D.Spend,
                data = dataset)

summary(regressor2)


# Model with above 2 variables

regressor2 = lm(Profit ~ R.D.Spend,
                data = training_set)


summary(regressor2)


# Making Predictions

y_pred2 = predict(regressor2, newdata = test_set)
y_pred2
test_set$Predict2 = y_pred2  #add a new variable to compare predicted and actual values

library(Metrics)
rmse(test_set$Profit, y_pred2)



#####  FINAL MODEL

regressor4 = lm(Profit ~ R.D.Spend + Marketing.Spend,
                data = training_set)

summary(regressor4)


# Predictions

y_pred4 = predict(regressor4, newdata = test_set)

rmse(test_set$Profit, y_pred4)
