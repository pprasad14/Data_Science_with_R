dataset = read.table("German.txt")

colnames(dataset) = c('checking_acc_status','duration','credit_history','purpose',
                   'amount','savings_or_bonds','emp_duration','install_rate',
                   'personal_info','others','residence_duration','property',
                   'age','install_plans','housing','no_of_credits','job_info',
                   'no_of_people_liable','telephone','foreign_worker','credit_worthy')

#keep only numeric data

dataset = dataset[c(2,5,8,11,13,16,18,21)]

dataset$credit_worthy = as.factor(dataset$credit_worthy)


library(caTools)

set.seed(123)

split = sample.split(dataset$credit_worthy, 0.75)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


# feature scaling

training_set[-8] = scale(training_set[-8])
test_set[-8] = scale(test_set[-8])


#fitting decision tree classification
#install.packages("rpart")

library(rpart)
set.seed(123)

classifier = rpart(formula = credit_worthy ~ ., data = training_set)


# predictin test_set results

y_pred = predict(classifier, newdata = test_set[-8]) # gives probabilities

y_pred = predict(classifier, newdata = test_set[-8],
                 type = "class")
head(y_pred)


#Confusion Matrix

library(caret)
confusionMatrix(test_set[,8], y_pred)


plot(classifier, margin = 0.1)
text(classifier)

library(rpart.plot)

rpart.plot(classifier, type = 3, digits = 3, fallen.leaves = T,
           cex = 0.6)
