# import the data set bank.csv

data = read.table("German.txt")


#dataset = read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data")

colnames(dataset) = c('checking_acc_status','duration','credit_history','purpose',
                      'amount','savings_or_bonds','emp_duration','install_rate',
                      'personal_info','others','residence_duration','property',
                      'age','install_plans','housing','no_of_credits','job_info',
                      'no_of_people_liable','telephone','foreign_worker','credit_worthy')





