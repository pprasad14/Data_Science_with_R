corr = function(df,colm){
  max_cor = c(0.0001,0.0002,0.0003)
  names(max_cor) = c("abc", "def", "ghi")
  cor_df = data.frame(matrix(1, nrow = ncol(df)))
  
    for(coly in names(df)){
      new_cor = 0
        A1 = nrow(df)*sum((df[colm] * df[coly]));
        A2 = sum(df[colm]);
        B1 = sum(df[coly]);
        B2 = nrow(df)*sum(df[colm] * df[colm]);
        C = nrow(df)*sum(df[coly] * df[coly]);
        
        cor = (A1 - A2*B1) / (sqrt( ( B2 - (A2)^2)*(C - (B1)^2) ));
        cor_df[1,coly] = cor;
        new_cor = abs(cor)
      
      if(new_cor >= min(max_cor) && new_cor!= 1){
        max_cor = replace(max_cor, max_cor==min(max_cor), new_cor);
        names(max_cor)[max_cor==new_cor] = paste(colm, coly)
      }
  }
  
  
  return (max_cor)
}

cor(Boston)

#INPUT

library(MASS)
data("Boston")

corr(Boston,"medv")
