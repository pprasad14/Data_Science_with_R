#Predict if loan will be approved or not


#upload test train and validate datasets

test = read.csv("test.csv")
train = read.csv("train.csv")
validate = read.csv("validate.csv")

dim(test)
dim(train)
dim(validate)


# add new col to test

test$Loan_Status = NA


# Join both dataframes by 'rbind'

x_all = rbind(train,test)

colSums(is.na(x_all))

str(x_all)

##

summary(x_all)  #note the blank space in 'Gender'


### replace all blanks with columns' majority value


# Gender

table(x_all$Gender) # to see no of blanks, males and females

levels(x_all$Gender)[levels(x_all$Gender)== ""]= "Male" # to make blanks to 'Male'
table(x_all$Gender)

# Married

table(x_all$Married)

levels(x_all$Married)[levels(x_all$Married)== ""]= "Yes" 
table(x_all$Married)

# Dependents

table(x_all$Dependents)

levels(x_all$Dependents)[levels(x_all$Dependents)== ""]= "0" 
table(x_all$Dependents)


# Education

table(x_all$Education) #no blanks


# Self-Employed

table(x_all$Self_Employed)

levels(x_all$Self_Employed)[levels(x_all$Self_Employed)== ""]= "No" 
table(x_all$Self_Employed)


# Applicant Income

#check for NA's
table(is.na(x_all$ApplicantIncome)) # no NA's


# check outliers

boxplot(x_all$ApplicantIncome, horizontal = T)


#Calculate Extreme Points for ApplicantIncome

summary(x_all$ApplicantIncome)

# formula:  (Q3 + 1.5 IQR)

x = 5516 + (1.5 * IQR(x_all$ApplicantIncome))

x 

x_all$ApplicantIncome[x_all$ApplicantIncome >= x] = mean(x_all$ApplicantIncome)

boxplot(x_all$ApplicantIncome, horizontal = T)  #outliers have been reduced drastically



# Calculate Extreme Points for ApplicantIncome

table(is.na(x_all$CoapplicantIncome))

boxplot(x_all$CoapplicantIncome, horizontal = T)

summary(x_all$CoapplicantIncome)

# formula:  (Q3 + 1.5 IQR)

x1 = 2365 + (1.5 * IQR(x_all$CoapplicantIncome))

x1 

x_all$CoapplicantIncome[x_all$CoapplicantIncome >= x1] = mean(x_all$CoapplicantIncome)

boxplot(x_all$CoapplicantIncome, horizontal = T)  #outliers have been reduced drastically


#Loan Amount

table(is.na(x_all$LoanAmount))
summary(x_all$LoanAmount)

#replace NA's with median not mean since lower the loan amount, higher the chance for loan

x_all$LoanAmount[is.na(x_all$LoanAmount)] = median(x_all$LoanAmount, na.rm = T)

boxplot(x_all$LoanAmount, horizontal = T)


# reducing outliers

summary(x_all$LoanAmount)

x2 = 160 + 1.5*IQR(x_all$LoanAmount)

x2

x_all$LoanAmount[x_all$LoanAmount >= x2] = median(x_all$LoanAmount)

boxplot(x_all$LoanAmount, horizontal = T)  #outliers have been reduced drastically


# loan amount term

summary(x_all$Loan_Amount_Term)

table(x_all$Loan_Amount_Term)  # has 12 categories, so replace with max number

x_all$Loan_Amount_Term[is.na(x_all$Loan_Amount_Term)] = 360

table(x_all$Loan_Amount_Term)


# Binning: reducing the no of levels by combining them into a ranges
# do Binning for Loan_Amount_Term since it has 12 categories

x_all$Loan_Amount_Term[x_all$Loan_Amount_Term %in% c("6","12","36","60")] = "5 Years"
x_all$Loan_Amount_Term[x_all$Loan_Amount_Term %in% c("84","120")] = "10 Years"
x_all$Loan_Amount_Term[x_all$Loan_Amount_Term %in% c("300","350","360")] = "30 Years" 
x_all$Loan_Amount_Term = as.factor(x_all$Loan_Amount_Term)

table(x_all$Loan_Amount_Term)



# Credit History

table(x_all$Credit_History)
summary(x_all$Credit_History)

x_all$Credit_History[is.na(x_all$Credit_History)] = 1

table(x_all$Credit_History)  # now no NA's

#convert to factor

x_all$Credit_History = as.factor(x_all$Credit_History)


#Property Area

table(x_all$Property_Area)  #no NA's

summary(x_all$Property_Area)


########


# Getting back train and test data

x_train = x_all[1:nrow(train),]
x_test = x_all[-(1:nrow(train)),]

dim(x_train)
dim(x_test)

#remove Loan ID

x_train$Loan_ID = NULL
x_test$Loan_ID = NULL
x_test$Loan_Status = NULL


# making model

classifier = glm(Loan_Status ~ . , data = x_train,
                 family = "binomial")

summary(classifier)

#cross checking model on train data

prob_pred = predict(classifier, newdata = x_train[,-12], #? why with 'x_train'?
                    type = "response")

table(x_all$Loan_Status)

y_pred = ifelse(prob_pred > 0.5 , "Y", "N")

library(caret)
table(x_train$Loan_Status, y_pred)

library(MLmetrics)
ConfusionMatrix(x_train$Loan_Status, y_pred)

Accuracy(x_train$Loan_Status, y_pred)


# Prediction on test data

prob_pred = predict(classifier, newdata = x_test, type = "response")

y_pred2 = ifelse(prob_pred > 0.5 , "Y", "N")

ConfusionMatrix(validate$outcome, y_pred2)
Accuracy(validate$outcome, y_pred2)

