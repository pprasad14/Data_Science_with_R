# Factors

gender = c(1,2,2,1,1,1,2,1,1,1,2)
mean(gender)  #we shouldnt find mean of gender

#Creating Factors

chests = c('gold','silver','gems','gold', 'gems','gems')
chests
types = factor(chests) #creates unique elements 
types

as.integer(types)

###simplest form of factor function
gender = c(1,1,2,2,1,1,2,1,2,1,2,2,2,1)
gender = factor(gender)
gender

# ideal form of factor fuction

gender = factor(gender,level = c(1,2), labels = c('male','female'))
gender
table(gender)


#Access Components of a Factor

d = factor(c('single','married','single','married'))
d
d = factor(c('single','married','single','married'), levels = c('single','married','divorced'))
d


#structure

str(d)


d = factor(c('single','married','single','married'))
d[-1]


#logical vector

d[c(T,F,T,T)]
d
d[-2]



#modify a factor

d = factor(c('single','married','single','married'), levels = c('single','married','divorced'))
d[3]='divorced'
d
d[3] = 'widowed'

d
levels(d)[4]<-"Widowed"


#adding a new level

levels(d)= c(levels(d), 'dead')
d


#Generate Factor Levels

v = gl(4,5,labels = c('mumbai','surat','bangalore','pune'))  # 4 levels, repeated 5 times
v



