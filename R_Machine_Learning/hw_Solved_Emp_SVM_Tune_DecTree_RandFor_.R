dataset = read.csv("Emp.csv")

#remove serial number

dataset$srnumber = NULL

#making a high low column
sal = ifelse(dataset$Emp_Sal== ">50K", "High","Low")

#adding sal to dataset
dataset = data.frame(dataset,sal)

#remove emp_sal
dataset$Emp_Sal = NULL


#split with caret package

library(caret)
set.seed(123)

split = createDataPartition(dataset$sal, p = 0.7, list = F)

training_set = dataset[split,]
test_set = dataset[-split,]


#making decision tree

library(rpart)

classifier = rpart(sal ~ . , data = training_set)
plot (classifier, margin = 0.1)
text(classifier, cex = 0.7)


#pred

pred = predict(classifier, newdata = test_set, type = "class")

cm = table(test_set$sal, pred)
cm




# tuning SVM

library(e1071)

tune = tune(svm , sal~ . , data = training_set,
            ranges = list(gamma = seq(0,1,0.1, cost = c(2^(2:5)))))