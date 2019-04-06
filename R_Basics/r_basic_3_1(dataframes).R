##

#Data Frames

weights = c(300,450,200,360,450,200)
price = c(4000,5000,2000,3000,6000,3000)
types = c('gold','silver','gem','silver','gold','coin')

treasure = data.frame(weights,price,types)
treasure
View(treasure)
treasure$types
table(types)
types

#Data Frame Access

treasure[[2]]
treasure[['weights']]
treasure$price


#create Data Frame

x = data.frame('roll_no'= 1:4, 'age'= c(23,22,25,27),'name'= c('prem','arun','jui','vineeth'))
x

#to see structure

str(x)


#if we want to stop conversion of character vector to factor
#use stringsAsFactors = F

x = data.frame('roll_no'= 1:4, 'age'= c(23,22,25,27),'name'= c('prem','arun','jui','vineeth'),
               stringsAsFactors = F)
str(x)
View(x)


#Accessing components of DataFrame

#accessing like a list

# [], [[]], $

x$name
x[['name']]
x[3]  #returns the dataframe
x[[3]]  #returns the vector


#accessing like a matrix

data(trees)

str(trees)  #to see the structure of trees dataset

View(trees) #to view in a table

head(trees)  #to view top 6 rows

tail(trees)  #to view bottom 6 rows

head(trees, 8) # to print top 8 rows

tail(trees, 10) # to pring bottom 10 rows


# access rows

trees[c(4,5),]  
trees[15:20,]

?trees

#select rows with height > 70

trees[trees[2]>70,]  #or trees[trees$Height>70,]

trees[14:16,2]  #result in vector format
trees[14:16,2,drop = F]   #result not in vector format


#Modify Data Frame

x
x[1,'age'] = 40
x


#add a new row

rbind (x, list(5,30,'om'))  #does not update x


#add a new column

x = cbind(x, State = c('mah','goa','pune','chennai'))  #does not update x
x

#delete components

#delet state

x$State = NULL
x


#deleting rows

x = x[-1,]  #removes first row
x
str(x)
