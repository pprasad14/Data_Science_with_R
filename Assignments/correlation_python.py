import pandas as pd
mydata = pd.read_csv("C:\\x\\Docs\\Rstudio weekday(Divyang)\\Imurgence_Assignments\\Diabetes.csv")

def correlation(data, variable):
    n_rows = data.shape[0]
    n_cols = data.shape[1]
    
    def corr(x,y):
        sum_x = sum(x)
        sum_y = sum(y)
        sum_xy = sum(x*y)
        sum_x2 = sum(x*x)
        sum_y2 = sum(y*y)
        return (((n_rows*sum_xy) - (sum_x*sum_y))/((n_rows*sum_x2 - sum_x*sum_x)*(n_rows*sum_y2 - sum_y*sum_y))**0.5)
    
    cor_matrix = pd.DataFrame(index=data.columns, columns=data.columns)
    
    for i in range(0,n_cols):
        for j in range(0,n_cols):
            cor_matrix.iloc[i,j] = corr(data.iloc[:,i], data.iloc[:,j])
    
    temp = cor_matrix.loc[:,variable]
    #temp = temp[temp!=1]
    print(temp.sort_values(ascending = False)[1:4])
   
correlation(mydata,"Insulin")