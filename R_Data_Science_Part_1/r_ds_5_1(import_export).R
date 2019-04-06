##Import Dataset

#to use \, use \\, else use /
file = read.csv("C:\\Users\\Prem Prasad\\Desktop\\Rstudio weekday\\R_Basics\\Data.csv")
View(file)

str(file)

getwd()

file2 = read.csv("Data.csv")  #can be used only if current working directory has Data.csv


##Export Dataset

file
write.csv(file,"file_write.csv")  #row names is appended automatically
write.csv(file, "file2_write.csv", row.names = F)  #to disable automatic row naming


