# Eclat

# Apriori of market basket optimisation

#install.packages("arules")
#install.packages('arulesViz')  #for visualization

dataset = read.csv("market_basket_optimisation.csv", header = F)

#Sparse matrix

library(arules)

dataset = read.transactions("Market_Basket_Optimisation.csv", sep = ",",
                            rm.duplicates = T)
# 5 transactions with 1 duplicates


summary(dataset)

colnames(dataset)  # all unique items


# item frequency

itemFrequencyPlot(dataset, topN = 100)  # top 100 items sold
itemFrequencyPlot(dataset, topN = 10)  # top 10 items sold


# Train Eclat Model on dataset

rules = eclat(data = dataset,
              parameter = list(support = 0.003, minlen = 2))

inspect(sort(rules, by = "support")[1:10])



rules = eclat(data = dataset,
              parameter = list(support = 0.003, minlen = 3))

inspect(sort(rules, by = "support")[1:10])
