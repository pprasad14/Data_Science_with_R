# SVM for Loan dataset: Train, test, validate

# load datasets

train = read.csv("train (2).csv")
test = read.csv("test (2).csv")
validate = read.csv("validate (2).csv")

test$Loan_Status <- NA

X_all <- rbind(train,test)

View(X_all)

str(X_all)

# gender
table(is.na(X_all$Gender))

table(factor(X_all$Gender))

levels(X_all$Gender)[1]= "Female"

str(X_all)

# Married
table(is.na(X_all$Married))

table(factor(X_all$Married))

levels(X_all$Married)[levels(X_all$Married)== ""]= "Yes"

str(X_all)

# dependendts
table(X_all$Dependents)

levels(X_all$Dependents)[levels(X_all$Dependents) == ""]<- "0"

table(X_all$Dependents)

str(X_all)

table(X_all$Education)

# Self Employed
table(X_all$Self_Employed)
levels(X_all$Self_Employed)[levels(X_all$Self_Employed)==""]<- "Yes"

#

# Checking NA's
table(is.na(X_all$ApplicantIncome))

# checking outliers
boxplot(X_all$ApplicantIncome) # we can see in the box plot there are many outliers

# working out with outliers
Calculating upper whisker of the coapplicant Income
summary(X_all$CoapplicantIncome)

x1 <- 2365 + 1.5*IQR(X_all$CoapplicantIncome)

X_all$CoapplicantIncome[X_all$CoapplicantIncome>=x1]= mean(X_all$CoapplicantIncome)

boxplot(X_all$CoapplicantIncome)

#

loan amount
table(is.na(X_all$LoanAmount))
X_all$LoanAmount[is.na(X_all$LoanAmount)==T] <- median(X_all$LoanAmount,na.rm=T)

table(is.na(X_all$LoanAmount))

boxplot(X_all$LoanAmount)

summary(X_all$LoanAmount)

x2 <- 160 + 1.5* IQR(X_all$LoanAmount)

X_all$LoanAmount[X_all$LoanAmount>= x2] <- mean(X_all$LoanAmount)

boxplot(X_all$LoanAmount)

Loan Amount Term
summary of loan amount term
summary(X_all$Loan_Amount_Term)
table(X_all$Loan_Amount_Term)
X_all$Loan_Amount_Term[X_all$Loan_Amount_Term%in% c("6","12","36","60")] <- "5 Years"

X_all$Loan_Amount_Term[X_all$Loan_Amount_Term%in% c("84","120")] <- "10 Years"

X_all$Loan_Amount_Term[X_all$Loan_Amount_Term%in% c("300","350","360")] <- "30 Years"

table(X_all$Loan_Amount_Term)

X_all

Credit history
table(is.na(X_all$Credit_History))

table(X_all$Credit_History)

X_all$Credit_History[is.na(X_all$Credit_History)]<- 1
table(is.na(X_all$Credit_History))

Property Area
table(X_all$Property_Area)

X_train<- X_all[1:nrow(train),]

X_test <- X_all[-(1:nrow(train)),]

X_train$Loan_ID <- NULL

X_test$Loan_ID <- NULL

fitting the model
library(e1071)
classifier1 <- svm(Loan_Status~., data = X_train)

classifier

Prediction and confusion matrix
y_pred <- predict(classifier, newdata = X_train)

cm <- table(validate$outcome, y_pred)

#
attributes(classifier)

classifier$fitted

cm <- table(X_train$Loan_Status, classifier$fitted)

tune <- tune(svm,Loan_Status~., data= X_train, kernel = "radial", ranges= list( gamma= seq(0,1, 0.1), cost= (2 ^(2:9))))

tune

plot(tune)

cm
cm <- table(X_train$Loan_Status, tune$best.model$fitted)

cm