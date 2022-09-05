-- Calculate cohort map from pageview to addtocart to purchase in last 3 month.
with productview as(
  SELECT  
    format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
    COUNT(product.v2ProductName) num_product_view
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
  UNNEST (hits) hits,
  UNNEST (hits.product) product
  WHERE _table_suffix between '20170101' and '20170331'
  and hits.ecommerceaction.action_type = '2'
  GROUP BY month
),
addtocart as(
  SELECT  
    format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
    COUNT(product.v2ProductName) num_addtocart
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
  UNNEST (hits) hits,
  UNNEST (hits.product) product
  WHERE _table_suffix between '20170101' and '20170331'
  and hits.ecommerceaction.action_type = '3'
  GROUP BY month
),
purchase as(
  SELECT  
    format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
    COUNT(product.v2ProductName) num_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
  UNNEST (hits) hits,
  UNNEST (hits.product) product
  WHERE _table_suffix between '20170101' and '20170331'
  and hits.ecommerceaction.action_type = '6'
  GROUP BY month
)
SELECT
  pv.month,
  num_product_view,
  num_addtocart,
  num_purchase,
  round(((num_addtocart/num_product_view)*100),2) add_to_cart_rate,
  round(((num_purchase/num_product_view)*100),2) purchase_rate
FROM productview pv 
JOIN addtocart atc ON pv.month = atc.month
JOIN purchase p ON pv.month = p.month

												
ORDER BY month