# barplot

temp = c(22,24,25,23,22,24,25)
barplot(temp)

# barplot with added parameters

barplot(temp,
        main = "max temp in a week",
        xlab = "degress in celcius",
        ylab = "day",
        names.arg = c('sun','mon','tue','wed','thu','fri','sat'),
        col = "red")

#####  for horizontal plot:  horiz = T

barplot(temp,
        main = "max temp in a week",
        xlab = "degress in celcius",
        ylab = "day",
        names.arg = c('sun','mon','tue','wed','thu','fri','sat'),
        col = "cyan",
        horiz = T)


## plotting categorical data

age = c(22,24,25,23,26,27,27,28,29,20,23,26,27,28,22,21,26,25,33)
barplot(age)  #incorrect plot, bc it does not print freq of ages, but ages as a value

table(age)  # need a plot to show this information ie frequencies

barplot(table(age)) # correct plot

barplot(table(age),
        main = "Age count",
        xlab = "age",
        ylab = "count",
        col = "blue",
        border = "red", # the color to be used for the border of the bars.
        density = 15)   # no. of line per inch for bar components

# Plot higher dimensional tables

data("Titanic")
?Titanic  # to get information about the Titanic Dataset
Titanic   # to print the data of the Titanic Dataset
str(Titanic)

#margin.table()  **

margin.table(Titanic,1)


#count according to survival

margin.table(Titanic, 4)  #survived is 4th attribute
str(Titanic)

margin.table(Titanic)  #op:2201
barplot(margin.table(Titanic,4))
barplot(margin.table(Titanic,1))


# Histogram

data("airquality")
?airquality

str(airquality)

t = airquality$Temp  # so that we dont have to write airquality$Temp everytime

hist(t)
range(t)  #op: 56 97


# histogram with added parameters

hist(t,
     main = "Max daily Temperature",
     xlab = "Temp in F",
     xlim = c(50,100),    # to set x limits
     col = "green",
     freq = T)   # freq = F shows density

range(t) # to find range of temperature values

hist(t,
     main = "Max daily Temperature",
     xlab = "Temp in F",
     xlim = c(50,100),    # to set x limits
     col = "green",
     freq = F)  #shows density


# Return value of hist  **

g = hist(t)
g 


# plot histogram with different breaks

hist(t, breaks = 4, main = "break = 4")
hist(t, breaks = 15, main = "break = 15")


#histogram with manual breaks

hist(t,
     main = "Max daily Temperature",
     xlab = "Temp in F",
     xlim = c(50,100),    # to set x limits
     col = "green",
     breaks = c(55,60,65,70,75,85,100))  #manual breaks


# Pie charts
 
#create data

x = c(25,37,60,11)
pie(x)

labels = c("A","B","C","D")  #to provide names for the sections in pie chart
pie(x,labels)

f = sample(1:30)
pie(f)  #not recommended since to many categories

pie(x,labels, col = c("red",'blue','green','yellow')) #find: how to print %'s??


#Boxplot

boxplot(airquality$Ozone)


# Boxplot with added parameters

boxplot(airquality$Ozone,
        main = "mean ozone in parts per billion",
        xlab = "Parts per billion",
        ylab = "Ozone",
        col = "pink",
        border = "black",
        horizontal = F)  #for vertical boxes

boxplot(airquality$Ozone,
        main = "mean ozone in parts per billion",
        xlab = "Parts per billion",
        ylab = "Ozone",
        col = "pink",
        border = "black",
        horizontal =T) #for horizontal boxes


####


boxplot(airquality$Ozone,
        main = "mean ozone in parts per billion",
        xlab = "Parts per billion",
        ylab = "Ozone",
        col = "pink",
        border = "black",
        horizontal = T,
        notch = T)

# boxplot for each month

boxplot(Temp ~ Month,    #temp for each month
        data = airquality,
        main = "differen boxplot for each month",
        xlab = "month no.",
        ylab = "degree F",
        col = "yellow",
        border = "red")




#####

sal = c(35,43,55,67,43,78,30,44,42,55,77)
barplot(sal)

meansal = mean(sal)
abline(h = meansal)  #to add lines on the plot

medsal = median(sal)
abline(h = medsal,col = 'red')


#for std dev:

dev = sd(sal)  # sd() finds std. deviation
abline(h = meansal + dev, col= "blue")
abline(h = meansal - dev, col= "yellow")


# Plotting with factors

chest = c('gold','silver','gem','gold','gem','gem','silver')
types = factor(chest)
weight = c(200,300,200,500,450,350,250)
prices = c(9000,5000,6000,6000,3000,2500,7000)

plot(weight, prices)

#pch will use different shapes to differentiate different datapoints
plot(weight, prices, pch = as.integer(types))

#add legend

legend("topright", c("gem","gold","silver"), pch = 1:3)

