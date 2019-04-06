#load data

dataset = read.csv("Diabetes.csv")


# another way to make train and test set without caTools

set.seed(123)

id = sample(2, nrow(dataset), prob = c(0.7,0.3),
            replace = T)

table(id)

training_set = dataset[id==1,]
test_set = dataset[id ==2,]


#building descision tree

library(rpart)

classifier = rpart(is_diabetic ~ ., data = training_set)

#plot 

plot(classifier, margin = 0.1)
text(classifier, cex = 0.7) # cex is font


#####

library(rpart.plot)
rpart.plot(classifier, type = 3, digits = 3, fallen.leaves = T, cex = 0.6)


# Predictions

y_pred1 = predict(classifier, newdata = test_set, type = "class") # we dont want probs


#Confusion Matrix

library(caret)

confusionMatrix(test_set$is_diabetic, y_pred1)



#Random Forest

library(randomForest)
set.seed(123)
rf = randomForest(is_diabetic ~ ., data = training_set)

print(rf)

# plot classifier2
plot(rf)  # 3 lines, for different no of 'mtry'


#pred
library(caret)
y_pred2 = predict(rf, newdata = test_set)
confusionMatrix(test_set$is_diabetic, y_pred2)


rf3 = randomForest(is_diabetic ~ ., data = training_set,
                           importance = T, mtry = 5, ntree = 500)

rf3


#best no of trees

best = tuneRF(training_set[-9], training_set$is_diabetic,
              stepFactor = 1, improve = 0.05, trace = T, plot = T)


#Importance
importance(classifier2) # check the importance of variables

varImpPlot(classifier2) #to visualize the important variables


# Tree package
#install.packages("tree")

library(tree)

classifier4 = tree(is_diabetic ~ ., data = training_set)
plot (classifier4, margin = 0.1)
text(classifier4, cex = 0.7)

y_pred4 = predict(classifier4, newdata = test_set, type = "class")


#CM

confusionMatrix(test_set$is_diabetic, y_pred4)


