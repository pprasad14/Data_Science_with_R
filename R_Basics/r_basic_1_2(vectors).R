x<-80
x
print(x)
x
y= "hello world"
y

#data types
x=70
class(x)
class(y)


#1. vector
# c() is concat or combine
d = c(11,12,13,14)
d
f = sqrt(d)
f
print(f)
  

#absolute values
f = c(-3,-6,-9)
abs(f)

###

c(c(1,2),c(3,4))

# classes of vectors

#1. numeric vectorh 
h = 66.8
class(h)


#2. integers
g= as.integer(4)
g
class(g)

# conver numeric ot integer using L
g = c(3,5,7)
f=as.integer(g)
class(f)

#or use:
g=c(3L,5L,7L)


#3. Complex

d=3+5i
d
class(d)


#4.logical vector
a = 6; b=3
f = a>b
class(f)
f


v= c(1,-8,6,7,-5,5)
class(v)
tf = v<1
tf
class(tf)



#5.character  vector

d= as.character(78.9)
class(d)
d
b = 'hello'
class(b)
h = c ('hello','Prem', 'Prasad')
h
class(h)
length(h)


#use paste function
paste(h,collapse = " ")
length(paste(h, collapse = " "))


#to concatenate multiple character vectors

paste("hello", "worlds", sep = " ")
paste(1:3, c('prem','is','boy'), sep=" ")



#sequence of numbers

# 1.  " : " creates a sequence of numbers
1:40

pi:15

#2. seq()

seq(1,40)
seq(1,20,0.8)

# 3. rep()

rep(7,10)
rep(c(1,2,3,4),times=5)
rep(c(1,2,3,4),each=5)

#vectors

city = c('mumbai','bangalore','chennai','pune','mumbai','pune')


#calc frequency
table(city)


#check to add different data types

u = c(TRUE, 78L,66.9, "prem")
class(u)
u
v = as.integer(u)
v             #non numeric/integer types are replaced with NA's since not convertable to integer
class(v)



#access vectors
vect = c('i','am','a','boy', 'Prem')
class(vect)
vect[2]



#assign new values to vector

vect[2]='is'
vect
length(vect)
vect[6]='prasad'
vect[10]='hi'
vect
vect[c(1,7)]



# getting range of values
vect[2:4]

#set range of vaues

# add elements 5:7

vect[5:7]=c('a','b','c')
vect
length(vect)
