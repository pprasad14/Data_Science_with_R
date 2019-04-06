data("mtcars")
data = mtcars[,]
str(data)

correlation = function(data,variable){
  n_rows = nrow(data)
  n_cols = ncol(data)
  
  cor = function(x,y){
    sum_x = sum(x)
    sum_y = sum(y)
    sum_xy = sum(x*y)
    sum_x2 = sum(x*x)
    sum_y2 = sum(y*y)
    return (((n_rows*sum_xy) - (sum_x*sum_y))/sqrt((n_rows*sum_x2 - sum_x^2)*(n_rows*sum_y2 - sum_y^2)))
  }
  
  cor_matrix = matrix(,nrow = n_cols,ncol = n_cols)
  
  for(i in 1:n_cols){
    for(j in 1:n_cols){
      cor_matrix[i,j] = cor(data[,i],data[,j])
    }
  }
  colnames(cor_matrix)=colnames(data)
  rownames(cor_matrix)=colnames(data)
  #print(cor_matrix)
  temp = cor_matrix[,variable]
  temp = temp[temp!=1]  # to remove 1 from vector
  cat("\n")
  #print(temp)
  sorted = temp[order(abs(temp),decreasing = T)] # sort according to abs value
  print(sorted[1:3])
}

correlation(data,"cyl")
