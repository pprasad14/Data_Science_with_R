# load dataset Salary_Data.csv

dataset = read.csv("Salary_Data.csv")

#splitting dataset into 'train' and 'test' set

library(caTools) #to work with train and test 

set.seed(123)

split = sample.split(dataset$Salary, SplitRatio = 2/3)

table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)


# fit simple linear regression model

model = lm( formula = Salary ~ YearsExperience,
            data = training_set)
# or 

regressor = lm(Salary ~ YearsExperience,
               training_set)

summary(model)


### Making Predictions with test_set results

y_pred = predict(regressor, newdata = test_set) 
y_pred

test_set$Predict = y_pred  #add a new variable to compare predicted and actual values


# RMSE

install.packages("Metrics")

library(Metrics)

rmse(test_set$Salary, y_pred)
rmse(y_pred, test_set$Salary)

library(ggplot2)


# visualize training_set

ggplot() +
  geom_point(aes(x = training_set$YearsExperience,
                 y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience,
                y = predict(regressor, newdata = training_set)),
            color = 'blue') +
  ggtitle("Salary vs Experience (Training Set)")  +
  xlab('Years of Experience')+
  ylab('Salary')


# visualize test_set

ggplot() +
  geom_point(aes(x = test_set$YearsExperience,
                 y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience,
                y = predict(regressor, newdata = training_set)),
            color = 'blue') +
  ggtitle("Salary vs Experience (Training Set)")  +
  xlab('Years of Experience')+
  ylab('Salary')


## both

# visualize training_set and test_set

ggplot() +
  geom_point(aes(x = training_set$YearsExperience,
                 y = training_set$Salary),
             colour = 'red') +
  geom_point(aes(x = test_set$YearsExperience,
                 y = test_set$Salary),
             colour = 'green') +
  geom_line(aes(x = training_set$YearsExperience,
                y = predict(regressor, newdata = training_set)),
            color = 'blue') +
  ggtitle("Salary vs Experience")  +
  xlab('Years of Experience')+
  ylab('Salary')



### Predict Salary from Experience using model created

predict(regressor, data.frame(YearsExperience =12))
