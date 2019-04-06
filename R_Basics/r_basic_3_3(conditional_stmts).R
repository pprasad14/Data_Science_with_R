#####

#Conditional Statements

#if statements

f = 67
class(f)
if(is.integer(f))
  print("integer")

d = 50
f = 15

if((d+f)>90)
  print("greater")


## if else stmt

d = 20
f=25
if((d+f)>50){
  print('sum is greater than 50')
} else if((d+f)>40){
  print('greater than 40')
} else{
  print('less than 45')
}

x = 10
if(x>0) print('positive') else print('negative')

if(x>0){
  print('positive')
} else{
  print('negative')
}


###
# Switch Cases

d = switch(8,
  '1' ='one',
  '2'= 'tow',
  '3'='three',
  '4'= 'four',
  '5'= 'five'
)
d

###
#loops

#repeat loop

v = c('prem','prasad','is','good')
count = 4
repeat{
  print(v)
  count = count+1
  if(count>8){
    break
  }
}

x = 7
repeat{
  print(x)
  x = x+3
  if(x>50){
    break
  }
}


## while loop

v = c('good','afternoon')
count = 2
while(count<9){
  print(v)
  count=count + 1
}


## for loops

g = letters[1:10]
for(i in g)
  print(i)

for(x in 1:3){    
  print(x)
  print(x+1)
}  

for(x in 1:3)    
{  print(x)
  print(x+1)
} 

roll_no = c(1,2,3,4,5)
name = c('prem','jui','arun','vineeth','instructor')
physics = c(40,80,45,67,88)
chemistry = c(33,44,55,66,77)
math = c(23,34,45,67,78)
total = c(NA)
grade = c(NA)

info = data.frame(roll_no,name,physics,chemistry,math,total,grade)
info
for(i in 1:5){
  info$total[i]=info$math[i] + info$chemistry[i] + info$physics[i]
  if(info$total[i]>150){
    info$grade[i]='good'
  } else{
    info$grade[i]='bad'
  }
}
info
