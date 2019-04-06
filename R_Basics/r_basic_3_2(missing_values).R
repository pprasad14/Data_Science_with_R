##MIssing Values

# NA's or missing values

x = c(2,3,4,5,NA,7,8)

sum(x)  #error bc NA is present

sum(x,na.rm = T)  #removes NA's present in x

help(impute)

library(Hmisc)  #to load Hmisc package
impute(Hmisc)

help(impute)

summary(x)  #gives the overall summary of the data 

impute(x)
x

#replace NA with mean, median or a random number from within the dataset

impute(x, median) 

impute(x,mean)

impute(x,"random")

set.seed(33)
impute(x,'random')
