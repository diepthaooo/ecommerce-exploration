-- Calculate total visit, pageview, transaction and revenue for Jan, Feb and March 2017 order by month
SELECT
    format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
    sum(totals.visits) visits, 
    sum(totals.pageviews) pageviews,
    sum(totals.transactions) transactions,
    sum(totals.totalTransactionRevenue)/1000000 revennue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _table_suffix between '20170101' and '20170331'
GROUP BY month
ORDER BY month