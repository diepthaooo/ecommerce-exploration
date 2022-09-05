-- Products purchased by customers who purchased product A (Classic Ecommerce)
SELECT product.v2ProductName other_purchased_products, 
  sum(product.productQuantity) quantity
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
UNNEST (hits) hits,
UNNEST (hits.product) product
WHERE fullVisitorId IN 
  (SELECT DISTINCT fullVisitorId 
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST (hits) hits,
  UNNEST (hits.product) product
  WHERE product.v2ProductName = "YouTube Men's Vintage Henley"
   and totals.totalTransactionRevenue IS NOT NULL
   and hits.eCommerceAction.action_type = '6' 
  GROUP BY fullVisitorId)
and product.productRevenue IS NOT NULL
and totals.totalTransactionRevenue IS NOT NULL
and product.v2ProductName != "YouTube Men's Vintage Henley"
GROUP BY other_purchased_products
ORDER BY quantity DESC