# Groceries Data Set

library(arules)
library(arulesViz)

data("Groceries")  # present in arules library
str(Groceries)


#to check basket

inspect(Groceries)   # prints all the transactions. 
#ie all 9835 transactions with items bought on that transaction

###########
#take random values

g_rules = apriori(Groceries)  # 0 rules

g_rules = apriori(Groceries, parameter = list(support = 0.1,
                                              confidence = 0.8)) # still 0 rules

g_rules = apriori(Groceries, parameter = list(support = 0.01,
                                              confidence = 0.8)) # still 0 rules

g_rules = apriori(Groceries, parameter = list(support = 0.001,
                                              confidence = 0.8))  # now, 410 rules

inspect(g_rules[1:10])  # to see top 10 rules

g_rules = sort(g_rules, by = "support", decreasing = T)


# remove duplicates rules using: is.redundant()

g_rules  # set of 410 rules

red_rules = is.redundant(g_rules)

red_rules

summary(red_rules)  # there are 18 duplicates

g_rules = g_rules[!red_rules]

g_rules  #now 392 rules 

inspect(g_rules[1:5])


####################

# with product x, what other products bought??
# rhs and lhs

# for bottled beer:
g_rules_beer = apriori(Groceries, parameter = list(support = 0.001,
                                              confidence = 0.8),
                       appearance = list(default = "rhs", lhs = "bottled beer")) # 0 rules


#0 rules, so decrease confidence
g_rules_beer = apriori(Groceries, parameter = list(support = 0.001,
                                                   confidence = 0.08),
                       appearance = list(default = "rhs", lhs = "bottled beer")) # 22 rules


inspect(g_rules_beer[1:5])


# for bottled milk:
g_rules_milk = apriori(Groceries, parameter = list(support = 0.001,
                                                   confidence = 0.8),
                       appearance = list(default = "rhs", lhs = "whole milk")) # 0 rules


#0 rules, so decrease confidence
g_rules_milk = apriori(Groceries, parameter = list(support = 0.001,
                                                   confidence = 0.08),
                       appearance = list(default = "rhs", lhs = "whole milk")) # 35 rules


inspect(g_rules_milk[1:5])


# plot

library(arulesViz)

plot(g_rules_milk, method = "graph", interactive = T, max = 5) # prints top 5 wrt support
