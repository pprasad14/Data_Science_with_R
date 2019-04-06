# Case Study on IT network intrusion and detection

# load train, test and validate datasets

test = read.csv("Test.csv")
train = read.csv("Train.csv")
validate = read.csv("Validate.csv")


# Add another variable to test set

test$class = NA

# rbind train and test datasets

x_all = rbind(train, test)
summary(x_all)

# check for NA's or incomplete rows

nrow(x_all[!complete.cases(x_all),])

str(x_all)


# converting to categories

cols = c("land","wrong_fragment","urgent","num_failed_logins",
         "logged_in","root_shell", "su_attempted","num_shells",
         "is_guest_login")

#convert above columns from numeric to factor

          # incorrect: x_all[cols] = as.factor(x_all[cols])

for(i in cols){
  x_all[,i] = as.factor(x_all[,i])
}

    # another way: x_all[,cols] = lapply(x_all[,cols], factor)


# Removing column with "0" bc it will unnecessarily increase size of tree

table(x_all$num_outbound_cmds)

x_all$num_outbound_cmds = NULL


# reducing no of levels

levels(x_all$service)  # has 67 levels, so use binning

levels(x_all$service)[levels(x_all$service) %in% c("domain","domain_u")] = "domain"
levels(x_all$service)[levels(x_all$service) %in% c("echo","eco_i")] = "echo"
levels(x_all$service)[levels(x_all$service) %in% c("ftp","ftp_data","tftp_u")] = "ftp"
levels(x_all$service)[levels(x_all$service) %in% c("http","http_443","http_8001")] = "http"
levels(x_all$service)[levels(x_all$service) %in% c("netbios_dgm","netbios_ns","netbios_ssn")] = "netbios"
levels(x_all$service)[levels(x_all$service) %in% c("pop_2","pop_3")] = "pop"
levels(x_all$service)[levels(x_all$service) %in% c("tim_i","time")] = "time"
levels(x_all$service)[levels(x_all$service) %in% c("uucp","uucp_path")] = "uucp"
levels(x_all$service)[levels(x_all$service) %in% c("shell","ssh","kshell")] = "shell"
levels(x_all$service)[levels(x_all$service) %in% c("login","klogin")] = "login"

levels(x_all$service)  #reduced from 67 to 53 variables

# now reduce factor based on count

table(x_all$service)

levels(x_all$service)[levels(x_all$service) %in% c("red_i", "urh_i")]= "other"

# Flag

# merge the similar ones

levels(x_all$flag)

table(x_all$flag)

levels(x_all$flag)[levels(x_all$flag) %in% c("s0","s1","s2","s3")] = "s0"
levels(x_all$flag)[levels(x_all$flag) %in% c("RSTO", "RSTOS0")] = "RTSO"
levels(x_all$flag)[levels(x_all$flag) %in% c("OTH","SF")] = "SF"
# this is the end of preprocessing


# Separate train and test set

x_train = x_all[1:nrow(train),]
x_test = x_all[-(1:nrow(train)),]
x_test$class = NULL



# fitting decision tree model

library(rpart)

classifier = rpart(class ~ . , data = x_train, method = "class")
# make method = "anova" for regression tree

plot(classifier, margin = 0.1)

text(classifier, cex = 0.7)


# Predictin test results

y_pred = predict(classifier, newdata = x_test, type = "class")


#CM

library(caret)

confusionMatrix(validate$class, y_pred)
#use validate not x_test


# Random forest

library(randomForest)

classifier2 = randomForest(class ~ . , data = x_train)

classifier2


# Predictions

y_pred2 = predict(classifier2, newdata = x_test)

confusionMatrix(validate$class, y_pred2)


# to see important variables
varImpPlot(classifier2)
