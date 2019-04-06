tip = read.csv('tip.csv')  #to import dataset from current directory

Bill  #will show error since no object Bill is present

tip$Bill

# use attach() to access columns without specifying dataframe name

attach(tip)
Bill # prints Bill column

###

#Tip

plot(Tip) # top plot Tip column, not the tip dataset

mean(Tip)  # to find mean value of Tip column data

abline(h = mean(Tip))  # to draw the mean value line of Tip on plot 


# Make linear model using 'Tip' and 'Bill' column from 'tip' dataset

mod = lm(Tip ~ Bill, data = tip) 

#plotting requires logical sequence

plot(Bill, Tip)

abline(h = mean(Tip))  # h for horizontal line
abline(v = mean(Bill)) # v for vertical line

abline(mod, col = "red", lwd = 1)  #to plot the model line, note: it passes via (x',y')

summary(mod)  #read about the output value's meaning

anova(mod) 


