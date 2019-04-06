# Lists

#list()

x = list('a'=25, 'b'=F, 'c'=1:8, 'd'='hello')
x
class(x)


#list without tags

u = list(23,T,1:10,'heloo')  #does not change datatypes of elements like c() does
u

str(x)
dim(x)

u = c(23,T,1:10,'heloo') #converts all to string
u



#Accessing components of list

x = list('Name'='surat', 'Age'= 30, 'Speaks'= c('hindi','english','french'))
x


#integer vector

x[c(1:2)]


#logical vector

x[c(T,T,F)]
str(x)



#indexing using character vector

x[c('Name','Age')]


## []   gives sublist not content, returns a list
## [[]]  gives content, returns the contents of the list

x['Speaks']  #class list
typeof(x['Age'])
x[['Speaks']]   #class character


#alternative for [[]] is  $ operator

x$Name


#Partial Matching

x$A
x$Speaks[3]


#modify a list

x$Name = 'Prem'
x
x$vehicle = T
x


#deleting components of list

x$Age = NULL
x$vehicle = NULL


x$Age = '30'
x$Age[] = NA   #only nulls the value, not delete Age
x
