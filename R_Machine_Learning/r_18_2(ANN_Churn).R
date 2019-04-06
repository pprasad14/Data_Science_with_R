# Churn_Modelling dataset

dataset = read.csv("Churn_Modelling.csv")

#remove 1:3 cols since not required

dataset = dataset[,-(1:3)]


#encode categorical variables to factor 1,2,3, and then convert to numeric 
#because later we will have to convert to numeric matrix, so it does not convert to character matrix

dataset$Geography = as.numeric(factor(dataset$Geography,
                                      levels = c("France","Spain","Germany"),
                                      labels = c(1,2,3)))

dataset$Gender = as.numeric(factor(dataset$Gender,
                                   levels = c("Female","Male"),
                                   labels = c(1,2)))

#splitting

library(caTools)

set.seed(123)

split = sample.split(dataset$Exited, 0.8)

training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)


# Feature scaling is important for Neural Nets

training_set[-11] = scale(training_set[-11])
test_set[-11] = scale(test_set[-11])


# fitting ANN model to training_set

#install.packages("h2o")

library(h2o)

h2o.init(nthreads = -1)# to use all threads on system
#uses Java version 8, not compatable with 9

#can play with NN in playground.tensorflow.org

model = h2o.deeplearning(y = "Exited",
                         training_frame = as.h2o(training_set),#convert training_set to h2o dataframe, else error
                         activation = "Rectifier",
                         hidden = c(6,6),  # no of hidden layers and no of nodes in each hidden layer
                         epochs = 100,  # no of iterations
                         train_samples_per_iteration = -2)
# best to keep no of nodes as avg of input and output nodes

plot(model) # more epochs results in less rmse/error


#Predicting test results

y_pred = h2o.predict(model, newdata = as.h2o(test_set[-11]))

head(y_pred) # as numbers

y_pred = (y_pred > 0.5)

head(y_pred) # now classes

#y_pred is an environment, so convert to see CM
y_pred = as.vector(y_pred)

# CM

cm = table(test_set[,11],y_pred)

cm

# localhost:54321\ to view in browser while session running, else wont work

# to end session:

h2o.shutdown()

#missclassification

1 - sum(diag(cm))/sum(cm)


# to close session:
h2o.shutdown() # then press Y to confirm
