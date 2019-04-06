#make current directory and load bank.csv dataset

dataset = read.csv("bank.csv",sep = ";", header = T)

dataset$y = factor(dataset$y, levels = c("no","yes"), labels = c(0,1))


# replace unknowns with max values

#education

table(dataset$education)
levels(dataset$education)[levels(dataset$education)== "unknown"]= "secondary" 
table(dataset$education)


#contact

table(dataset$contact)
levels(dataset$contact)[levels(dataset$contact)== "unknown"]= "cellular" 
table(dataset$contact)


#poutcome

#table(dataset$poutcome)
#levels(dataset$poutcome)[levels(dataset$outcome) =="unknown"]= "" 
#table(dataset$education)


#split data

library(caTools)

set.seed(123)

split = sample.split(dataset$y, .8)
table(split)

training_set = subset(dataset, split ==T) 
test_set = subset(dataset, split == F)

summary(dataset)


# Fitting Logistic Regression Model

classifier = glm(y ~ ., data = training_set,
                 family = "binomial")

summary(classifier)


# Predictions   

prob_pred = predict(classifier, newdata = test_set,
                    type = "response")

y_pred = ifelse(prob_pred > 0.5, 1, 0)


#Confusion Matrix
cm = table(Actual = test_set[,17], Predicted = y_pred)
cm    

library(MLmetrics)

ConfusionMatrix(test_set[,17], y_pred) 
Accuracy(test_set[,17], y_pred)





