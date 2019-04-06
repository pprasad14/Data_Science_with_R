data = read.table("German.txt")

colnames(data) = c('checking_acc_status','duration','credit_history','purpose',
                      'amount','savings_or_bonds','emp_duration','install_rate',
                      'personal_info','others','residence_duration','property',
                      'age','install_plans','housing','no_of_credits','job_info',
                      'no_of_people_liable','telephone','foreign_worker','credit_worthy')

#splitting dataset into 'train' and 'test' set

library(caTools) #to work with train and test 

set.seed(123)

split = sample.split(data$credit_worthy, 0.8)

table(split)

training_set = subset(data, split ==T) 
test_set = subset(data, split == F)

model1 = lm(credit_worthy ~ .,
            data = training_set)
summary(model1)


model = lm(credit_worthy ~ checking_acc_status + duration + credit_history
           + purpose + amount + savings_or_bonds + install_rate + others +
             property + install_plans + housing + age , data = training_set)
summary(model)

#remove amount and age

model = lm(credit_worthy ~ checking_acc_status + duration + credit_history
           + purpose + savings_or_bonds + install_rate + others + property
           + install_plans + housing, data = training_set)
summary(model)

#remove purpose

model = lm(credit_worthy ~ checking_acc_status + duration + credit_history
           + savings_or_bonds + install_rate + others + property
           + install_plans + housing, data = training_set)
summary(model)

#remove install_plans

final = lm(credit_worthy ~ checking_acc_status + duration + credit_history
           + savings_or_bonds + install_rate + others + property
           + housing, data = training_set)
summary(model)

#using step()
step(model1, direction = "backward")

final_step = lm(formula = credit_worthy ~ checking_acc_status + duration + 
                  credit_history + purpose + amount + savings_or_bonds + emp_duration + 
                  install_rate + others + install_plans + housing + foreign_worker, 
                data = training_set)

summary(final_step)

#making predictions

y_pred1 = predict(final, newdata = test_set)  #manually
y_pred2 = predict(final_step, newdata = test_set) #using step()


library(Metrics)
rmse(test_set$credit_worthy, y_pred1)  #of manual
rmse(test_set$credit_worthy, y_pred2)  #of step()
