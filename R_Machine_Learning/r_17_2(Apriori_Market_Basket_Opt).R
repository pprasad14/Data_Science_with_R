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


# Train Apriori Model on dataset

rules = apriori(dataset)
#note: writing ... [0 rule(s)] done [0.00s].

#ex: for 3*7/7500; 3 products sold everyday

rules = apriori(data = dataset,
                parameter = list(support = 0.003,
                                 confidence = 0.8))
# still no rules



#reduce confidence

rules = apriori(data = dataset,
                parameter = list(support = 0.003,
                                 confidence = 0.4))  # 281 rules with confidence 0.4



inspect(sort(rules, by = "lift")[1:10])  #first 10 rules only

#[1]  {mineral water,whole wheat pasta}           => {olive oil}         0.003866151 0.4027778  6.115863 29
# 40% chance that people who bought {mineral water,whole wheat pasta} will buy {olive oil} 



#reduce confidence again 

rules = apriori(data = dataset,
                parameter = list(support = 0.003,
                                 confidence = 0.2)) # 1348 rules with confidence 0.2


inspect(sort(rules, by = "lift")[1:10])  #first 10 rules only


#increase support

rules = apriori(data = dataset,
                parameter = list(support = 0.004,
                                 confidence = 0.2)) # 811 rules with confidence 0.2 and support 0.004


inspect(sort(rules, by = "lift")[1:10])  #first 10 rules only

# lower support and lower confidence is good, but it depends on people


##############


# visualizing results

library(arulesViz)

plot(rules, method = "graph")
plot(rules, method = "graph", interactive = T, max = 10) # will open separately

#another visualization method using different package


library(arules)
library(arulesViz)

install.packages("visNetwork")
library(visNetwork)
library(igraph)


data("Groceries")
rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))

subrules2 <- head(sort(rules, by="lift"), 10)

ig <- plot( subrules2, method="graph", control=list(type="items") )


#saveAsGraph seems to render bad DOT for this case
tf <- tempfile( )
saveAsGraph( subrules2, file = tf, format = "dot" )

#clean up temp file if desired
unlink(tf)

#let's bypass saveAsGraph and just use our igraph
ig_df <- get.data.frame( ig, what = "both" )

#to visualize another way:
visNetwork(nodes = data.frame(id = ig_df$vertices$name
                  ,value = ig_df$vertices$support # could change to lift or confidence
                  ,title = ifelse(ig_df$vertices$label == "",ig_df$vertices$name, ig_df$vertices$label)
                  ,ig_df$vertices
                  )
          , edges = ig_df$edges
          ) %>%

visEdges( arrows = "from" ) %>%
visOptions( highlightNearest = T )

