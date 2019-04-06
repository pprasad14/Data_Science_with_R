# load Iris datset from R package: datasets

data(iris)
str(iris)

#plotting

library(ggplot2)

qplot(Petal.Length, Petal.Width, data = iris)  # cant differentiate btw the species

qplot(Petal.Length, Petal.Width, data = iris, color = Species)  # uses color to differentiate


# split data to train and test set

#library(caTools)

#set.seed(123)

#split = sample.split(iris$Species, 0.75)

#training_set = subset(iris, split == T)
#test_set = subset(iris, split == F)


# Fit model

####### Radial #######

library(e1071)

classifier = svm(Species ~ . , data = iris)

classifier  # default radial

# summary(iris)   gives similar output as 'classifier'

plot(classifier, data = iris)  # error, since cant plot more than 2 dimensions

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length) # get all as setosa, dim issues

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length,
     slice = list(Sepal.Length = 4, Sepal.Width = 3)) #fix lenght to 4 and width to 3, to see different species
# all x's are support vectors, total is 51 (but is see only 42)


#Predictions

pred = predict(classifier, newdata = iris)

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # get 0.0267



###### Linear  ######


classifier = svm(Species ~ . , data = iris,
                 kernel = "linear")

classifier  

# summary(iris)   gives similar output as 'classifier'

plot(classifier, data = iris)  # error, since cant plot more than 2 dimensions

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length) # get all as setosa, dim issues

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length,
     slice = list(Sepal.Length = 4, Sepal.Width = 3)) #fix lenght to 4 and width to 3, to see different species
# all x's are support vectors, total is 51 (but is see only 42)


#Predictions

pred = predict(classifier, newdata = iris)

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # get 0.0333 for linear


###### Polynomial  ######


classifier = svm(Species ~ . , data = iris,
                 kernel = "polynomial") #default degree is 3

classifier  

# summary(iris)   gives similar output as 'classifier'

plot(classifier, data = iris)  # error, since cant plot more than 2 dimensions

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length) # get all as setosa, dim issues

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length,
     slice = list(Sepal.Length = 4, Sepal.Width = 3)) #fix lenght to 4 and width to 3, to see different species
# all x's are support vectors, total is 51 (but is see only 42)

#Predictions

pred = predict(classifier, newdata = iris)

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # get 0.04667 for polynomial with degree 3



classifier = svm(Species ~ . , data = iris,
                 degree = 4,
                 kernel = "polynomial") 

#Predictions

pred = predict(classifier, newdata = iris)

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # get 0.1533 for polynomial with degree 4



classifier = svm(Species ~ . , data = iris,
                 degree = 2,
                 kernel = "polynomial") 

#Predictions

pred = predict(classifier, newdata = iris)

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # get 0.12 for polynomial with degree 2




###### Sigmoid ######


classifier = svm(Species ~ . , data = iris,
                 kernel = "sigmoid")

classifier  

# summary(iris)   gives similar output as 'classifier'

plot(classifier, data = iris)  # error, since cant plot more than 2 dimensions

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length) # get all as setosa, dim issues

plot(classifier, data = iris, 
     Petal.Width ~ Petal.Length,
     slice = list(Sepal.Length = 4, Sepal.Width = 3)) #fix lenght to 4 and width to 3, to see different species
# all x's are support vectors, total is 51 (but is see only 42)


#Predictions

pred = predict(classifier, newdata = iris)

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # get 0.11333 for sigmoid

######### Therefore: (RBF Kernel) Radial is best as it has least misclassification rate 



####### Tuning #####

tune = tune(svm, Species ~ ., data = iris,
            ranges = list(gamma = seq(0,1,0.1), cost = (2^(2:9))))

tune

#plot tuned model

plot(tune)

summary(tune)  # gives all combinations of cost and gamma models, total: 11*8=88

attributes(tune)


#Best Model

mymodel = tune$best.model  # our new model

summary(mymodel)


#Predictions

pred = predict(mymodel, data = iris)

# CM

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm) # note the reduction in mis-classification, now 0.01333


# tune$best.model$fitted

set.seed(123)
tune = tune(svm, Species ~ ., data = iris,
            ranges = list(epsilon = seq(0,1,0.1), cost = (2^(2:9))))

tune

#plot tuned model

plot(tune) # more dark, less error

summary(tune)  # gives all combinations of cost and gamma models, total: 8*11=88

attributes(tune)


#Best Model

mymodel = tune$best.model  # our new model

summary(mymodel)


#Predictions

pred = predict(mymodel, data = iris)

# CM

cm = table(iris$Species, pred)

cm


# Mis-classification rate

1 - sum(diag(cm))/ sum(cm)  # mis-classification is 0.01333
