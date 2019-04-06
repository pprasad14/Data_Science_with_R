#vector names

roll_num = 1:5
roll_num
names(roll_num)= c('prem','jui','vineeth','arun','prasad')
roll_num



# use names to access vector data

roll_num['vineeth']

#changing roll numbers

roll_num['vineeth']=6


#Vector Mathematics

f = c(2,5,8)

#adding a number each element of vector

f+1   #does not affect f
f/2   #does not affect f


##

g = c(4,5,8)
f + g
b = c(6,7)
f+b

g-f


##  Comparing two vectors


a = c(6,3,9)
a == c(4,3,5)


## R Operators

# Arithmetic

  #1. Addition

  h = c(4,5,7)
  g = c(5,6,9)
  print(h+g)
  
# 2.Subtraction  
  
  h = c(4,5,7)
  g = c(5,6,9)
  print(h-g)

#3.Multiplication
  
  g= c(33.2,9)
  f = c(4,6,8)  
  g*f  
  
#4. Division
  
  g = c(3,6,9)
  h = c(2,3,8)  
  print(g/h)  

#5. Modulus
  
  h = c(2,5.5,8)
  k=c(8,4,5)  
  h %%k  # single % does not work  

########
  

#  Relational Operators

  #Greater Than
  
  d=c(4,6,8,9)
  f=c(4,3,9,2)  
  d>f  
  
  #Less Than
  
  d=c(4,6,8,9)
  f=c(4,3,9,2)  
  d<f

  #Equals operator
  
  d=c(4,6,8,9)
  f=c(4,3,9,2)  
  d==f

  #Less than equal to
  
  d=c(4,6,8,9)
  f=c(4,3,9,2)  
  d<=f

  #Not equal to
  
  d=c(4,6,8,9)
  f=c(4,3,9,2)  
  d!=f

  
#Logical Operators  

  #Element wise logical AND operator
  
  b = c(T,3,2,16.5,3+4i)
  g = c(F,0,7,9,4+9i)  
  b&g  
  
  #Element wise logical OR operator
  
  b = c(T,3,2,16.5,3+4i)
  g = c(F,0,7,9,4+9i)  
  b|g  

  #Logical NOT operator
  
  z = c(0,9,T)
  !z    
  z  
  
  #logical AND operator , (not element-wise AND)

  d = c(3,9,474,0)  
  e = c(4,5,0,8)  
  d & e  #element-wise
  d && e  #logical AND operator  
  e = c(0,5,0,8)  
  
  #logical OR operator
  
  d = c(3,9,474,0)  
  e = c(4,5,0,8)  
  d | e  
  d || e    


#Assignment operator(different ways)
  
v1 = c(8,10,7)  
v2 <- c(8,10,7)
v3 <<- c(8,10,7)


#Miscellaneous operators

# 1. Collon operator

seq(50:100)

# 2. %in%

d1=10
d2=30
d = seq(1,20)
d1 %in% d
d2 %in% d
