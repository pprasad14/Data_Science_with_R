# Set as Working directory and Load German dataset

dataset = read.table("German.txt")

colnames(dataset) = c('checking_acc_status','duration','credit_history','purpose',
                   'amount','savings_or_bonds','emp_duration','install_rate',
                   'personal_info','others','residence_duration','property',
                   'age','install_plans','housing','no_of_credits','job_info',
                   'no_of_people_liable','telephone','foreign_worker','credit_worthy')

dataset = dataset[,c('duration','amount','install_rate','residence_duration','age',
                     'no_of_credits','no_of_people_liable','credit_worthy')]

dataset$credit_worthy = as.factor(dataset$credit_worthy)

#splitting dataset into 'train' and 'test' set

library(caTools) #to work with train and test 

set.seed(123)

split = sample.split(dataset$credit_worthy, 0.8)

table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)


#scaling

training_set[-8] = scale(training_set[-8])
test_set[-8] = scale(test_set[-8])

# Fitting Logistic Regression Model

classifier = glm(credit_worthy ~ ., data = training_set,
                 family = "binomial")

summary(classifier)

# Predictions   ******

prob_pred = predict(classifier, newdata = test_set[-8],
                    type = "response")

y_pred = ifelse(prob_pred > 0.5, 1, 0)
table(y_pred)


#Confusion Matrix
cm = table(Actual = test_set[,8], Predicted = y_pred)
cm    

library(MLmetrics)

ConfusionMatrix(test_set[,8], y_pred) # **

Accuracy(test_set[,8], y_pred)
