## R Functions

#create functions
#create a function to print square of nums in seq

hexa <- function(d){
  for(i in 1:d){
    g= i^2
    print(g)
  }
}

hexa(10)

# call funtion without arg

gt <- function(){
  for(i in 1:10){
    print(i^2)
  }
}

gt()


# calling a function with argument values(by position and name)

hexa = function(e,f,g,h){
  res = e*f + g/h
  print(res)
}
hexa(11,4,6,2) # postion matters

hexa(h=2,e=11,g=6,f=4) #position does not matter


# calling a function with default arguments

beta = function(d=5,e=8){
  res = d^e
  print(res)
}
beta()  #ans will be 5^8
beta(2) #ans will be 2^8


# Lazy evaluation of a funtion, when default values not given

vp = function(f,g){
  print(f^3)
  print(f)
  print(g)
}

vp(3,4)
vp(4)


#function for hypotenuse

h =  function(a=1,b=1){
  print(sqrt(a^2 + b^2))
}

h(4,5)

# power of function

pow = function(a,b){
  res = a^b
  print(paste(a,"raised to",b,"is",res))
}

pow(2,3)


# function to print square for -ve no, cube for 1 and 2, and power 4 for others

f = function(x){
  if(x<0) print(x^2)
  else if(x<3) print(x^3)
  else print(x^4)
}

#shorter code

f = function(x){
  ifelse(x<0,x^2,ifelse(x<3,x^3,x^5))
}
f(-2)
f(2)
f(3)


#Homework
#create a calculator function

calc = function(a,b,c){
  if(b=='+') print(paste(('sum is'),(a+c)))
  else if(b=='-') print(paste(('difference is'),(a-c)))
  else if(b=='*') print(paste(('product is'),(a*c)))
  else {
    if (c==0) print('divide by zero error')
    else print(paste(('division is'),(a/c)))
  }
}

calc(2,"+",3)
calc(2,"-",3)
calc(2,"*",3)
calc(2,"/",3)

#using input from user

input = readline('enter expression with space,ex:1 + 2:  ')
temp = unlist(strsplit(input," ")) # strsplit(input," ") returns a list, so use unlist 
temp
calc(as.integer(temp[1]),temp[2],as.integer(temp[3]))
