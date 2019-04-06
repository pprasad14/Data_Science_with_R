data = read.table("log_sim.csv", header = T, sep = ",")
data

data$Prob = data$Yes/(data$No + data$Yes)
data

data$Odds = data$Yes/data$No
data

data$Log_Odds = log(data$Odds)
data

plot(data$Age, data$Prob)
plot(data$Age, data$Odds)
plot(data$Age, data$Log_Odds)

#for linear model:

lin_mod = lm(Log_Odds ~ Age, data = data) 
summary(lin_mod)

plot(data$Age, data$Log_Odds,
     xlim = c(0,40),
     ylim = c(-20,30),
     xlab = "X",
     ylab = "Log_Odds")

abline(lin_mod)

data$calc = data$Age*lin_mod$coefficients[2] + lin_mod$coefficients[1]
data
plot(data$Age, data$calc)
