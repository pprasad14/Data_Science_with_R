#  Matrix
?matrix
help(matrix)
matrix()

matrix(6)
matrix(6,3,5)

g = 1:20
g
b = matrix(g, 4,5)  #byrow is False
b
class(b)

t = matrix(g, 4,5, byrow = T)  #by row
t


# Reshaping a Vector into a Matrix

pass = 1:20


      #dim() to convert vector to matrix

dim(pass)= c(5,4)  #changing the dimensions of pass 
pass
dim(pass)   #dimension of matrix




##Matrix Access

pass[3,4]  #3rd row 4th column
pass[5]   # 5th element
pass[2,]  #prints whole 2nd row
pass [,3] #prints whole 3rd column
pass[,]  #prints whole matrix


#changing values

pass[2,3]=45
pass


#matrix[rows,columns]
 
x = matrix(1:12,3)  # 3 will default to no of rows, and no. of cols will be computed internally
x

#select rows 1 and 2 and col 2 and 3
x[c(1,2),c(2,3)]
x[-1,]  #selects all rows except first
class(x[1,])


#getting result as matrix rather than vector

x[1,] #is vector
x[1,,drop=F]  #is matrix, if drop = T, then it drops the dim of an array which have only one level
class(x[1,,drop=F])


#####

matrix(1:9, 3,3)

# same result by providing one dimension

matrix(1:9, 3, byrow = T)


x= matrix(1:12,3,dimnames = list(c('x','y','z'), c('a','b','c','d')))
x
x['y',]


# rownames() or colnames()

rownames(x)
colnames(x)


#change names 

colnames(x) = c('c1','c2','c3','c4')
rownames(x) = c('r1','r2','r3')
x

colnames(x)[3]='r' #changing particular column name
colnames(x)  



# rbind() ,  cbind()

cbind(c(2,4,6),c(7,3,6))
v = rbind(c(2,4,6),c(7,3,6))
v
v2 = c('c1','c2','c3')
f = rbind(v2,v)
f


#  %*% operator

m = matrix(c(3,4,5,6,7,8),2)
m

  #transpose
  t(m)
  m %*% t(m)  