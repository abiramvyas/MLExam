library(arules)
# List of available products
products <- c('beauty', 'electronics', 'fashion', 'books', 'groceries', 'home', 'hygiene-beauty')

set.seed(123)

basket <- list()
for (i in 1:30) {
  # Out of 7 values, on random, get the basket size
  n_products <- sample(1:7, 1)
  print(n_products)
  # Now for the random value of n_products, get that many items from the list of available products (on random)
  txn <- sample(products, n_products, replace = FALSE)
  # Store the list of transactions in the basket list
  basket[[i]] <- txn
}

# Convert the list of txns into the transaction data type
library(arules)
basket <- as(basket, "transactions")

# Inspect the transactions
inspect(basket)


rules <- apriori(basket, parameter = list(support = 0.3, confidence = 0.75))

rules_filtered <- subset(rules, length(lhs) > 0) # Avoiding nulls in the LHS.
rules_filtered <- sort(rules_filtered, by = 'support', decreasing = TRUE)

#Goal is to recommend the RHS products based on the LHS products according the support and confidence

# Inspect the top 10 rules
inspect(rules_filtered[1:10])

