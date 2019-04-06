## apply

#apply(x, margin , function)
# x is data
# margin = if 1 then row, if 2 then column

data = read.table(text = "
                  D E F
                  6 5 0
                  6 3 NA
                  6 1 5
                  8 5 3
                  1 NA 1
                  8 7 2
                  2 0 2", header = T)
str(data)
View(data)

# calculate maximum value across rows

apply(data,1,max) # NAs would be considered as max
apply(data, 1, max, na.rm = T) # to remove NA values, and then calculate

#mean value across row
apply(data, 1, mean, na.rm = T)


#calculate no of 0's in each row

apply(data == 0, 1, sum, na.rm = T)


# calculate no of values greater than or equal to 5 in each row

apply(data>=5,1,sum, na.rm=T)

#select all rows having mean greater than or equal to 4

data[apply(data,1,mean,na.rm=T)>=4,]

apply(data,1,mean,na.rm=T)>4


#remove rows with NA's, method 1

d2 = na.omit(data)
d2

#removes rows with  NA's, method 2

g2 = apply(data,1,function(x){any(is.na(x))})
g2

d3 = data[!g2,]
d3

#####

y = "http://archive.ics.uci.edu/ml/machine-learning-databases/flags/flag.data"

flags = read.table(y, header = F, sep = ",")
View(flags)

names(flags) <- c("country", "landmass", "zone", "area", "population", "language",
                  "religion", "bars", "stripes", "colors", "red", "green", "blue",
                  "gold", "white", "black", "orange","mainhue", "circles", "crosses",
                  "saltires", "quarters", "sunstars", "crescents", "triangle", "icon",
                  "animate", "text", "topleft", "botright")

head(flags)
dim(flags)
str(flags)


## apply() funtions

# lapply()   : lapply(list, function) , l = list

class(flags)
class_list = lapply(flags,class)  #gets the class of each attribute
class_list

class(class_list)


#list can be simplified into a character vector

as.character(class_list)


# sapply()  s = simplify

class_vect = sapply(flags,class)
class_vect
class(class_vect)

#total flags with orange color

sum(flags$orange)

#subset

flag_color = flags[,11:17]
flag_color

#find the total no of flags using each color
sum_col = lapply(flag_color,sum) 
sum_col

# column mean

col_mean = sapply(flag_color,mean)
col_mean

lapply(flag_color,mean)

# shapes of flags

flags_shapes = flags[,19:23]
flags_shapes

#find range of shapes of flags

lapply(flags_shapes,range)


# vapply() and tapply()

# vapply(x, fun, fun.value)

vap = vapply(flags, class, character(1))
class(vap)

sapply(flags,class)


# tapply()

# tapply(x,factor,fun)

table(flags$animate)

table(flags$landmass)

tapply(flags$animate, flags$landmass, mean)

##

tapply(flags$population, flags$red, summary)

object.size(flags)  #to check memory
